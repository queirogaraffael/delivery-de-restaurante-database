package com.unifacisa.delivery_de_restaurant.Entity;

import com.unifacisa.delivery_de_restaurant.Entity.enums.TipoUnidade;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Objects;

@Entity
@Getter
@Setter
public class Produto implements Serializable {

    private static final long serialVersionUID = 1L;

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

    public Produto() {

    }

    @Override
    public boolean equals(Object o) {

        if (o == null || getClass() != o.getClass()) return false;
        Produto produto = (Produto) o;
        return Objects.equals(id, produto.id) && Objects.equals(nome, produto.nome) && unidadeMedida == produto.unidadeMedida && Objects.equals(estoqueAtual, produto.estoqueAtual) && Objects.equals(precoVenda, produto.precoVenda) && Objects.equals(descricao, produto.descricao) && Objects.equals(categoria, produto.categoria);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, nome, unidadeMedida, estoqueAtual, precoVenda, descricao, categoria);
    }
}
