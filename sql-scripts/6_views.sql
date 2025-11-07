CREATE VIEW vw_estoque_detalhado AS
SELECT
    COALESCE(p.id_produto, i.id_insumo) AS id_item,
    COALESCE(p.nome, i.nome) AS nome_item,
    COALESCE(p.unidade::text, i.unidade::text) AS unidade_medida,
    COALESCE(p.estoque_atual, i.estoque_atual) AS estoque_atual,
    CASE
        WHEN p.id_produto IS NOT NULL THEN 'Produto Acabado'
        ELSE 'Insumo'
    END AS tipo_item,
    a.tipo AS tipo_movimentacao,
    a.quantidade AS qtd_movimentada,
    a.data AS data_auditoria,
    a.motivo
FROM
    Produto p
FULL OUTER JOIN
    Insumo i ON p.id_produto = i.id_insumo
LEFT JOIN
    AuditoriaEstoqueProduto a ON COALESCE(p.id_produto, i.id_insumo) = a.id_produto
ORDER BY
    nome_item, data_auditoria DESC;

CREATE VIEW vw_detalhes_pedidos AS
SELECT
    p.id_pedido,
    p.data_pedido,
    pcs.nome AS cliente_nome,
    f.nome AS entregador_nome,
    p.status_pedido::text AS status_pedido,
    pag.metodo::text AS metodo_pagamento,
    pag.status::text AS status_pagamento,
    ip.quantidade AS qtd_item,
    ip.preco AS preco_unitario_venda,
    (ip.quantidade * ip.preco) AS subtotal_item,
    prod.nome AS nome_produto_vendido,
    p.valorItens,
    p.taxaEntrega,
    p.total_pedido
FROM
    Pedido p
JOIN
    Cliente pcs ON p.id_cliente = pcs.id_cliente
JOIN
    Pagamento pag ON p.id_pagamento = pag.id_pagamento
LEFT JOIN
    Funcionario f ON p.id_funcionario = f.id_funcionario
JOIN
    ItemPedido ip ON p.id_pedido = ip.id_pedido
JOIN
    Produto prod ON ip.id_produto = prod.id_produto
ORDER BY
    p.data_pedido DESC, p.id_pedido, nome_produto_vendido;

CREATE VIEW vw_rastreio_notas_fiscais AS
SELECT
    nf.id_notaFiscal,
    nf.data_nota,
    nf.valor_total AS valor_total_nf,
    frn.nome AS nome_fornecedor,
    nf_item.nome_item,
    nf_item.quantidade,
    nf_item.valor_unitario
FROM
    NotaFiscal nf
JOIN
    Fornecedor frn ON nf.id_fornecedor = frn.id_fornecedor
LEFT JOIN
    (
        SELECT id_notaFiscal, id_produto AS id_item, quantidade_produto AS quantidade, valor_unitario, p.nome AS nome_item
        FROM NotaFiscalProduto nfp JOIN Produto p ON nfp.id_produto = p.id_produto
        UNION ALL
        SELECT id_notaFiscal, id_insumo AS id_item, quantidade_insumo AS quantidade, valor_unitario, i.nome AS nome_item
        FROM NotaFiscalInsumo nfi JOIN Insumo i ON nfi.id_insumo = i.id_insumo
    ) AS nf_item ON nf.id_notaFiscal = nf_item.id_notaFiscal
ORDER BY
    nf.data_nota DESC;

CREATE VIEW vw_analise_producao AS
SELECT
    pd.id_producao,
    pd.status::text AS status_producao,
    pf.nome AS produto_fabricado,
    pd.quantidade_real AS quantidade_produzida,
    func.nome AS funcionario_producao,
    ins.nome AS insumo_consumido,
    ii.quantidade AS qtd_insumo_consumido
FROM
    Producao pd
JOIN
    Produto pf ON pd.id_produto_fabricado = pf.id_produto
LEFT JOIN
    Funcionario func ON pd.id_funcionario = func.id_funcionario
LEFT JOIN
    ItemInsumo ii ON pd.id_producao = ii.id_producao
LEFT JOIN
    Insumo ins ON ii.id_insumo = ins.id_insumo
ORDER BY
    pd.id_producao DESC, ins.nome;

CREATE VIEW vw_pedidos_pendentes_entrega AS
SELECT
    p.id_pedido,
    p.data_pedido,
    p.total_pedido,
    p.status_pedido::text AS status_pedido,
    c.nome AS cliente_nome,
    e.status_entrega::text AS status_entrega,
    f.nome AS entregador_previsto,
    e.previsao_entrega
FROM
    Pedido p
JOIN
    Entrega e ON p.id_pedido = e.pedido_id
JOIN
    Cliente c ON p.id_cliente = c.id_cliente
JOIN
    Funcionario f ON e.id_funcionario_entrega = f.id_funcionario
WHERE
    p.status_pedido IN ('PAGO', 'EM_PROCESSAMENTO')
    AND e.status_entrega NOT IN ('ENTREGUE', 'FALHA_ENTREGA')
ORDER BY
    p.data_pedido ASC;

CREATE VIEW vw_analise_vendas_categoria AS
SELECT
    cp.nome AS nome_categoria,
    SUM(ip.quantidade * ip.preco) AS receita_total_categoria,
    SUM(ip.quantidade) AS total_itens_vendidos
FROM
    ItemPedido ip
JOIN
    Produto p ON ip.id_produto = p.id_produto
JOIN
    CategoriaProduto cp ON p.id_categoria = cp.id_categoria
GROUP BY
    cp.nome
ORDER BY
    receita_total_categoria DESC;