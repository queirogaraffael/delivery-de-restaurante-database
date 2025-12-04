CREATE OR REPLACE FUNCTION fn_calcular_total_pedido(p_id_pedido INT)
RETURNS DECIMAL(10,2)
LANGUAGE plpgsql AS $$
DECLARE
    v_total DECIMAL(10,2);
    v_entrega DECIMAL(10,2);
BEGIN
    SELECT COALESCE(SUM(ip.quantidade * ip.preco), 0)
    INTO v_total
    FROM ItemPedido ip
    WHERE ip.id_pedido = p_id_pedido;

    SELECT COALESCE(taxa_entrega, 0)
    INTO v_entrega
    FROM Pedido
    WHERE id_pedido = p_id_pedido;

    IF NOT FOUND THEN
        RETURN NULL;
    END IF;

    RETURN v_total + v_entrega;
END;
$$;

CREATE OR REPLACE FUNCTION fn_insumos_proximos_validade()
RETURNS NUMERIC AS $$
DECLARE
    total INT;
    proximos INT;
BEGIN
    BEGIN
        SELECT COUNT(*) INTO total FROM Insumo;
    EXCEPTION
        WHEN OTHERS THEN
            RETURN 0;
    END;

    BEGIN
        SELECT COUNT(*) INTO proximos
        FROM Insumo
        WHERE perecivel = TRUE 
        AND data_validade <= CURRENT_DATE + INTERVAL '7 days';
    EXCEPTION
        WHEN OTHERS THEN
            RETURN 0;
    END;

    IF total = 0 THEN
        RETURN 0;
    END IF;

    RETURN ROUND((proximos::NUMERIC / total::NUMERIC) * 100, 2);
END;
$$ LANGUAGE plpgsql;

--- Consultas SQL com Insights de Negócio

--- 1. Faturamento real por pedido - mostra quais pedidos geram mais receita e ajudam a identificar o ticket médio e produtos mais lucrativos.

CREATE OR REPLACE VIEW vw_faturamento_real_pedidos AS
SELECT 
    p.id_pedido,
    p.data_pedido,
    fn_calcular_total_pedido(p.id_pedido) AS faturamento_real,
    p.status_pedido
FROM Pedido p
ORDER BY faturamento_real DESC
LIMIT 10;

SELECT * FROM vw_faturamento_real_pedidos;

--- 2. Percentual de insumos próximos da validade - mede o risco de perda de estoque por vencimento, ajudando no planejamento de compras.

CREATE OR REPLACE VIEW vw_indicador_risco_estoque AS
SELECT fn_insumos_proximos_validade() AS percentual_insumos_criticos;

SELECT * FROM vw_indicador_risco_estoque;

--- 3. Produtos mais vendidos - identifica itens que mais saem, úteis para promoções, reposição e precificação.

CREATE OR REPLACE VIEW vw_top_produtos_vendidos AS
SELECT 
    pr.id_produto,
    pr.nome,
    SUM(ip.quantidade) AS total_vendido
FROM ItemPedido ip
JOIN Produto pr ON pr.id_produto = ip.id_produto
GROUP BY pr.id_produto, pr.nome
ORDER BY total_vendido DESC
LIMIT 10;

SELECT * FROM vw_top_produtos_vendidos;

--- 4. Funcionários que mais entregam pedidos - mede produtividade e ajuda em distribuição de rotas ou bonificação.

CREATE OR REPLACE VIEW vw_produtividade_entregadores AS
SELECT 
    f.id_funcionario,
    f.nome,
    COUNT(e.id_entrega) AS entregas_realizadas
FROM Entrega e
JOIN Funcionario f ON f.id_funcionario = e.id_funcionario_entrega
GROUP BY f.id_funcionario, f.nome
ORDER BY entregas_realizadas DESC;

SELECT * FROM vw_produtividade_entregadores;

--- 5. Produtos que mais consomem insumos - mostra quais produtos têm maior custo operacional e exigem mais matéria-prima.

CREATE OR REPLACE VIEW vw_consumo_insumos_por_produto AS
SELECT 
    p.id_produto_fabricado AS id_produto,
    pr.nome AS produto,
    SUM(ii.quantidade) AS total_insumo_consumido
FROM ItemInsumo ii
JOIN Producao p ON p.id_producao = ii.id_producao
JOIN Produto pr ON pr.id_produto = p.id_produto_fabricado
GROUP BY p.id_produto_fabricado, pr.nome
ORDER BY total_insumo_consumido DESC;

SELECT * FROM vw_consumo_insumos_por_produto;
