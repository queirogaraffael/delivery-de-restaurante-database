DO $$
DECLARE
    pagamento_id INT := 300;
    pedido_id INT := 1;
    auditoria_seq INT := 50;
    entrega_id INT := 1;
    cliente_id INT := 50;
    funcionario_id INT := 1;
    valor_itens DECIMAL(10,2) := 33.00;
    taxa_entrega DECIMAL(10,2) := 5.00;
    total_pedido DECIMAL(10,2) := 38.00;
BEGIN
    INSERT INTO Pagamento (id_pagamento, metodo, status) VALUES (pagamento_id, 'CARTAO', 'PENDENTE');
    INSERT INTO Pedido (id_pedido, id_cliente, id_pagamento, id_funcionario, data_pedido, status_pedido, total_pedido, valorItens, taxaEntrega) VALUES
    (pedido_id, cliente_id, pagamento_id, funcionario_id, CURRENT_TIMESTAMP - interval '2 hours', 'CRIADO', total_pedido, valor_itens, taxa_entrega);
    INSERT INTO ItemPedido (id_produto, id_pedido, quantidade, preco) VALUES
    (100, pedido_id, 1, 25.00), (101, pedido_id, 1, 8.00);
    
    UPDATE Pagamento SET status = 'APROVADO' WHERE id_pagamento = pagamento_id;
    INSERT INTO AuditoriaEstoqueProduto (id_auditoriaEstoque, id_produto, tipo, quantidade, data, motivo) VALUES
    (auditoria_seq, 100, 'SAIDA', 1, CURRENT_DATE, 'Venda Pedido ID ' || pedido_id);
    INSERT INTO AuditoriaEstoqueProduto (id_auditoriaEstoque, id_produto, tipo, quantidade, data, motivo) VALUES
    (auditoria_seq + 1, 101, 'SAIDA', 1, CURRENT_DATE, 'Venda Pedido ID ' || pedido_id);
    
    UPDATE Pedido SET status_pedido = 'CONCLUIDO', data_pagamento = CURRENT_TIMESTAMP - interval '1.5 hours' WHERE id_pedido = pedido_id;
    INSERT INTO Entrega (id_entrega, id_funcionario_entrega, pedido_id, previsao_entrega, status_entrega, observacoes_entrega) VALUES
    (entrega_id, funcionario_id, pedido_id, CURRENT_TIMESTAMP - interval '1 hour', 'ENTREGUE', 'Entregue na portaria.');
END $$ LANGUAGE plpgsql;

DO $$
DECLARE
    pagamento_id INT := 301;
    pedido_id INT := 2;
    auditoria_seq INT := 52;
    entrega_id INT := 2;
    cliente_id INT := 51;
    funcionario_id INT := 5;
    valor_itens DECIMAL(10,2) := 35.00;
    taxa_entrega DECIMAL(10,2) := 5.00;
    total_pedido DECIMAL(10,2) := 40.00;
BEGIN
    INSERT INTO Pagamento (id_pagamento, metodo, status) VALUES (pagamento_id, 'PIX', 'PENDENTE');
    INSERT INTO Pedido (id_pedido, id_cliente, id_pagamento, id_funcionario, data_pedido, status_pedido, total_pedido, valorItens, taxaEntrega) VALUES
    (pedido_id, cliente_id, pagamento_id, funcionario_id, CURRENT_TIMESTAMP - interval '1 hour', 'CRIADO', total_pedido, valor_itens, taxa_entrega);
    INSERT INTO ItemPedido (id_produto, id_pedido, quantidade, preco) VALUES
    (106, pedido_id, 1, 35.00);
    
    UPDATE Pagamento SET status = 'APROVADO' WHERE id_pagamento = pagamento_id;
    INSERT INTO AuditoriaEstoqueProduto (id_auditoriaEstoque, id_produto, tipo, quantidade, data, motivo) VALUES
    (auditoria_seq, 106, 'SAIDA', 1, CURRENT_DATE, 'Venda Pedido ID ' || pedido_id);
    
    UPDATE Pedido SET status_pedido = 'CONCLUIDO', data_pagamento = CURRENT_TIMESTAMP - interval '30 minutes' WHERE id_pedido = pedido_id;
    INSERT INTO Entrega (id_entrega, id_funcionario_entrega, pedido_id, previsao_entrega, status_entrega, observacoes_entrega) VALUES
    (entrega_id, funcionario_id, pedido_id, CURRENT_TIMESTAMP + interval '5 minutes', 'ENTREGUE', NULL);
