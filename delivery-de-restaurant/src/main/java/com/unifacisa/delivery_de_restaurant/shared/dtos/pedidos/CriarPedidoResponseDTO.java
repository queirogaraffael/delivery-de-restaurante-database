package com.unifacisa.delivery_de_restaurant.shared.dtos.pedidos;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CriarPedidoResponseDTO {
    private BigDecimal totalCalculado;
    private Integer idPedidoGerado;
    private Integer idPagamentoGerado;
}
