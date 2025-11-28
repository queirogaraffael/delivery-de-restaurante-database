CREATE OR REPLACE FUNCTION atualizar_estoque_apos_auditoria()
RETURNS TRIGGER AS $$
DECLARE
    tipo_item VARCHAR(10);
BEGIN
    IF NEW.id_produto < 100 THEN
        tipo_item := 'Insumo';
    ELSE
        tipo_item := 'Produto';
    END IF;

    IF NEW.tipo = 'ENTRADA' THEN
        IF tipo_item = 'Produto' THEN
            UPDATE Produto SET estoque_atual = estoque_atual + NEW.quantidade WHERE id_produto = NEW.id_produto;
        ELSE
            UPDATE Insumo SET estoque_atual = estoque_atual + NEW.quantidade WHERE id_insumo = NEW.id_produto;
        END IF;
    ELSIF NEW.tipo = 'SAIDA' THEN
        IF tipo_item = 'Produto' THEN
            UPDATE Produto SET estoque_atual = estoque_atual - NEW.quantidade WHERE id_produto = NEW.id_produto;
        ELSE
            UPDATE Insumo SET estoque_atual = estoque_atual - NEW.quantidade WHERE id_insumo = NEW.id_produto;
        END IF;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_atualizar_estoque
AFTER INSERT ON AuditoriaEstoqueProduto
FOR EACH ROW EXECUTE FUNCTION atualizar_estoque_apos_auditoria();

INSERT INTO Pagamento (id_pagamento, metodo, status) VALUES
(200, 'PIX', 'APROVADO'),
(201, 'PIX', 'PENDENTE'),
(202, 'CARTAO', 'APROVADO'),
(203, 'PIX', 'APROVADO'),
(204, 'PIX', 'PENDENTE'),
(205, 'CARTAO', 'APROVADO'),
(206, 'PIX', 'APROVADO'),
(207, 'PIX', 'PENDENTE'),
(208, 'CARTAO', 'APROVADO'),
(209, 'PIX', 'APROVADO');

INSERT INTO NotaFiscal (id_notaFiscal, id_fornecedor, id_pagamento, data_nota, valor_total) VALUES
(100, 1000, 200, CURRENT_TIMESTAMP, 450.00),
(101, 1001, 201, CURRENT_TIMESTAMP, 800.00),
(102, 1002, 202, CURRENT_TIMESTAMP, 300.00),
(103, 1003, 203, CURRENT_TIMESTAMP, 150.00),
(104, 1004, 204, CURRENT_TIMESTAMP, 250.00),
(106, 1006, 206, CURRENT_TIMESTAMP, 320.00),
(107, 1008, 207, CURRENT_TIMESTAMP, 600.00),
(108, 1009, 208, CURRENT_TIMESTAMP, 100.00),
(109, 1002, 209, CURRENT_TIMESTAMP, 400.00);

INSERT INTO NotaFiscalInsumo (id_notaFiscal, id_insumo, quantidade_insumo, valor_unitario) VALUES (100, 10, 100, 2.50);
INSERT INTO AuditoriaEstoqueProduto (id_auditoriaEstoque, id_produto, tipo, quantidade, data, motivo) VALUES (1, 10, 'ENTRADA', 100, CURRENT_DATE, 'NF 100: Compra de Pão');
INSERT INTO NotaFiscalInsumo (id_notaFiscal, id_insumo, quantidade_insumo, valor_unitario) VALUES (100, 12, 10, 30.00);
INSERT INTO AuditoriaEstoqueProduto (id_auditoriaEstoque, id_produto, tipo, quantidade, data, motivo) VALUES (2, 12, 'ENTRADA', 10, CURRENT_DATE, 'NF 100: Compra de Queijo');

INSERT INTO NotaFiscalInsumo (id_notaFiscal, id_insumo, quantidade_insumo, valor_unitario) VALUES (101, 11, 20, 40.00);
INSERT INTO AuditoriaEstoqueProduto (id_auditoriaEstoque, id_produto, tipo, quantidade, data, motivo) VALUES (3, 11, 'ENTRADA', 20, CURRENT_DATE, 'NF 101: Compra de Carne');

