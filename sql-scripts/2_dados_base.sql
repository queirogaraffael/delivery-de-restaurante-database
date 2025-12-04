-- Trigger de validação da data de insumo

CREATE OR REPLACE FUNCTION fn_validar_data_insumo()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.data_validade < CURRENT_DATE AND NEW.data_validade IS NOT NULL THEN
        RAISE EXCEPTION 'ERRO: O insumo "%" não pode ser cadastrado pois está vencido. Validade: %, Hoje: %', 
            NEW.nome, 
            TO_CHAR(NEW.data_validade, 'DD/MM/YYYY'), 
            TO_CHAR(CURRENT_DATE, 'DD/MM/YYYY');
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_antes_inserir_insumo
BEFORE INSERT ON Insumo
FOR EACH ROW
EXECUTE FUNCTION fn_validar_data_insumo();

---

INSERT INTO Funcionario (id_funcionario, nome, cpf, salario, cargo, telefone) VALUES
(1, 'Joana Silva', '11111111111', 3000.00, 'Entregadora', '999999999'),
(2, 'Carlos Souza', '22222222222', 4500.00, 'Gerente de Produção', '888888888'),
(3, 'Pedro Álvares', '33333333333', 3200.00, 'Cozinheiro Chefe', '777777777'),
(4, 'Ana Luiza', '44444444444', 2800.00, 'Atendente', '666666666'),
(5, 'Ricardo Martins', '55555555555', 3100.00, 'Entregador', '555555555'),
(6, 'Fernanda Costa', '66666666666', 4800.00, 'Gerente de Vendas', '444444444'),
(7, 'Gabriel Lima', '77777777777', 3500.00, 'Cozinheiro', '333333333'),
(8, 'Beatriz Santos', '88888888888', 2900.00, 'Atendente', '222222222'),
(9, 'Fábio Melo', '99999999999', 3000.00, 'Entregador', '111111111'),
(10, 'Lara Rezende', '10101010101', 3300.00, 'Supervisor de Estoque', '101010101');

INSERT INTO CategoriaProduto (id_categoria, nome, descricao) VALUES
(1, 'Bebidas', 'Refrigerantes, sucos e águas.'),
(2, 'Lanches', 'Hambúrgueres e sanduíches.'),
(3, 'Ingredientes Base', 'Itens brutos para fabricação.'),
(4, 'Sobremesas', 'Doces e pudins.'),
(5, 'Acompanhamentos', 'Batata frita, anéis de cebola.'),
(6, 'Marmitas', 'Pratos prontos para o almoço.'),
(7, 'Saladas', 'Opções saudáveis.'),
(8, 'Molhos', 'Molhos diversos e temperos.'),
(9, 'Vegan', 'Opções totalmente vegetais.'),
(10, 'Infantil', 'Combos e pratos para crianças.');

INSERT INTO Insumo (id_insumo, nome, unidade_medida, estoque_atual, perecivel, data_validade) VALUES
(10, 'Pão de Hambúrguer', 'UN', 50, TRUE, '2025-12-01'),
(11, 'Carne Moída (Kg)', 'KG', 10, TRUE, '2025-11-15'),
(12, 'Queijo Muçarela', 'KG', 5, TRUE, '2025-12-30'),
(13, 'Alface Americana', 'UN', 0, TRUE, '2025-11-10'),
(14, 'Tomate', 'KG', 0, TRUE, '2025-11-12'),
(15, 'Óleo Vegetal (L)', 'L', 0, FALSE, '2026-06-01'),
(16, 'Açúcar (Kg)', 'KG', 0, FALSE, '2027-01-01'),
(17, 'Farinha de Trigo (Kg)', 'KG', 0, FALSE, '2026-03-01'),
(18, 'Frango (Kg)', 'KG', 0, TRUE, '2025-11-20'),
(19, 'Cebola', 'KG', 0, TRUE, '2025-12-05'),
(20, 'Embalagem Descartável', 'UN', 0, FALSE, '2027-12-31'),
(21, 'Bacon (Kg)', 'KG', 0, TRUE, '2025-12-05'),
(22, 'Feijão (Kg)', 'KG', 0, FALSE, '2026-10-01'),
(23, 'Arroz (Kg)', 'KG', 0, FALSE, '2026-10-01'),
(24, 'Molho Caesar (L)', 'L', 0, TRUE, '2025-12-15'),
(25, 'Leite Condensado (UN)', 'UN', 0, FALSE, '2026-05-01'),
(26, 'Ovos (UN)', 'UN', 0, TRUE, '2025-12-10'),
(27, 'Leite (L)', 'L', 0, TRUE, '2025-12-08'),
(28, 'Sorvete (L)', 'L', 0, TRUE, '2026-01-01'),
(29, 'Brownie Prémix (Kg)', 'KG', 0, FALSE, '2026-03-01'),
(30, 'Nuggets de Frango (Kg)', 'KG', 0, TRUE, '2025-12-20'),
(31, 'Batata Inglesa (Kg)', 'KG', 50, TRUE, '2025-12-15');

