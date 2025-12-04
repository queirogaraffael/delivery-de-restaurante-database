-- Trigger que cadastram a entrada de insumos e produtos e fazem a auditoria de produtos

CREATE OR REPLACE FUNCTION fn_entrada_produto_nf()
RETURNS TRIGGER AS $$
DECLARE
    v_existe INT;
BEGIN
    SELECT 1 INTO v_existe
    FROM Produto
    WHERE id_produto = NEW.id_produto;

    IF NOT FOUND THEN
        RAISE EXCEPTION 
            'Erro ao registrar entrada por NF: Produto com ID % não existe.',
            NEW.id_produto;
    END IF;

    IF NEW.quantidade_produto IS NULL OR NEW.quantidade_produto <= 0 THEN
        RAISE EXCEPTION 
            'Erro ao registrar entrada por NF: quantidade inválida (%).',
            NEW.quantidade_produto;
    END IF;

    UPDATE Produto
    SET estoque_atual = COALESCE(estoque_atual, 0) + NEW.quantidade_produto
    WHERE id_produto = NEW.id_produto;

    INSERT INTO AuditoriaEstoqueProduto (
        id_produto,
        tipo_movimento,
        quantidade,
        data,
        motivo
    ) VALUES (
        NEW.id_produto,
        'ENTRADA',
        NEW.quantidade_produto,
        CURRENT_TIMESTAMP,
        'NF ' || NEW.id_nota_fiscal || ': Entrada de Compra'
    );

    RETURN NEW;

EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 
            'Falha ao processar a entrada de produto da NF (ID Produto %, Quantidade %, Erro: %)',
            NEW.id_produto,
            NEW.quantidade_produto,
            SQLERRM;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER trg_nfproduto_entrada_estoque
AFTER INSERT ON NotaFiscalProduto
FOR EACH ROW
EXECUTE FUNCTION fn_entrada_produto_nf();

---

CREATE OR REPLACE FUNCTION fn_entrada_insumo_nf()
RETURNS TRIGGER AS $$
DECLARE
    v_existe INT;
BEGIN
    SELECT 1 INTO v_existe
    FROM Insumo
    WHERE id_insumo = NEW.id_insumo;

    IF NOT FOUND THEN
        RAISE EXCEPTION 
            'Erro ao registrar entrada por NF: Insumo com ID % não existe.',
            NEW.id_insumo;
    END IF;

    IF NEW.quantidade_insumo IS NULL OR NEW.quantidade_insumo <= 0 THEN
        RAISE EXCEPTION 
            'Erro ao registrar entrada por NF: quantidade inválida (%).',
            NEW.quantidade_insumo;
    END IF;

    UPDATE Insumo
    SET estoque_atual = COALESCE(estoque_atual, 0) + NEW.quantidade_insumo
    WHERE id_insumo = NEW.id_insumo;

    RETURN NEW;

EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 
            'Falha ao processar a entrada de insumo da NF (ID Insumo %, Quantidade %, Erro: %)',
            NEW.id_insumo,
            NEW.quantidade_insumo,
            SQLERRM;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER trg_nfinsumo_entrada_estoque
AFTER INSERT ON NotaFiscalInsumo
FOR EACH ROW
EXECUTE FUNCTION fn_entrada_insumo_nf();

---

INSERT INTO Pagamento (id_pagamento, metodo_pagamento, status_pagamento, data_pagamento) VALUES
(200, 'PIX', 'APROVADO', '2025-11-28 10:15:00'),
(201, 'PIX', 'PENDENTE', NULL),
(202, 'CARTAO', 'APROVADO', '2025-11-27 14:30:00'),
(203, 'PIX', 'APROVADO', '2025-11-28 09:50:00'),
(204, 'PIX', 'PENDENTE', NULL),
(205, 'CARTAO', 'APROVADO', '2025-11-26 16:05:00'),
(206, 'PIX', 'APROVADO', '2025-11-28 11:00:00'),
(207, 'PIX', 'PENDENTE', NULL),
(208, 'PIX', 'APROVADO', CURRENT_TIMESTAMP),
(209, 'CARTAO', 'APROVADO', CURRENT_TIMESTAMP),
(210, 'PIX', 'APROVADO', CURRENT_TIMESTAMP),
(211, 'PIX', 'APROVADO', CURRENT_TIMESTAMP);

---

INSERT INTO NotaFiscal (id_nota_fiscal, id_fornecedor, id_pagamento, data_nota_fiscal, valor_total) VALUES
(100, 1000, 200, CURRENT_TIMESTAMP, 550.00), 
(101, 1001, 201, CURRENT_TIMESTAMP, 800.00), 
(102, 1002, 202, CURRENT_TIMESTAMP, 490.00), 
(103, 1003, 203, CURRENT_TIMESTAMP, 425.00), 
(104, 1004, 204, CURRENT_TIMESTAMP, 190.00), 
(105, 1008, 205, CURRENT_TIMESTAMP, 600.00),
(106, 1009, 206, CURRENT_TIMESTAMP, 40.00),
(107, 1002, 207, CURRENT_TIMESTAMP, 650.00),
(108, 1000, 208, CURRENT_TIMESTAMP, 300.00),
(109, 1001, 209, CURRENT_TIMESTAMP, 150.00),
(110, 1002, 210, CURRENT_TIMESTAMP, 120.00),
(111, 1003, 211, CURRENT_TIMESTAMP, 80.00);

