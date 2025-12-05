package com.unifacisa.delivery_de_restaurant.domain.entities;

import com.unifacisa.delivery_de_restaurant.domain.enums.TipoUnidade;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;

@Entity
@Getter
@Setter
public class Insumo {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_insumo")
    private Long id;

    @Column(length = 255)
    private String nome;

    @Enumerated(EnumType.STRING)
    @Column(name = "unidade_medida", columnDefinition = "TipoUnidade")
    private TipoUnidade unidadeMedida;

    @Column(name = "estoque_atual")
    private Integer estoqueAtual;
    private boolean perecivel;

    @Column(name = "data_validade")
    private LocalDate dataValidade;
}