END $$ LANGUAGE plpgsql;

DO $$
DECLARE
    pagamento_id INT := 302;
    pedido_id INT := 3;
    auditoria_seq INT := 53;
    entrega_id INT := 3;
    cliente_id INT := 52;
    funcionario_id INT := 9;
    valor_itens DECIMAL(10,2) := 34.00;
    taxa_entrega DECIMAL(10,2) := 5.00;
    total_pedido DECIMAL(10,2) := 39.00;
BEGIN
    INSERT INTO Pagamento (id_pagamento, metodo, status) VALUES (pagamento_id, 'CARTAO', 'PENDENTE');
    INSERT INTO Pedido (id_pedido, id_cliente, id_pagamento, id_funcionario, data_pedido, status_pedido, total_pedido, valorItens, taxaEntrega) VALUES
    (pedido_id, cliente_id, pagamento_id, funcionario_id, CURRENT_TIMESTAMP, 'CRIADO', total_pedido, valor_itens, taxa_entrega);
    INSERT INTO ItemPedido (id_produto, id_pedido, quantidade, preco) VALUES
    (102, pedido_id, 1, 22.00), (103, pedido_id, 1, 12.00);
    
    UPDATE Pagamento SET status = 'APROVADO' WHERE id_pagamento = pagamento_id;
    INSERT INTO AuditoriaEstoqueProduto (id_auditoriaEstoque, id_produto, tipo, quantidade, data, motivo) VALUES
    (auditoria_seq, 102, 'SAIDA', 1, CURRENT_DATE, 'Venda Pedido ID ' || pedido_id);
    INSERT INTO AuditoriaEstoqueProduto (id_auditoriaEstoque, id_produto, tipo, quantidade, data, motivo) VALUES
    (auditoria_seq + 1, 103, 'SAIDA', 1, CURRENT_DATE, 'Venda Pedido ID ' || pedido_id);
    
    UPDATE Pedido SET status_pedido = 'EM_PROCESSAMENTO', data_pagamento = CURRENT_TIMESTAMP WHERE id_pedido = pedido_id;
    INSERT INTO Entrega (id_entrega, id_funcionario_entrega, pedido_id, previsao_entrega, status_entrega) VALUES
    (entrega_id, funcionario_id, pedido_id, CURRENT_TIMESTAMP + interval '10 minutes', 'EM_ROTA');
END $$ LANGUAGE plpgsql;

DO $$
DECLARE
    pagamento_id INT := 303;
    pedido_id INT := 4;
    cliente_id INT := 53;
    funcionario_id INT := 1;
    valor_itens DECIMAL(10,2) := 28.00;
    taxa_entrega DECIMAL(10,2) := 5.00;
    total_pedido DECIMAL(10,2) := 33.00;
BEGIN
    INSERT INTO Pagamento (id_pagamento, metodo, status) VALUES (pagamento_id, 'PIX', 'PENDENTE');
    INSERT INTO Pedido (id_pedido, id_cliente, id_pagamento, id_funcionario, data_pedido, status_pedido, total_pedido, valorItens, taxaEntrega) VALUES
    (pedido_id, cliente_id, pagamento_id, funcionario_id, CURRENT_TIMESTAMP, 'CRIADO', total_pedido, valor_itens, taxa_entrega);
    INSERT INTO ItemPedido (id_produto, id_pedido, quantidade, preco) VALUES
    (107, pedido_id, 1, 28.00);
    
    UPDATE Pagamento SET status = 'REJEITADO' WHERE id_pagamento = pagamento_id;
    UPDATE Pedido SET status_pedido = 'CANCELADO' WHERE id_pedido = pedido_id;
