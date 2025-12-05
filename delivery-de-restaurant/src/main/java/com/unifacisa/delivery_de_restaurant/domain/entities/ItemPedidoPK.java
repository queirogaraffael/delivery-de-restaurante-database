package com.unifacisa.delivery_de_restaurant.domain.entities;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@Embeddable
@Data
@AllArgsConstructor
@NoArgsConstructor
public class ItemPedidoPK implements Serializable {
    @Column(name = "id_pedido")
    private Long idPedido;

    @Column(name = "id_produto")
    private Long idProduto;
}