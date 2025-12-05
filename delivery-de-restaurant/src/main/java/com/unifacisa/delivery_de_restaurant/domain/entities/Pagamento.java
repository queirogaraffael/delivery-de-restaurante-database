package com.unifacisa.delivery_de_restaurant.domain.entities;

import com.unifacisa.delivery_de_restaurant.domain.enums.TipoPagamentoMetodo;
import com.unifacisa.delivery_de_restaurant.domain.enums.TipoPagamentoStatus;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Entity
@Getter
@Setter
public class Pagamento {

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
}