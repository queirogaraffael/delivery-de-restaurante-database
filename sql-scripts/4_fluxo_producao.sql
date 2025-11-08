DO $$
DECLARE
    producao_id INT := 10;
    produto_fabricado_id INT := 100;
    funcionario_id INT := 3;
    quantidade_a_produzir INT := 50;
    auditoria_seq INT := 14;
BEGIN
    INSERT INTO Producao (id_producao, id_produto_fabricado, id_funcionario, quantidade_planejada, quantidade_real, status) VALUES
    (producao_id, produto_fabricado_id, funcionario_id, quantidade_a_produzir, quantidade_a_produzir, 'FEITO');

    INSERT INTO ItemInsumo (id_insumo, id_producao, quantidade) VALUES
    (10, producao_id, ROUND(quantidade_a_produzir * 1)),
    (11, producao_id, ROUND(quantidade_a_produzir * 0.2)),
    (12, producao_id, ROUND(quantidade_a_produzir * 0.1)),
    (13, producao_id, ROUND(quantidade_a_produzir * 0.1)),
    (14, producao_id, ROUND(quantidade_a_produzir * 0.1));

    INSERT INTO AuditoriaEstoqueProduto (id_auditoriaEstoque, id_produto, tipo, quantidade, data, motivo) VALUES
    (auditoria_seq, 10, 'SAIDA', ROUND(50), NOW(), 'Consumo Prod. X-Salada 10'),
    (auditoria_seq + 1, 11, 'SAIDA', ROUND(10), NOW(), 'Consumo Prod. X-Salada 10'),
    (auditoria_seq + 2, 12, 'SAIDA', ROUND(5), NOW(), 'Consumo Prod. X-Salada 10'),
    (auditoria_seq + 3, 13, 'SAIDA', ROUND(5), NOW(), 'Consumo Prod. X-Salada 10'),
    (auditoria_seq + 4, 14, 'SAIDA', ROUND(5), NOW(), 'Consumo Prod. X-Salada 10'),
    (auditoria_seq + 5, 100, 'ENTRADA', quantidade_a_produzir, NOW(), 'Producao concluida X-Salada 10');
END $$ LANGUAGE plpgsql;

DO $$
DECLARE
    producao_id INT := 11;
    produto_fabricado_id INT := 102;
    funcionario_id INT := 7;
    quantidade_a_produzir INT := 40;
    auditoria_seq INT := 20;
BEGIN
    INSERT INTO Producao (id_producao, id_produto_fabricado, id_funcionario, quantidade_planejada, quantidade_real, status) VALUES
    (producao_id, produto_fabricado_id, funcionario_id, quantidade_a_produzir, quantidade_a_produzir, 'FEITO');

    INSERT INTO ItemInsumo (id_insumo, id_producao, quantidade) VALUES
    (10, producao_id, ROUND(quantidade_a_produzir * 1)),
    (12, producao_id, ROUND(quantidade_a_produzir * 0.15)),
    (11, producao_id, ROUND(quantidade_a_produzir * 0.18));

    INSERT INTO AuditoriaEstoqueProduto (id_auditoriaEstoque, id_produto, tipo, quantidade, data, motivo) VALUES
    (auditoria_seq, 10, 'SAIDA', ROUND(40), NOW(), 'Consumo Prod. X-Bacon 11'),
    (auditoria_seq + 1, 12, 'SAIDA', ROUND(6), NOW(), 'Consumo Prod. X-Bacon 11'),
    (auditoria_seq + 2, 11, 'SAIDA', ROUND(7.2), NOW(), 'Consumo Prod. X-Bacon 11'),
    (auditoria_seq + 3, 102, 'ENTRADA', quantidade_a_produzir, NOW(), 'Producao concluida X-Bacon 11');
END $$ LANGUAGE plpgsql;

DO $$
DECLARE
    producao_id INT := 12;
    produto_fabricado_id INT := 106;
    funcionario_id INT := 3;
    quantidade_a_produzir INT := 30;
    auditoria_seq INT := 24;
BEGIN
    INSERT INTO Producao (id_producao, id_produto_fabricado, id_funcionario, quantidade_planejada, quantidade_real, status) VALUES
    (producao_id, produto_fabricado_id, funcionario_id, quantidade_a_produzir, quantidade_a_produzir, 'FEITO');

    INSERT INTO ItemInsumo (id_insumo, id_producao, quantidade) VALUES
    (18, producao_id, ROUND(quantidade_a_produzir * 0.3)),
    (19, producao_id, ROUND(quantidade_a_produzir * 0.05)),
    (15, producao_id, ROUND(quantidade_a_produzir * 0.1));

    INSERT INTO AuditoriaEstoqueProduto (id_auditoriaEstoque, id_produto, tipo, quantidade, data, motivo) VALUES
    (auditoria_seq, 18, 'SAIDA', ROUND(9), NOW(), 'Consumo Prod. Marmita 12'),
    (auditoria_seq + 1, 19, 'SAIDA', ROUND(1.5), NOW(), 'Consumo Prod. Marmita 12'),
    (auditoria_seq + 2, 15, 'SAIDA', ROUND(3), NOW(), 'Consumo Prod. Marmita 12'),
    (auditoria_seq + 3, 106, 'ENTRADA', quantidade_a_produzir, NOW(), 'Producao concluida Marmita 12');
