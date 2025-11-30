package com.unifacisa.delivery_de_restaurant.Entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;
import java.util.Objects;

@Entity
@Getter
@Setter
public class Endereco implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_endereco")
    private Long id;

    @Column(length = 100, nullable = false)
    private String rua;
    @Column(length = 10, nullable = false)
    private String numero;
    @Column(length = 100, nullable = false)
    private String bairro;
    @Column(length = 100, nullable = false)
    private String cidade;
    @Column(length = 8, nullable = false)
    private String cep;
    @Column(length = 100, nullable = false)
    private String complemento;

    @OneToOne
    @JoinColumn(name = "id_cliente", nullable = false, unique = true)
    @JsonIgnore
    private Cliente cliente;

    public Endereco() {

    }

    @Override
    public boolean equals(Object o) {
        if (o == null || getClass() != o.getClass()) return false;
        Endereco endereco = (Endereco) o;
        return Objects.equals(id, endereco.id) && Objects.equals(rua, endereco.rua) && Objects.equals(numero, endereco.numero) && Objects.equals(bairro, endereco.bairro) && Objects.equals(cidade, endereco.cidade) && Objects.equals(cep, endereco.cep) && Objects.equals(complemento, endereco.complemento) && Objects.equals(cliente, endereco.cliente);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, rua, numero, bairro, cidade, cep, complemento, cliente);
    }
}
