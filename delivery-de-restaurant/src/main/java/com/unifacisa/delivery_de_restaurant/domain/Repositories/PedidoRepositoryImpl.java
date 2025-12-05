package com.unifacisa.delivery_de_restaurant.domain.Repositories;

import com.unifacisa.delivery_de_restaurant.shared.dtos.itempedido.ItemPedidoDTO;
import com.unifacisa.delivery_de_restaurant.shared.dtos.pedidos.ResultadoProcessarPedidoDTO;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import org.hibernate.Session;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;
import java.sql.Array;
import java.sql.CallableStatement;
import java.sql.Types;
import java.time.Duration;
import java.util.List;

@Repository
public class PedidoRepositoryImpl implements PedidoRepositoryCustom {

    @PersistenceContext
    private EntityManager em;

    @Override
    public ResultadoProcessarPedidoDTO processarNovoPedido(
            Integer idCliente,
            String metodoPagamento,
            Integer idFuncionarioAtendimento,
            Integer idFuncionarioEntrega,
            BigDecimal taxaEntrega,
            Duration previsaoEntrega,
            List<ItemPedidoDTO> itens,
            String observacao
    ) {

        return em.unwrap(Session.class).doReturningWork(connection -> {

            try (CallableStatement stmt = connection.prepareCall(
                    "CALL processar_novo_pedido(?, ?::TipoPagamentoMetodo, ?, ?, ?, ?::interval, ?, ?, ?, ?, ?)"
            )) {

                stmt.setInt(1, idCliente);
                stmt.setString(2, metodoPagamento);
                stmt.setInt(3, idFuncionarioAtendimento);
                stmt.setInt(4, idFuncionarioEntrega);
                stmt.setBigDecimal(5, taxaEntrega);
                stmt.setObject(6, previsaoEntrega != null ? previsaoEntrega.toString() : null, Types.OTHER);


                String[] itensFormatados = itens.stream()
                        .map(item -> String.format("(%d,%d)", item.getIdProduto(), item.getQuantidade()))
                        .toArray(String[]::new);

                Array arrayItens = connection.createArrayOf("ItemPedidoInfo_v2", itensFormatados);

                stmt.setArray(7, arrayItens);



                stmt.setArray(7, arrayItens);

                stmt.registerOutParameter(8, Types.NUMERIC);
                stmt.registerOutParameter(9, Types.INTEGER);
                stmt.registerOutParameter(10, Types.INTEGER);

                stmt.setString(11, observacao);

                stmt.execute();

                BigDecimal total = stmt.getBigDecimal(8);
                Integer pedidoGerado = stmt.getInt(9);
                Integer pagamentoGerado = stmt.getInt(10);

                return new ResultadoProcessarPedidoDTO(total, pedidoGerado, pagamentoGerado);
            }
        });
    }
}