END $$ LANGUAGE plpgsql;

DO $$
DECLARE
    producao_id INT := 13;
    produto_fabricado_id INT := 107;
    funcionario_id INT := 7;
    quantidade_a_produzir INT := 20;
    auditoria_seq INT := 28;
BEGIN
    INSERT INTO Producao (id_producao, id_produto_fabricado, id_funcionario, quantidade_planejada, quantidade_real, status) VALUES
    (producao_id, produto_fabricado_id, funcionario_id, quantidade_a_produzir, quantidade_a_produzir, 'FEITO');

    INSERT INTO ItemInsumo (id_insumo, id_producao, quantidade) VALUES
    (13, producao_id, ROUND(quantidade_a_produzir * 0.2)),
    (14, producao_id, ROUND(quantidade_a_produzir * 0.15));

    INSERT INTO AuditoriaEstoqueProduto (id_auditoriaEstoque, id_produto, tipo, quantidade, data, motivo) VALUES
    (auditoria_seq, 13, 'SAIDA', ROUND(4), NOW(), 'Consumo Prod. Salada 13'),
    (auditoria_seq + 1, 14, 'SAIDA', ROUND(3), NOW(), 'Consumo Prod. Salada 13'),
    (auditoria_seq + 2, 107, 'ENTRADA', quantidade_a_produzir, NOW(), 'Producao concluida Salada 13');
END $$ LANGUAGE plpgsql;

DO $$
DECLARE
    producao_id INT := 14;
    produto_fabricado_id INT := 108;
    funcionario_id INT := 3;
    quantidade_a_produzir INT := 15;
    auditoria_seq INT := 31;
BEGIN
    INSERT INTO Producao (id_producao, id_produto_fabricado, id_funcionario, quantidade_planejada, quantidade_real, status) VALUES
    (producao_id, produto_fabricado_id, funcionario_id, quantidade_a_produzir, quantidade_a_produzir, 'FEITO');

    INSERT INTO ItemInsumo (id_insumo, id_producao, quantidade) VALUES
    (10, producao_id, ROUND(quantidade_a_produzir * 1)),
    (19, producao_id, ROUND(quantidade_a_produzir * 0.05));

    INSERT INTO AuditoriaEstoqueProduto (id_auditoriaEstoque, id_produto, tipo, quantidade, data, motivo) VALUES
    (auditoria_seq, 10, 'SAIDA', ROUND(15), NOW(), 'Consumo Prod. Burger Vegano 14'),
    (auditoria_seq + 1, 19, 'SAIDA', ROUND(0.75), NOW(), 'Consumo Prod. Burger Vegano 14'),
    (auditoria_seq + 2, 108, 'ENTRADA', quantidade_a_produzir, NOW(), 'Producao concluida Burger Vegano 14');
END $$ LANGUAGE plpgsql;

DO $$
DECLARE
    producao_id INT := 15;
    produto_fabricado_id INT := 103;
    funcionario_id INT := 7;
    quantidade_a_produzir INT := 100;
    auditoria_seq INT := 34;
BEGIN
    INSERT INTO Producao (id_producao, id_produto_fabricado, id_funcionario, quantidade_planejada, quantidade_real, status) VALUES
    (producao_id, produto_fabricado_id, funcionario_id, quantidade_a_produzir, quantidade_a_produzir, 'FEITO');

    INSERT INTO ItemInsumo (id_insumo, id_producao, quantidade) VALUES
    (15, producao_id, ROUND(quantidade_a_produzir * 0.05));

    INSERT INTO AuditoriaEstoqueProduto (id_auditoriaEstoque, id_produto, tipo, quantidade, data, motivo) VALUES
    (auditoria_seq, 15, 'SAIDA', ROUND(5), NOW(), 'Consumo Prod. Batata Frita 15'),
    (auditoria_seq + 1, 103, 'ENTRADA', quantidade_a_produzir, NOW(), 'Producao concluida Batata Frita 15');
END $$ LANGUAGE plpgsql;

DO $$
DECLARE
    producao_id INT := 16;
    produto_fabricado_id INT := 100;
    funcionario_id INT := 3;
    quantidade_a_produzir INT := 25;
    auditoria_seq INT := 36;
