package com.unifacisa.delivery_de_restaurant.Entity;

import com.unifacisa.delivery_de_restaurant.Entity.enums.TipoUnidade;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;
import java.time.LocalDate;
import java.util.Objects;

@Entity
@Getter
@Setter
public class Insumo implements Serializable {

    private static final long serialVersionUID = 1L;

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

    public Insumo() {

    }

    @Override
    public boolean equals(Object o) {

        if (o == null || getClass() != o.getClass()) return false;
        Insumo insumo = (Insumo) o;
        return perecivel == insumo.perecivel && Objects.equals(id, insumo.id) && Objects.equals(nome, insumo.nome) && unidadeMedida == insumo.unidadeMedida && Objects.equals(estoqueAtual, insumo.estoqueAtual) && Objects.equals(dataValidade, insumo.dataValidade);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, nome, unidadeMedida, estoqueAtual, perecivel, dataValidade);
    }
}