INSERT INTO Produto (id_produto, id_categoria, nome, unidade_medida, estoque_atual, preco_venda, descricao) VALUES
(100, 2, 'X-Salada Gourmet', 'UN', 0, 25.00, 'Sanduíche completo com molho especial.'),
(101, 1, 'Refrigerante Cola', 'L', 30, 8.00, 'Refrigerante 2 Litros.'),
(102, 2, 'X-Bacon Simples', 'UN', 0, 22.00, 'Hambúrguer com bacon e queijo.'),
(103, 5, 'Batata Frita Média', 'UN', 0, 12.00, 'Porção de batata frita.'),
(104, 4, 'Pudim de Leite', 'UN', 0, 10.00, 'Clássico pudim de leite condensado.'),
(105, 1, 'Suco de Laranja (L)', 'L', 15, 9.00, 'Suco natural de laranja.'),
(106, 6, 'Marmita Frango Grelhado', 'UN', 0, 35.00, 'Frango, arroz, feijão e salada.'),
(107, 7, 'Salada Caesar', 'UN', 0, 28.00, 'Salada com croutons e molho Caesar.'),
(108, 2, 'Burger Vegano', 'UN', 0, 30.00, 'Hambúrguer de grão de bico.'),
(109, 1, 'Água Mineral', 'UN', 50, 4.00, 'Água sem gás 500ml.'),
(110, 2, 'X-Frango Crocante', 'UN', 0, 24.00, 'Sanduíche de frango empanado com maionese da casa.'),
(111, 5, 'Onion Rings Média', 'UN', 0, 14.00, 'Anéis de cebola empanados.'),
(112, 1, 'Suco de Maracujá (L)', 'L', 18, 9.00, 'Suco natural de maracujá.'),
(113, 4, 'Mousse de Maracujá', 'UN', 6, 8.00, 'Sobremesa cremosa de maracujá.'),
(114, 6, 'Marmita Bovina Acebolada', 'UN', 0, 38.00, 'Carne bovina acebolada, arroz, feijão e salada.'),
(115, 7, 'Salada Mediterrânea', 'UN', 0, 30.00, 'Salada com tomate, queijo branco, azeite e ervas.'),
(116, 2, 'X-Tudo Premium', 'UN', 0, 32.00, 'Hambúrguer completo com bacon, ovo e molho especial.'),
(117, 1, 'Chá Gelado Limão', 'L', 20, 7.00, 'Chá gelado sabor limão.'),
(118, 5, 'Batata Frita Grande', 'UN', 0, 16.00, 'Porção grande de batata frita crocante.'),
(119, 4, 'Brownie com Sorvete', 'UN', 4, 15.00, 'Brownie quente com bola de sorvete.'),
(120, 2, 'X-Picanha Artesanal', 'UN', 0, 36.00, 'Hambúrguer de picanha com queijo e molho da casa.'),
(121, 6, 'Marmita Vegetariana', 'UN', 0, 33.00, 'Legumes salteados, arroz, feijão e salada.'),
(122, 1, 'Refrigerante Guaraná', 'L', 25, 8.00, 'Garrafa de 2 Litros.'),
(123, 7, 'Salada Tropical', 'UN', 0, 27.00, 'Salada com frutas, folhas verdes e molho leve.'),
(124, 5, 'Porção de Nuggets', 'UN', 0, 13.00, 'Porção de nuggets de frango.'),
(125, 4, 'Torta de Limão', 'UN', 0, 12.00, 'Torta de limão com base crocante.'); 

