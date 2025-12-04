-- Enum: Id do produto, quantidade do produto
CREATE TYPE ItemPedidoInfo_v2 AS (
    id_produto INT,
    quantidade INT
);

-- Procedure: Cria um pagamento inicial com status PENDENTE
CREATE OR REPLACE PROCEDURE inserir_pagamento(
    p_metodo_pagamento TipoPagamentoMetodo,
    OUT v_id_pagamento INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO Pagamento (metodo_pagamento, status_pagamento, data_pagamento) 
    VALUES (p_metodo_pagamento, 'PENDENTE', NULL) 
    RETURNING id_pagamento INTO v_id_pagamento;
END $$;

-- Trigger: Liberar o pedido criado (para status EM_PROCESSAMENTO) quando o pagamento do pedido for alterado
-- Aqui garante que o pedido so vai ser feito se o pagamento for efetuado antes.
CREATE OR REPLACE FUNCTION fn_libera_pedido_por_pagamento()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.status_pagamento = 'APROVADO' AND OLD.status_pagamento <> 'APROVADO' THEN

    UPDATE Pedido
        SET status_pedido = 'EM_PROCESSAMENTO'
        WHERE id_pagamento = NEW.id_pagamento
        AND status_pedido IN ('CRIADO', 'EM_PROCESSAMENTO');


    ELSIF NEW.status_pagamento = 'REJEITADO' AND OLD.status_pagamento <> 'REJEITADO' THEN
        UPDATE Pedido
        SET status_pedido = 'CANCELADO'
        WHERE id_pagamento = NEW.id_pagamento
        AND status_pedido NOT IN ('CANCELADO', 'CONCLUIDO');
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER trg_pagamento_libera_pedido
AFTER UPDATE OF status_pagamento ON Pagamento
FOR EACH ROW
EXECUTE FUNCTION fn_libera_pedido_por_pagamento();

-- Processa novo pedido
    --> Validação do Pagamento
    --> Verificação de Estoque e Cálculo
    --> Criação do Pedido
    --> Processamento dos Itens e Baixa de Estoque
    --> Registro da Entrega
CREATE OR REPLACE PROCEDURE processar_novo_pedido(
    p_id_cliente INT,
    p_id_pagamento INT,
    p_id_funcionario_atendimento INT,
    p_id_funcionario_entrega INT,
    p_taxa_entrega DECIMAL(10, 2),
    p_previsao_entrega INTERVAL,
    p_lista_itens ItemPedidoInfo_v2[],
    OUT p_total_calculado DECIMAL(10, 2),
    p_observacao VARCHAR DEFAULT NULL
    )
LANGUAGE plpgsql
AS $$
DECLARE
    v_id_pedido INT;
    v_id_entrega INT;
    v_valor_itens DECIMAL(10, 2) := 0.00;
    v_total_pedido DECIMAL(10, 2);

    v_registro_item ItemPedidoInfo_v2;
    v_status_pedido TipoPedidoStatus;
    v_estoque_atual INT;
    v_preco_unitario DECIMAL(10, 2);
    v_status_pagamento TipoPagamentoStatus;
    v_metodo_pagamento TipoPagamentoMetodo;
    v_status_entrega TipoEntregaStatus := 'PREPARANDO';
BEGIN
    SELECT status_pagamento, metodo_pagamento
    INTO v_status_pagamento, v_metodo_pagamento
    FROM Pagamento
    WHERE id_pagamento = p_id_pagamento;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Pagamento com ID % não encontrado. Pedido cancelado.', p_id_pagamento;
    END IF;

    v_status_pedido := 'CRIADO';

    IF p_lista_itens IS NULL OR array_length(p_lista_itens, 1) IS NULL THEN
        RAISE EXCEPTION 'Nenhum item informado para o pedido.';
    END IF;

    FOREACH v_registro_item IN ARRAY p_lista_itens
    LOOP
        SELECT estoque_atual, preco_venda
        INTO v_estoque_atual, v_preco_unitario
        FROM Produto 
        WHERE id_produto = v_registro_item.id_produto;

        IF NOT FOUND THEN
            RAISE EXCEPTION 'Produto com ID % não encontrado. Pedido cancelado.',
                v_registro_item.id_produto;
        END IF;

        IF v_registro_item.quantidade <= 0 THEN
            RAISE EXCEPTION 'Quantidade inválida (%). Deve ser maior que zero.',
                v_registro_item.quantidade;
        END IF;

        IF v_estoque_atual < v_registro_item.quantidade THEN
            RAISE EXCEPTION
                'ESTOQUE INSUFICIENTE: Produto % requer %, mas estoque é %.',
                v_registro_item.id_produto,
                v_registro_item.quantidade,
                v_estoque_atual;
        END IF;

        v_valor_itens := v_valor_itens + (v_registro_item.quantidade * v_preco_unitario);
    END LOOP;

    v_total_pedido := v_valor_itens + p_taxa_entrega;
    p_total_calculado := v_total_pedido;

    INSERT INTO Pedido (
        id_cliente,
        id_pagamento,
        id_funcionario,
        data_pedido,
        status_pedido,
        total_pedido,
        valor_itens,
        taxa_entrega,
        observacao
    )
    VALUES (
        p_id_cliente,
        p_id_pagamento,
        p_id_funcionario_atendimento,
        CURRENT_TIMESTAMP,
        v_status_pedido,
        v_total_pedido,
        v_valor_itens,
        p_taxa_entrega,
        p_observacao
    )
    RETURNING id_pedido INTO v_id_pedido;

    FOREACH v_registro_item IN ARRAY p_lista_itens
    LOOP
        SELECT preco_venda INTO v_preco_unitario
        FROM Produto
        WHERE id_produto = v_registro_item.id_produto;

        INSERT INTO ItemPedido (id_produto, id_pedido, quantidade, preco)
        VALUES (v_registro_item.id_produto, v_id_pedido, v_registro_item.quantidade, v_preco_unitario);

        UPDATE Produto
        SET estoque_atual = estoque_atual - v_registro_item.quantidade
        WHERE id_produto = v_registro_item.id_produto;

        INSERT INTO AuditoriaEstoqueProduto (
            id_produto,
            tipo_movimento,
            quantidade,
            data,
            motivo
        )
        VALUES (
            v_registro_item.id_produto,
            'SAIDA',
            v_registro_item.quantidade,
            CURRENT_TIMESTAMP,
            'Reserva Pedido ID ' || v_id_pedido || ' (Pagamento PENDENTE)'
        );
    END LOOP;

    INSERT INTO Entrega (
        id_funcionario_entrega,
        id_pedido,
        previsao_entrega,
        status_entrega
    )
    VALUES (
        p_id_funcionario_entrega,
        v_id_pedido,
        CURRENT_TIMESTAMP + p_previsao_entrega,
        v_status_entrega
    )
    RETURNING id_entrega INTO v_id_entrega;

END $$;

-- Pedido 1:
    -- X-Salada
    -- Refrigerante
DO $$ 
DECLARE 
    v_id_pagamento_1 INT;
    v_total_calculado DECIMAL(10, 2);
BEGIN
    CALL inserir_pagamento('CARTAO', v_id_pagamento_1);

    CALL processar_novo_pedido(
        p_id_cliente := 50, 
        p_id_pagamento := v_id_pagamento_1,
        p_id_funcionario_atendimento := 1, 
        p_id_funcionario_entrega := 1,
        p_taxa_entrega := 5.00,
        p_previsao_entrega := interval '45 minutes',
        p_lista_itens := ARRAY[
        ROW(100, 1)::ItemPedidoInfo_v2,
        ROW(101, 1)::ItemPedidoInfo_v2
        ],
        p_observacao := 'Entregue na portaria.',
        p_total_calculado := v_total_calculado
    );

    RAISE NOTICE 'Total calculado: %', v_total_calculado;
    
    UPDATE Pagamento 
    SET status_pagamento = 'APROVADO', data_pagamento = CURRENT_TIMESTAMP 
    WHERE id_pagamento = v_id_pagamento_1;
    
END $$;

-- Pedido 2:
    -- Porção de Nuggets
    -- Refrigerante Cola
DO $$ 
DECLARE 
    v_id_pagamento_1 INT;
    v_total_calculado DECIMAL(10, 2);
BEGIN
    CALL inserir_pagamento('CARTAO', v_id_pagamento_1);

    CALL processar_novo_pedido(
        p_id_cliente := 50, 
        p_id_pagamento := v_id_pagamento_1,
        p_id_funcionario_atendimento := 1, 
        p_id_funcionario_entrega := 1,
        p_taxa_entrega := 5.00,
        p_previsao_entrega := interval '45 minutes',
        p_lista_itens := ARRAY[
            ROW(124, 1)::ItemPedidoInfo_v2,
            ROW(101, 1)::ItemPedidoInfo_v2
        ],
        p_observacao := 'Entregue na portaria. Pedido com Nuggets.',
        p_total_calculado := v_total_calculado
    );

    RAISE NOTICE 'Total calculado: %', v_total_calculado;
    
    UPDATE Pagamento 
    SET status_pagamento = 'APROVADO', data_pagamento = CURRENT_TIMESTAMP 
    WHERE id_pagamento = v_id_pagamento_1;
    
END $$;

-- Pedido 3:
    -- Brownie com Sorvete
    -- Refrigerante Cola
DO $$ 
DECLARE 
    v_id_pagamento_1 INT;
    v_total_calculado DECIMAL(10, 2);
BEGIN
    CALL inserir_pagamento('PIX', v_id_pagamento_1);

    CALL processar_novo_pedido(
        p_id_cliente := 50, 
        p_id_pagamento := v_id_pagamento_1,
        p_id_funcionario_atendimento := 1, 
        p_id_funcionario_entrega := 1,
        p_taxa_entrega := 5.00,
        p_previsao_entrega := interval '45 minutes',
        p_lista_itens := ARRAY[
            ROW(119, 1)::ItemPedidoInfo_v2,
            ROW(101, 1)::ItemPedidoInfo_v2 
        ],
        p_observacao := 'Entregue na portaria. Pedido com Brownie.',
        p_total_calculado := v_total_calculado
    );

    RAISE NOTICE 'Total calculado: %', v_total_calculado;
    
    UPDATE Pagamento 
    SET status_pagamento = 'APROVADO', data_pagamento = CURRENT_TIMESTAMP 
    WHERE id_pagamento = v_id_pagamento_1;
    
END $$;