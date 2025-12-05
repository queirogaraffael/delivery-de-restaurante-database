# 🍔 Sistema de Delivery de Restaurante

Este projeto consiste em um sistema completo para gestão de um
restaurante delivery. A arquitetura adotada é a **Logic-in-Database**,
onde a integridade dos dados, regras de negócio complexas (como baixa de
estoque e validação de pedidos) e auditoria são processadas diretamente
no banco de dados **PostgreSQL** através de *Stored Procedures* e
*Triggers*.

O **Back-end em Spring Boot** atua como uma camada de serviço robusta,
expondo essas funcionalidades via API REST e gerenciando a comunicação
entre o cliente e o banco de dados.

## 🚀 Tecnologias Utilizadas

-   **Java 17** & **Spring Boot 3+**: Framework para a API REST.
-   **PostgreSQL**: Banco de dados relacional (com uso intensivo de
    PL/pgSQL).
-   **Maven**: Gerenciamento de dependências e build.
-   **JPA / Hibernate**: Mapeamento Objeto-Relacional (para consultas
    simples e chamada de procedures).
-   **Lombok**: Redução de código boilerplate.

## 📂 Estrutura do Projeto

O repositório está organizado nos seguintes diretórios principais:

-   **`delivery-de-restaurant/`**: Contém o código fonte da aplicação
    Java (Spring Boot).
    -   `src/main/java`: Controllers, Entities, Repositories e Services.
    -   `src/main/resources`: Configurações da aplicação
        (`application.properties`).
-   **`sql-scripts/`**: Contém os scripts SQL essenciais para a criação
    e funcionamento do banco. Eles estão numerados para execução
    sequencial.
-   **`docs/`**: Documentação técnica, incluindo o modelo lógico do
    banco de dados (imagens e PDFs) e visão de negócio.
-   **`postman/`**: Coleção do Postman (`.json`) para testar os
    endpoints da API rapidamente.

## ⚙️ Pré-requisitos

-   JDK 17 instalado.
-   PostgreSQL instalado e rodando.

------------------------------------------------------------------------

## 🛠️ Como Rodar o Projeto

### Passo 1: Configuração do Banco de Dados

Como o projeto depende fortemente da lógica no banco, esta etapa é
crucial. Você deve executar os scripts na ordem numérica correta para
evitar erros de dependência.

1.  Crie um banco de dados no PostgreSQL com o nome
    `delivery_restaurante`.
2.  Execute os scripts da pasta `sql-scripts` na seguinte ordem:

  ------------------------------------------------------------------------
  Ordem                   Arquivo                  Descrição
  ----------------------- ------------------------ -----------------------
  1️⃣                      `1_ddl_completo.sql`     Cria as tabelas, tipos
                                                   (ENUMs) e restrições.

  2️⃣                      `2_dados_base.sql`       Popula o banco com
                                                   dados iniciais
                                                   (Clientes, Produtos,
                                                   etc).

  3️⃣                      `3_fluxo_compras.sql`    Cria triggers para
                                                   entrada de estoque via
                                                   Nota Fiscal.

  4️⃣                      `4_fluxo_producao.sql`   Cria procedures para
                                                   transformar insumos em
                                                   produtos.

  5️⃣                      `5_fluxo_venda.sql`      Cria a procedure
                                                   principal de venda e
                                                   triggers de pagamento.

  6️⃣                      `6_views.sql`            Cria as views para
                                                   relatórios gerenciais.
  ------------------------------------------------------------------------

### Passo 2: Configuração da API

1.  Navegue até o diretório do backend:
    `bash     cd delivery-de-restaurant`
2.  Abra o arquivo `src/main/resources/application.properties` e
    verifique as credenciais do banco de dados. Ajuste se o seu
    usuário/senha forem diferentes do padrão configurado:
    `properties     spring.datasource.username=postgres     spring.datasource.password=1234567`
3.  Execute a aplicação usando o Maven Wrapper:
    -   **Windows:** `cmd     mvnw.cmd spring-boot:run`
    -   **Linux/Mac:** `bash     ./mvnw spring-boot:run`

A API estará disponível em: `http://localhost:8080`

------------------------------------------------------------------------

## 🔌 Utilizando a API

A aplicação expõe endpoints para interagir com o banco de dados. As
operações complexas (como criar um pedido) chamam diretamente as
procedures do banco.

### Principais Endpoints

-   **Funcionários**: `GET /funcionarios`, `POST /funcionarios`,
    `PUT /funcionarios/{id}`
-   **Insumos**: `GET /insumos`, `POST /insumos`
-   **Pedidos**:
    -   `POST /pedidos/gerar`: Cria um pedido completo (chama a
        procedure `processar_novo_pedido`).
    -   `GET /pedidos/{id}/total`: Calcula o total do pedido via função
        do banco.

### Testando com Postman

Para facilitar os testes, importe o arquivo localizado em
`postman/Conectar BD com POO.postman_collection.json` para o seu
Postman. Lá você encontrará requisições prontas para todos os fluxos.