INSERT INTO Cliente (id_cliente, nome, cpf, email, telefone) VALUES
(50, 'Maria Oliveira', '33333333333', 'maria@email.com', '777777777'),
(51, 'João Pereira', '12312312312', 'joao@email.com', '121212121'),
(52, 'Amanda Rocha', '45645645645', 'amanda@email.com', '343434343'),
(53, 'Roberto Farias', '78978978978', 'roberto@email.com', '565656565'),
(54, 'Luciana Gomes', '98765432198', 'luciana@email.com', '787878787'),
(55, 'Marcos Vinícius', '65432198765', 'marcos@email.com', '909090909'),
(56, 'Carla Prado', '32165498732', 'carla@email.com', '131313131'),
(57, 'Daniel Alves', '14725836914', 'daniel@email.com', '242424242'),
(58, 'Elisa Nogueira', '36925814736', 'elisa@email.com', '353535353'),
(59, 'Felipe Castro', '25836914725', 'felipe@email.com', '464646464');

INSERT INTO Endereco (id_endereco, id_cliente, rua, numero, bairro, cidade, cep, complemento) VALUES
(500, 50, 'Rua das Flores', '15A', 'Centro', 'Cidade Modelo', '58000000', NULL),
(501, 51, 'Avenida Principal', '100', 'Bairro Novo', 'Cidade Modelo', '58000001', 'Apto 101'),
(502, 52, 'Rua da Paz', '22', 'Jardim', 'Cidade Modelo', '58000002', NULL),
(503, 53, 'Travessa das Acácias', '55', 'Industrial', 'Cidade Modelo', '58000003', 'Casa 2'),
(504, 54, 'Estrada Velha', '1200', 'Zona Rural', 'Cidade Modelo', '58000004', 'Sítio'),
(505, 55, 'Rua do Comércio', '300', 'Centro', 'Cidade Modelo', '58000005', 'Loja B'),
(506, 56, 'Alameda dos Pássaros', '45', 'Vila Rica', 'Cidade Modelo', '58000006', NULL),
(507, 57, 'Praça da Liberdade', '1', 'Praça', 'Cidade Modelo', '58000007', 'Kiosque'),
(508, 58, 'Rua Sete', '77', 'Setor Oeste', 'Cidade Modelo', '58000008', 'Bloco C'),
(509, 59, 'Rua Quinze', '15', 'Norte', 'Cidade Modelo', '58000009', 'Fundos');

INSERT INTO Fornecedor (id_fornecedor, nome, cnpj, descricao) VALUES
(1000, 'Distribuidora Alimentos A', '44444444000144', 'Pães e Laticínios.'),
(1001, 'Carnes Premium Ltda', '11111111000111', 'Carnes e derivados.'),
(1002, 'Bebidas e Cia', '22222222000122', 'Refrigerantes e sucos prontos.'),
(1003, 'Hortifruti Fresco', '33333333000133', 'Frutas, legumes e verduras.'),
(1004, 'Embalagens TOP', '55555555000155', 'Embalagens e descartáveis.'),
(1005, 'Grãos Essenciais', '66666666000166', 'Farinhas e açúcares.'),
(1006, 'Laticínios da Serra', '77777777000177', 'Queijos e derivados frescos.'),
(1007, 'Delivery SUPORTE', '88888888000188', 'Serviços de manutenção e software.'),
(1008, 'Frangos Nobres', '99999999000199', 'Produtos de frango e aves.'),
(1009, 'Temperos do Mundo', '10101010000101', 'Especiarias e condimentos.');