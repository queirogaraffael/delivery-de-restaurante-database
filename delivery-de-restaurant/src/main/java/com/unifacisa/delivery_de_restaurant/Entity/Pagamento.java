package com.unifacisa.delivery_de_restaurant.Entity;

import com.unifacisa.delivery_de_restaurant.Entity.enums.TipoPagamentoMetodo;
import com.unifacisa.delivery_de_restaurant.Entity.enums.TipoPagamentoStatus;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.Objects;

@Entity
@Getter
@Setter
public class Pagamento implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_pagamento")
    private Long id;

    @Enumerated(EnumType.STRING)
    @Column(name = "metodo_pagamento", columnDefinition = "TipoPagamentoMetodo")
    private TipoPagamentoMetodo metodoPagamento;

    @Enumerated(EnumType.STRING)
    @Column(name = "status_pagamento", columnDefinition = "TipoPagamentoStatus")
    private TipoPagamentoStatus statusPagamento;

    @Column(name = "data_pagamento")
    private LocalDateTime dataPagamento;

    public Pagamento() {

    }

    @Override
    public boolean equals(Object o) {
        if (o == null || getClass() != o.getClass()) return false;
        Pagamento pagamento = (Pagamento) o;
        return Objects.equals(id, pagamento.id) && metodoPagamento == pagamento.metodoPagamento && statusPagamento == pagamento.statusPagamento && Objects.equals(dataPagamento, pagamento.dataPagamento);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, metodoPagamento, statusPagamento, dataPagamento);
    }
}