BEGIN
    INSERT INTO Producao (id_producao, id_produto_fabricado, id_funcionario, quantidade_planejada, quantidade_real, status) VALUES
    (producao_id, produto_fabricado_id, funcionario_id, quantidade_a_produzir, quantidade_a_produzir, 'FEITO');

    INSERT INTO ItemInsumo (id_insumo, id_producao, quantidade) VALUES
    (10, producao_id, ROUND(quantidade_a_produzir * 1)),
    (11, producao_id, ROUND(quantidade_a_produzir * 0.2));

    INSERT INTO AuditoriaEstoqueProduto (id_auditoriaEstoque, id_produto, tipo, quantidade, data, motivo) VALUES
    (auditoria_seq, 10, 'SAIDA', ROUND(25), NOW(), 'Consumo Prod. X-Salada 16'),
    (auditoria_seq + 1, 11, 'SAIDA', ROUND(5), NOW(), 'Consumo Prod. X-Salada 16'),
    (auditoria_seq + 2, 100, 'ENTRADA', quantidade_a_produzir, NOW(), 'Producao concluida X-Salada 16');
END $$ LANGUAGE plpgsql;

DO $$
DECLARE
    producao_id INT := 17;
    produto_fabricado_id INT := 106;
    funcionario_id INT := 7;
    quantidade_a_produzir INT := 10;
    auditoria_seq INT := 39;
BEGIN
    INSERT INTO Producao (id_producao, id_produto_fabricado, id_funcionario, quantidade_planejada, quantidade_real, status) VALUES
    (producao_id, produto_fabricado_id, funcionario_id, quantidade_a_produzir, quantidade_a_produzir, 'FEITO');

    INSERT INTO ItemInsumo (id_insumo, id_producao, quantidade) VALUES
    (18, producao_id, ROUND(quantidade_a_produzir * 0.3));

    INSERT INTO AuditoriaEstoqueProduto (id_auditoriaEstoque, id_produto, tipo, quantidade, data, motivo) VALUES
    (auditoria_seq, 18, 'SAIDA', ROUND(3), NOW(), 'Consumo Prod. Marmita 17'),
    (auditoria_seq + 1, 106, 'ENTRADA', quantidade_a_produzir, NOW(), 'Producao concluida Marmita 17');
END $$ LANGUAGE plpgsql;

DO $$
DECLARE
    producao_id INT := 18;
    produto_fabricado_id INT := 107;
    funcionario_id INT := 3;
    quantidade_a_produzir INT := 15;
    auditoria_seq INT := 41;
BEGIN
    INSERT INTO Producao (id_producao, id_produto_fabricado, id_funcionario, quantidade_planejada, quantidade_real, status) VALUES
    (producao_id, produto_fabricado_id, funcionario_id, quantidade_a_produzir, quantidade_a_produzir, 'FEITO');

    INSERT INTO ItemInsumo (id_insumo, id_producao, quantidade) VALUES
    (13, producao_id, ROUND(quantidade_a_produzir * 0.2));

    INSERT INTO AuditoriaEstoqueProduto (id_auditoriaEstoque, id_produto, tipo, quantidade, data, motivo) VALUES
    (auditoria_seq, 13, 'SAIDA', ROUND(3), NOW(), 'Consumo Prod. Salada 18'),
    (auditoria_seq + 1, 107, 'ENTRADA', quantidade_a_produzir, NOW(), 'Producao concluida Salada 18');
END $$ LANGUAGE plpgsql;

DO $$
DECLARE
    producao_id INT := 19;
    produto_fabricado_id INT := 102;
    funcionario_id INT := 7;
    quantidade_a_produzir INT := 30;
    auditoria_seq INT := 43;
BEGIN
    INSERT INTO Producao (id_producao, id_produto_fabricado, id_funcionario, quantidade_planejada, quantidade_real, status) VALUES
    (producao_id, produto_fabricado_id, funcionario_id, quantidade_a_produzir, quantidade_a_produzir, 'FEITO');

    INSERT INTO ItemInsumo (id_insumo, id_producao, quantidade) VALUES
    (10, producao_id, ROUND(quantidade_a_produzir * 1)),
    (12, producao_id, ROUND(quantidade_a_produzir * 0.15));

    INSERT INTO AuditoriaEstoqueProduto (id_auditoriaEstoque, id_produto, tipo, quantidade, data, motivo) VALUES
    (auditoria_seq, 10, 'SAIDA', ROUND(30), NOW(), 'Consumo Prod. X-Bacon 19'),
    (auditoria_seq + 1, 12, 'SAIDA', ROUND(4.5), NOW(), 'Consumo Prod. X-Bacon 19'),
    (auditoria_seq + 2, 102, 'ENTRADA', quantidade_a_produzir, NOW(), 'Producao concluida X-Bacon 19');
END $$ LANGUAGE plpgsql;