END $$ LANGUAGE plpgsql;

DO $$
DECLARE
    pagamento_id INT := 304;
    pedido_id INT := 5;
    auditoria_seq INT := 55;
    entrega_id INT := 4;
    cliente_id INT := 54;
    funcionario_id INT := 5;
    valor_itens DECIMAL(10,2) := 30.00;
    taxa_entrega DECIMAL(10,2) := 5.00;
    total_pedido DECIMAL(10,2) := 35.00;
BEGIN
    INSERT INTO Pagamento (id_pagamento, metodo, status) VALUES (pagamento_id, 'CARTAO', 'PENDENTE');
    INSERT INTO Pedido (id_pedido, id_cliente, id_pagamento, id_funcionario, data_pedido, status_pedido, total_pedido, valorItens, taxaEntrega) VALUES
    (pedido_id, cliente_id, pagamento_id, funcionario_id, CURRENT_TIMESTAMP, 'CRIADO', total_pedido, valor_itens, taxa_entrega);
    INSERT INTO ItemPedido (id_produto, id_pedido, quantidade, preco) VALUES
    (108, pedido_id, 1, 30.00);
    
    UPDATE Pagamento SET status = 'APROVADO' WHERE id_pagamento = pagamento_id;
    INSERT INTO AuditoriaEstoqueProduto (id_auditoriaEstoque, id_produto, tipo, quantidade, data, motivo) VALUES
    (auditoria_seq + 1, 108, 'SAIDA', 1, CURRENT_DATE, 'Venda Pedido ID ' || pedido_id);
    
    UPDATE Pedido SET status_pedido = 'PAGO', data_pagamento = CURRENT_TIMESTAMP WHERE id_pedido = pedido_id;
    INSERT INTO Entrega (id_entrega, id_funcionario_entrega, pedido_id, previsao_entrega, status_entrega) VALUES
    (entrega_id, funcionario_id, pedido_id, CURRENT_TIMESTAMP + interval '15 minutes', 'PREPARANDO');
END $$ LANGUAGE plpgsql;

DO $$
DECLARE
    pagamento_id INT := 305;
    pedido_id INT := 6;
    auditoria_seq INT := 56;
    entrega_id INT := 5;
    cliente_id INT := 55;
    funcionario_id INT := 9;
    valor_itens DECIMAL(10,2) := 58.00;
    taxa_entrega DECIMAL(10,2) := 5.00;
    total_pedido DECIMAL(10,2) := 63.00;
BEGIN
    INSERT INTO Pagamento (id_pagamento, metodo, status) VALUES (pagamento_id, 'PIX', 'PENDENTE');
    INSERT INTO Pedido (id_pedido, id_cliente, id_pagamento, id_funcionario, data_pedido, status_pedido, total_pedido, valorItens, taxaEntrega) VALUES
    (pedido_id, cliente_id, pagamento_id, funcionario_id, CURRENT_TIMESTAMP, 'CRIADO', total_pedido, valor_itens, taxa_entrega);
    INSERT INTO ItemPedido (id_produto, id_pedido, quantidade, preco) VALUES
    (100, pedido_id, 2, 25.00), (101, pedido_id, 2, 8.00);
    
    UPDATE Pagamento SET status = 'APROVADO' WHERE id_pagamento = pagamento_id;
    INSERT INTO AuditoriaEstoqueProduto (id_auditoriaEstoque, id_produto, tipo, quantidade, data, motivo) VALUES
    (auditoria_seq + 1, 100, 'SAIDA', 2, CURRENT_DATE, 'Venda Pedido ID ' || pedido_id);
    INSERT INTO AuditoriaEstoqueProduto (id_auditoriaEstoque, id_produto, tipo, quantidade, data, motivo) VALUES
    (auditoria_seq + 2, 101, 'SAIDA', 2, CURRENT_DATE, 'Venda Pedido ID ' || pedido_id);
    
    UPDATE Pedido SET status_pedido = 'PAGO', data_pagamento = CURRENT_TIMESTAMP WHERE id_pedido = pedido_id;
    INSERT INTO Entrega (id_entrega, id_funcionario_entrega, pedido_id, previsao_entrega, status_entrega) VALUES
    (entrega_id, funcionario_id, pedido_id, CURRENT_TIMESTAMP + interval '20 minutes', 'PREPARANDO');