INSERT INTO NotaFiscalProduto (id_notaFiscal, id_produto, quantidade_produto, valor_unitario) VALUES (102, 101, 50, 5.00);
INSERT INTO AuditoriaEstoqueProduto (id_auditoriaEstoque, id_produto, tipo, quantidade, data, motivo) VALUES (4, 101, 'ENTRADA', 50, CURRENT_DATE, 'NF 102: Compra Refri');
INSERT INTO NotaFiscalProduto (id_notaFiscal, id_produto, quantidade_produto, valor_unitario) VALUES (102, 105, 40, 6.00);
INSERT INTO AuditoriaEstoqueProduto (id_auditoriaEstoque, id_produto, tipo, quantidade, data, motivo) VALUES (5, 105, 'ENTRADA', 40, CURRENT_DATE, 'NF 102: Compra Suco');

INSERT INTO NotaFiscalInsumo (id_notaFiscal, id_insumo, quantidade_insumo, valor_unitario) VALUES (103, 13, 5, 5.00);
INSERT INTO AuditoriaEstoqueProduto (id_auditoriaEstoque, id_produto, tipo, quantidade, data, motivo) VALUES (6, 13, 'ENTRADA', 5, CURRENT_DATE, 'NF 103: Compra Alface');
INSERT INTO NotaFiscalInsumo (id_notaFiscal, id_insumo, quantidade_insumo, valor_unitario) VALUES (103, 14, 15, 10.00);
INSERT INTO AuditoriaEstoqueProduto (id_auditoriaEstoque, id_produto, tipo, quantidade, data, motivo) VALUES (7, 14, 'ENTRADA', 15, CURRENT_DATE, 'NF 103: Compra Tomate');

INSERT INTO NotaFiscalInsumo (id_notaFiscal, id_insumo, quantidade_insumo, valor_unitario) VALUES (105, 17, 50, 2.00);
INSERT INTO AuditoriaEstoqueProduto (id_auditoriaEstoque, id_produto, tipo, quantidade, data, motivo) VALUES (8, 17, 'ENTRADA', 50, CURRENT_DATE, 'NF 105: Compra Farinha');
INSERT INTO NotaFiscalInsumo (id_notaFiscal, id_insumo, quantidade_insumo, valor_unitario) VALUES (105, 16, 30, 3.00);
INSERT INTO AuditoriaEstoqueProduto (id_auditoriaEstoque, id_produto, tipo, quantidade, data, motivo) VALUES (9, 16, 'ENTRADA', 30, CURRENT_DATE, 'NF 105: Compra Açúcar');

INSERT INTO NotaFiscalInsumo (id_notaFiscal, id_insumo, quantidade_insumo, valor_unitario) VALUES (107, 18, 10, 60.00);
INSERT INTO AuditoriaEstoqueProduto (id_auditoriaEstoque, id_produto, tipo, quantidade, data, motivo) VALUES (10, 18, 'ENTRADA', 10, CURRENT_DATE, 'NF 107: Compra Frango');

INSERT INTO NotaFiscalInsumo (id_notaFiscal, id_insumo, quantidade_insumo, valor_unitario) VALUES (108, 19, 8, 5.00);
INSERT INTO AuditoriaEstoqueProduto (id_auditoriaEstoque, id_produto, tipo, quantidade, data, motivo) VALUES (11, 19, 'ENTRADA', 8, CURRENT_DATE, 'NF 108: Compra Cebola');

INSERT INTO NotaFiscalInsumo (id_notaFiscal, id_insumo, quantidade_insumo, valor_unitario) VALUES (109, 15, 50, 8.00);
INSERT INTO AuditoriaEstoqueProduto (id_auditoriaEstoque, id_produto, tipo, quantidade, data, motivo) VALUES (12, 15, 'ENTRADA', 50, CURRENT_DATE, 'NF 109: Compra Óleo');
INSERT INTO NotaFiscalProduto (id_notaFiscal, id_produto, quantidade_produto, valor_unitario) VALUES (109, 109, 100, 2.50);
INSERT INTO AuditoriaEstoqueProduto (id_auditoriaEstoque, id_produto, tipo, quantidade, data, motivo) VALUES (13, 109, 'ENTRADA', 100, CURRENT_DATE, 'NF 109: Compra Água');