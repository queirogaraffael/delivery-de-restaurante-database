package com.unifacisa.delivery_de_restaurant.shared.dtos.itempedido;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ItemPedidoDTO {
    private Integer idProduto;
    private Integer quantidade;
}

