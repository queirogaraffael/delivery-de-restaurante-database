package com.unifacisa.delivery_de_restaurant.shared.dtos.pedidos;

import com.unifacisa.delivery_de_restaurant.shared.dtos.itempedido.ItemPedidoDTO;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CriarPedidoRequestDTO {

    private Integer idCliente;
    private String metodoPagamento;
    private Integer idFuncionarioAtendimento;
    private Integer idFuncionarioEntrega;
    private BigDecimal taxaEntrega;
    private Long previsaoEntregaMinutos;
    private List<ItemPedidoDTO> itens;
    private String observacao;
}
