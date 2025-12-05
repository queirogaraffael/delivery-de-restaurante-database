package com.unifacisa.delivery_de_restaurant.domain.Repositories;

import com.unifacisa.delivery_de_restaurant.shared.dtos.itempedido.ItemPedidoDTO;
import com.unifacisa.delivery_de_restaurant.shared.dtos.pedidos.ResultadoProcessarPedidoDTO;

import java.math.BigDecimal;
import java.time.Duration;
import java.util.List;

public interface PedidoRepositoryCustom {
    ResultadoProcessarPedidoDTO processarNovoPedido(
            Integer idCliente,
            String metodoPagamento,
            Integer idFuncionarioAtendimento,
            Integer idFuncionarioEntrega,
            BigDecimal taxaEntrega,
            Duration previsaoEntrega,
            List<ItemPedidoDTO> itens,
            String observacao
    );
}
