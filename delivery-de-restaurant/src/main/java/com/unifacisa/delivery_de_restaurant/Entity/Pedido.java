package com.unifacisa.delivery_de_restaurant.Entity;

import com.unifacisa.delivery_de_restaurant.Entity.enums.TipoPedidoStatus;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.Objects;

@Entity
@Getter
@Setter
public class Pedido implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_pagamento")
    private Long id;

    @ManyToOne
    @JoinColumn(name = "id_cliente", nullable = false)
    private Cliente cliente;

    @OneToOne
    @JoinColumn(name = "id_pagamento", nullable = false)
    private Pagamento pagamento;

    @ManyToOne
    @JoinColumn(name = "id_funcionario", nullable = false)
    private Funcionario funcionario;

    @Column(name = "data_pedido", nullable = false)
    private LocalDateTime dataPedido;

    @Enumerated(EnumType.STRING)
    @Column(name = "status_pedido", nullable = false, columnDefinition = "TipoPedidoStatus")
    private TipoPedidoStatus statusPedido;

    @Column(name = "total_pedido", nullable = false, precision = 10, scale = 2)
    private BigDecimal totalPedido;

    @Column(length = 255)
    private String observacao;

    @Column(name = "taxa_entrega", precision = 10, scale = 2)
    private BigDecimal taxaEntrega;

    @Column(name = "valor_itens", precision = 10, scale = 2)
    private BigDecimal valorItens;

    public Pedido() {

    }

    @Override
    public boolean equals(Object o) {
        if (o == null || getClass() != o.getClass()) return false;
        Pedido pedido = (Pedido) o;
        return Objects.equals(id, pedido.id) && Objects.equals(cliente, pedido.cliente) && Objects.equals(pagamento, pedido.pagamento) && Objects.equals(funcionario, pedido.funcionario) && Objects.equals(dataPedido, pedido.dataPedido) && statusPedido == pedido.statusPedido && Objects.equals(totalPedido, pedido.totalPedido) && Objects.equals(observacao, pedido.observacao) && Objects.equals(taxaEntrega, pedido.taxaEntrega) && Objects.equals(valorItens, pedido.valorItens);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, cliente, pagamento, funcionario, dataPedido, statusPedido, totalPedido, observacao, taxaEntrega, valorItens);
    }
}