END $$ LANGUAGE plpgsql;

DO $$
DECLARE
    pagamento_id INT := 306;
    pedido_id INT := 7;
    auditoria_seq INT := 58;
    entrega_id INT := 6;
    cliente_id INT := 56;
    funcionario_id INT := 1;
    valor_itens DECIMAL(10,2) := 25.00;
    taxa_entrega DECIMAL(10,2) := 5.00;
    total_pedido DECIMAL(10,2) := 30.00;
BEGIN
    INSERT INTO Pagamento (id_pagamento, metodo, status) VALUES (pagamento_id, 'CARTAO', 'PENDENTE');
    INSERT INTO Pedido (id_pedido, id_cliente, id_pagamento, id_funcionario, data_pedido, status_pedido, total_pedido, valorItens, taxaEntrega) VALUES
    (pedido_id, cliente_id, pagamento_id, funcionario_id, CURRENT_TIMESTAMP, 'CRIADO', total_pedido, valor_itens, taxa_entrega);
    INSERT INTO ItemPedido (id_produto, id_pedido, quantidade, preco) VALUES
    (100, pedido_id, 1, 25.00);
    
    UPDATE Pagamento SET status = 'APROVADO' WHERE id_pagamento = pagamento_id;
    INSERT INTO AuditoriaEstoqueProduto (id_auditoriaEstoque, id_produto, tipo, quantidade, data, motivo) VALUES
    (auditoria_seq + 1, 100, 'SAIDA', 1, CURRENT_DATE, 'Venda Pedido ID ' || pedido_id);
    
    UPDATE Pedido SET status_pedido = 'PAGO', data_pagamento = CURRENT_TIMESTAMP WHERE id_pedido = pedido_id;
    INSERT INTO Entrega (id_entrega, id_funcionario_entrega, pedido_id, previsao_entrega, status_entrega) VALUES
    (entrega_id, funcionario_id, pedido_id, CURRENT_TIMESTAMP + interval '25 minutes', 'PREPARANDO');
END $$ LANGUAGE plpgsql;

DO $$
DECLARE
    pagamento_id INT := 307;
    pedido_id INT := 8;
    auditoria_seq INT := 59;
    entrega_id INT := 7;
    cliente_id INT := 57;
    funcionario_id INT := 5;
    valor_itens DECIMAL(10,2) := 44.00;
    taxa_entrega DECIMAL(10,2) := 5.00;
    total_pedido DECIMAL(10,2) := 49.00;
BEGIN
    INSERT INTO Pagamento (id_pagamento, metodo, status) VALUES (pagamento_id, 'PIX', 'PENDENTE');
    INSERT INTO Pedido (id_pedido, id_cliente, id_pagamento, id_funcionario, data_pedido, status_pedido, total_pedido, valorItens, taxaEntrega) VALUES
    (pedido_id, cliente_id, pagamento_id, funcionario_id, CURRENT_TIMESTAMP, 'CRIADO', total_pedido, valor_itens, taxa_entrega);
    INSERT INTO ItemPedido (id_produto, id_pedido, quantidade, preco) VALUES
    (106, pedido_id, 1, 35.00), (105, pedido_id, 1, 9.00);
    
    UPDATE Pagamento SET status = 'APROVADO' WHERE id_pagamento = pagamento_id;
    INSERT INTO AuditoriaEstoqueProduto (id_auditoriaEstoque, id_produto, tipo, quantidade, data, motivo) VALUES
    (auditoria_seq + 1, 106, 'SAIDA', 1, CURRENT_DATE, 'Venda Pedido ID ' || pedido_id);
    INSERT INTO AuditoriaEstoqueProduto (id_auditoriaEstoque, id_produto, tipo, quantidade, data, motivo) VALUES
    (auditoria_seq + 2, 105, 'SAIDA', 1, CURRENT_DATE, 'Venda Pedido ID ' || pedido_id);
    
    UPDATE Pedido SET status_pedido = 'PAGO', data_pagamento = CURRENT_TIMESTAMP WHERE id_pedido = pedido_id;
    INSERT INTO Entrega (id_entrega, id_funcionario_entrega, pedido_id, previsao_entrega, status_entrega) VALUES
    (entrega_id, funcionario_id, pedido_id, CURRENT_TIMESTAMP + interval '30 minutes', 'PREPARANDO');
