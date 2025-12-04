CREATE TYPE InsumoProducao AS (
    id_insumo INT,
    quantidade_por_unidade DECIMAL(10, 4) 
);

-- Procedure de produção de produtos
CREATE OR REPLACE PROCEDURE prc_processar_producao_dinamica(
    p_id_produto_fabricado INT,
    p_id_funcionario INT,
    p_quantidade_planejada INT,
    p_quantidade_real INT, 
    p_lista_insumos InsumoProducao[]
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_id_producao INT;
    v_motivo_entrada TEXT;
    
    v_registro_insumo InsumoProducao; 
    
    v_quantidade_consumida DECIMAL(10, 4);
    v_quantidade_consumida_int INT;
    
    v_estoque_atual INT;
    v_nome_insumo VARCHAR(255);
    v_nome_produto VARCHAR(100);
BEGIN
    SELECT nome INTO v_nome_produto FROM Produto WHERE id_produto = p_id_produto_fabricado;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Produto com ID % não encontrado.', p_id_produto_fabricado;
    END IF;

    FOREACH v_registro_insumo IN ARRAY p_lista_insumos
    LOOP
        v_quantidade_consumida := p_quantidade_real * v_registro_insumo.quantidade_por_unidade;
        
        IF v_quantidade_consumida > 0 THEN
             v_quantidade_consumida_int := CEIL(v_quantidade_consumida);
        ELSE
             v_quantidade_consumida_int := 0;
        END IF;

        IF v_quantidade_consumida_int = 0 THEN
            CONTINUE; 
        END IF;
        
        SELECT estoque_atual, nome INTO v_estoque_atual, v_nome_insumo 
        FROM Insumo 
        WHERE id_insumo = v_registro_insumo.id_insumo;
        
        IF NOT FOUND THEN
            RAISE EXCEPTION 'Insumo com ID % não encontrado. Produção cancelada.', v_registro_insumo.id_insumo;
        END IF;

        IF v_estoque_atual < v_quantidade_consumida_int THEN
            RAISE EXCEPTION 'ESTOQUE INSUFICIENTE: O insumo "%" (ID %) requer % unidades, mas o estoque atual é de % unidades. Produção cancelada.', 
            v_nome_insumo, v_registro_insumo.id_insumo, v_quantidade_consumida_int, v_estoque_atual;
        END IF;
        
    END LOOP;
    
    INSERT INTO Producao (id_produto_fabricado, id_funcionario, quantidade_planejada, quantidade_real, status_producao)
    VALUES (p_id_produto_fabricado, p_id_funcionario, p_quantidade_planejada, p_quantidade_real, 'FEITO')
    RETURNING id_producao INTO v_id_producao;

    FOREACH v_registro_insumo IN ARRAY p_lista_insumos
    LOOP
        v_quantidade_consumida := p_quantidade_real * v_registro_insumo.quantidade_por_unidade;
        
        IF v_quantidade_consumida > 0 THEN
             v_quantidade_consumida_int := CEIL(v_quantidade_consumida);
        ELSE
             v_quantidade_consumida_int := 0;
        END IF;

        IF v_quantidade_consumida_int = 0 THEN
            CONTINUE; 
        END IF;
        
        INSERT INTO ItemInsumo (id_insumo, id_producao, quantidade) 
        VALUES (v_registro_insumo.id_insumo, v_id_producao, v_quantidade_consumida_int);

        UPDATE Insumo SET estoque_atual = estoque_atual - v_quantidade_consumida_int
        WHERE id_insumo = v_registro_insumo.id_insumo;

    END LOOP;

    v_motivo_entrada := 'Produção concluída de ' || v_nome_produto || ' (ID Prod: ' || v_id_producao || ')';

    UPDATE Produto SET estoque_atual = estoque_atual + p_quantidade_real
    WHERE id_produto = p_id_produto_fabricado;

    INSERT INTO AuditoriaEstoqueProduto (id_produto, tipo_movimento, quantidade, data, motivo)
    VALUES (p_id_produto_fabricado, 'ENTRADA', p_quantidade_real, NOW(), v_motivo_entrada);

END $$;

-- Processo de Produção de X-Salada Gourmet
-- Ingredientes:
    -- Pão de Hambúrguer
    -- Queijo Muçarela (0.001kg)
    -- Alface Americana (0.1UN)
CALL prc_processar_producao_dinamica(
    p_id_produto_fabricado := 100,
    p_id_funcionario := 3,
    p_quantidade_planejada := 50,
    p_quantidade_real := 50,
    p_lista_insumos := ARRAY[
    (10, 1.0),
    (11, 0.2),
    (12, 0.001),
    (13, 0.1)
    ]::InsumoProducao[]
);

-- Processo de Produção de X-Bacon Simples
-- Ingredientes:
    -- Pão de Hambúrguer
    -- Queijo Muçarela (0.15kg)
    -- Carne Moída (0.18kg)
    -- Bacon (0.1kg)
CALL prc_processar_producao_dinamica(
    p_id_produto_fabricado := 102,
    p_id_funcionario := 7,
    p_quantidade_planejada := 40, 
    p_quantidade_real := 40,
    p_lista_insumos := ARRAY[
        (10, 1.0),
        (12, 0.15),
        (11, 0.18),
        (21, 0.1)
    ]::InsumoProducao[]
);

-- Processo de Produção de Marmita Frango Grelhado
-- Ingredientes:
    -- Frango (0.3kg)
    -- Cebola (0.05kg)
    -- Óleo Vegetal (0.1L)
    -- Feijão (0.15kg)
    -- Arroz (0.2kg)
CALL prc_processar_producao_dinamica(
    p_id_produto_fabricado := 106,
    p_id_funcionario := 3,
    p_quantidade_planejada := 30, 
    p_quantidade_real := 30,
    p_lista_insumos := ARRAY[
        (18, 0.3),
        (19, 0.05),
        (15, 0.1),
        (22, 0.15),
        (23, 0.2)
    ]::InsumoProducao[]
);

-- Processo de Produção de Salada Caesar -- ERRO Intencional: vai apresentar erro por falta de Alface
-- Ingredientes:
    -- Alface Americana (0.2UN)
    -- Tomate (0.15kg)
    -- Molho Caesar (0.1L)
CALL prc_processar_producao_dinamica(
    p_id_produto_fabricado := 107,
    p_id_funcionario := 7,
    p_quantidade_planejada := 20, 
    p_quantidade_real := 20,
    p_lista_insumos := ARRAY[
        (13, 0.2),
        (14, 0.15),
        (24, 0.1) 
    ]::InsumoProducao[]
);

-- Processo de Produção de Burger Vegano
-- Ingredientes:
    -- Pão de Hambúrguer
    -- Cebola (0.05kg)
CALL prc_processar_producao_dinamica(
    p_id_produto_fabricado := 108,
    p_id_funcionario := 3,
    p_quantidade_planejada := 15, 
    p_quantidade_real := 15,
    p_lista_insumos := ARRAY[
        (10, 1.0),
        (19, 0.05)
    ]::InsumoProducao[]
);

-- Processo de produção de Batata Frita Média
-- Ingredientes:
    -- Óleo Vegetal (0.05L)
    -- Batata Inglesa (0.25kg)
CALL prc_processar_producao_dinamica(
    p_id_produto_fabricado := 103,
    p_id_funcionario := 7,
    p_quantidade_planejada := 100, 
    p_quantidade_real := 100,
    p_lista_insumos := ARRAY[
        (15, 0.05),
        (31, 0.25)
    ]::InsumoProducao[]
);

-- Processo de produção de Pudim de Leite
-- Ingredientes:
    -- Leite Condensado (0.5UN)
    -- Ovos (2UN)
    -- Leite (0.1L)
CALL prc_processar_producao_dinamica(
    p_id_produto_fabricado := 104,
    p_id_funcionario := 3,
    p_quantidade_planejada := 1, 
    p_quantidade_real := 1,
    p_lista_insumos := ARRAY[
        (25, 0.5),
        (26, 2.0), 
        (27, 0.1)
    ]::InsumoProducao[]
);

-- Processo de produção de Brownie com Sorvete
-- Ingredientes:
    -- Sorvete (0.1L)
    -- Brownie Prémix (0.2kg)
CALL prc_processar_producao_dinamica(
    p_id_produto_fabricado := 119,
    p_id_funcionario := 7,
    p_quantidade_planejada := 10, 
    p_quantidade_real := 10,
    p_lista_insumos := ARRAY[
        (28, 0.1),
        (29, 0.2)
    ]::InsumoProducao[]
);

-- Processo de produção de Porção de Nuggets
-- Ingredientes:
    -- Óleo Vegetal (0.02L)
    -- Nuggets de Frango (0.3kg)
CALL prc_processar_producao_dinamica(
    p_id_produto_fabricado := 124,
    p_id_funcionario := 3,
    p_quantidade_planejada := 15, 
    p_quantidade_real := 15, 
    p_lista_insumos := ARRAY[
        (15, 0.02),
        (30, 0.3)
    ]::InsumoProducao[]
);