-- NF 100
    -- Insumos (Pão, Queijo)
INSERT INTO NotaFiscalInsumo (id_nota_fiscal, id_insumo, quantidade_insumo, valor_unitario) VALUES 
(100, 10, 100, 2.50);
INSERT INTO NotaFiscalInsumo (id_nota_fiscal, id_insumo, quantidade_insumo, valor_unitario) VALUES 
(100, 12, 10, 30.00);

-- NF 101
-- Insumo (Carne)
INSERT INTO NotaFiscalInsumo (id_nota_fiscal, id_insumo, quantidade_insumo, valor_unitario) VALUES 
(101, 11, 20, 40.00);

-- NF 102
-- Produtos (Refrigerante, Suco Laranja)
INSERT INTO NotaFiscalProduto (id_nota_fiscal, id_produto, quantidade_produto, valor_unitario) VALUES 
(102, 101, 50, 5.00);
INSERT INTO NotaFiscalProduto (id_nota_fiscal, id_produto, quantidade_produto, valor_unitario) VALUES 
(102, 105, 40, 6.00);

-- NF 103
-- Insumos (Alface, Tomate, Batata)
INSERT INTO NotaFiscalInsumo (id_nota_fiscal, id_insumo, quantidade_insumo, valor_unitario) VALUES 
(103, 13, 5, 5.00);
INSERT INTO NotaFiscalInsumo (id_nota_fiscal, id_insumo, quantidade_insumo, valor_unitario) VALUES 
(103, 14, 15, 10.00);
INSERT INTO NotaFiscalInsumo (id_nota_fiscal, id_insumo, quantidade_insumo, valor_unitario) VALUES 
(103, 21, 50, 5.00);

-- NF 104
-- Insumos (Farinha, Açúcar)
INSERT INTO NotaFiscalInsumo (id_nota_fiscal, id_insumo, quantidade_insumo, valor_unitario) VALUES 
(104, 17, 50, 2.00);
INSERT INTO NotaFiscalInsumo (id_nota_fiscal, id_insumo, quantidade_insumo, valor_unitario) VALUES 
(104, 16, 30, 3.00);

-- NF 105
-- Insumo (Frango)
INSERT INTO NotaFiscalInsumo (id_nota_fiscal, id_insumo, quantidade_insumo, valor_unitario) VALUES 
(105, 18, 10, 60.00);

-- NF 106
-- Insumo (Cebola)
INSERT INTO NotaFiscalInsumo (id_nota_fiscal, id_insumo, quantidade_insumo, valor_unitario) VALUES 
(106, 19, 8, 5.00);

-- NF 107
-- Insumo (Óleo) e Produto (Água)
INSERT INTO NotaFiscalInsumo (id_nota_fiscal, id_insumo, quantidade_insumo, valor_unitario) VALUES 
(107, 15, 50, 8.00);
INSERT INTO NotaFiscalProduto (id_nota_fiscal, id_produto, quantidade_produto, valor_unitario) VALUES 
(107, 109, 100, 2.50);

-- NF 108
-- Laticínios/Congelados (Leite, Sorvete, Nuggets)
INSERT INTO NotaFiscalInsumo (id_nota_fiscal, id_insumo, quantidade_insumo, valor_unitario) VALUES 
(108, 27, 20, 4.00);
INSERT INTO NotaFiscalInsumo (id_nota_fiscal, id_insumo, quantidade_insumo, valor_unitario) VALUES 
(108, 28, 5, 20.00);
INSERT INTO NotaFiscalInsumo (id_nota_fiscal, id_insumo, quantidade_insumo, valor_unitario) VALUES 
(108, 30, 10, 10.00);

-- NF 109
-- Secos (Feijão, Arroz, Brownie Prémix)
INSERT INTO NotaFiscalInsumo (id_nota_fiscal, id_insumo, quantidade_insumo, valor_unitario) VALUES 
(109, 22, 30, 4.00);
INSERT INTO NotaFiscalInsumo (id_nota_fiscal, id_insumo, quantidade_insumo, valor_unitario) VALUES 
(109, 23, 50, 3.00);
INSERT INTO NotaFiscalInsumo (id_nota_fiscal, id_insumo, quantidade_insumo, valor_unitario) VALUES 
(109, 29, 5, 12.00);

-- NF 110
-- Molhos e Condensados (Molho Caesar, Leite Condensado)
INSERT INTO NotaFiscalInsumo (id_nota_fiscal, id_insumo, quantidade_insumo, valor_unitario) VALUES 
(110, 22, 10, 10.00);
INSERT INTO NotaFiscalInsumo (id_nota_fiscal, id_insumo, quantidade_insumo, valor_unitario) VALUES 
(110, 25, 20, 5.00);

-- NF 111
-- Outros (Bacon, Ovos)
INSERT INTO NotaFiscalInsumo (id_nota_fiscal, id_insumo, quantidade_insumo, valor_unitario) VALUES 
(111, 21, 10, 20.00);
INSERT INTO NotaFiscalInsumo (id_nota_fiscal, id_insumo, quantidade_insumo, valor_unitario) VALUES 
(111, 26, 30, 1.00);