END $$ LANGUAGE plpgsql;

DO $$
DECLARE
    pagamento_id INT := 308;
    pedido_id INT := 9;
    entrega_id INT := 8;
    cliente_id INT := 58;
    funcionario_id INT := 9;
    valor_itens DECIMAL(10,2) := 30.00;
    taxa_entrega DECIMAL(10,2) := 5.00;
    total_pedido DECIMAL(10,2) := 35.00;
BEGIN
    INSERT INTO Pagamento (id_pagamento, metodo, status) VALUES (pagamento_id, 'DINHEIRO', 'PENDENTE');
    INSERT INTO Pedido (id_pedido, id_cliente, id_pagamento, id_funcionario, data_pedido, status_pedido, total_pedido, valorItens, taxaEntrega) VALUES
    (pedido_id, cliente_id, pagamento_id, funcionario_id, CURRENT_TIMESTAMP, 'CRIADO', total_pedido, valor_itens, taxa_entrega);
    INSERT INTO ItemPedido (id_produto, id_pedido, quantidade, preco) VALUES
    (108, pedido_id, 1, 30.00);
    
    UPDATE Pedido SET status_pedido = 'EM_PROCESSAMENTO' WHERE id_pedido = pedido_id;
    INSERT INTO Entrega (id_entrega, id_funcionario_entrega, pedido_id, previsao_entrega, status_entrega) VALUES
    (entrega_id, funcionario_id, pedido_id, CURRENT_TIMESTAMP + interval '35 minutes', 'PREPARANDO');
END $$ LANGUAGE plpgsql;

DO $$
DECLARE
    pagamento_id INT := 309;
    pedido_id INT := 10;
    auditoria_seq INT := 62;
    entrega_id INT := 9;
    cliente_id INT := 59;
    funcionario_id INT := 1;
    valor_itens DECIMAL(10,2) := 22.00;
    taxa_entrega DECIMAL(10,2) := 5.00;
    total_pedido DECIMAL(10,2) := 27.00;
BEGIN
    INSERT INTO Pagamento (id_pagamento, metodo, status) VALUES (pagamento_id, 'PIX', 'PENDENTE');
    INSERT INTO Pedido (id_pedido, id_cliente, id_pagamento, id_funcionario, data_pedido, status_pedido, total_pedido, valorItens, taxaEntrega) VALUES
    (pedido_id, cliente_id, pagamento_id, funcionario_id, CURRENT_TIMESTAMP, 'CRIADO', total_pedido, valor_itens, taxa_entrega);
    INSERT INTO ItemPedido (id_produto, id_pedido, quantidade, preco) VALUES
    (102, pedido_id, 1, 22.00);
    
    UPDATE Pagamento SET status = 'APROVADO' WHERE id_pagamento = pagamento_id;
    INSERT INTO AuditoriaEstoqueProduto (id_auditoriaEstoque, id_produto, tipo, quantidade, data, motivo) VALUES
    (auditoria_seq + 1, 102, 'SAIDA', 1, CURRENT_DATE, 'Venda Pedido ID ' || pedido_id);
    
    UPDATE Pedido SET status_pedido = 'EM_PROCESSAMENTO', data_pagamento = CURRENT_TIMESTAMP WHERE id_pedido = pedido_id;
    INSERT INTO Entrega (id_entrega, id_funcionario_entrega, pedido_id, previsao_entrega, status_entrega) VALUES
    (entrega_id, funcionario_id, pedido_id, CURRENT_TIMESTAMP + interval '40 minutes', 'PREPARANDO');
END $$ LANGUAGE plpgsql;