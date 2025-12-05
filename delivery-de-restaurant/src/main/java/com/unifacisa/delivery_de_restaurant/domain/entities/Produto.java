package com.unifacisa.delivery_de_restaurant.domain.entities;

import com.unifacisa.delivery_de_restaurant.domain.enums.TipoUnidade;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;

@Entity
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Produto {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_produto")
    private Long id;

    @Column(length = 100, nullable = false)
    private String nome;

    @Enumerated(EnumType.STRING)
    @Column(name = "unidade_medida", columnDefinition = "TipoUnidade")
    private TipoUnidade unidadeMedida;

    @Column(name = "estoque_atual")
    private Integer estoqueAtual;

    @Column(name = "preco_venda", precision = 10, scale = 2)
    private BigDecimal precoVenda;

    @Column(length = 255)
    private String descricao;

    @ManyToOne
    @JoinColumn(name = "id_categoria", nullable = false)
    private CategoriaProduto categoria;
}