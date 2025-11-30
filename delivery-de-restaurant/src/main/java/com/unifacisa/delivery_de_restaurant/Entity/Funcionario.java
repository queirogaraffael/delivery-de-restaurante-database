package com.unifacisa.delivery_de_restaurant.Entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Objects;

@Entity
@Getter
@Setter
public class Funcionario implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_funcionario")
    private Long id;

    @Column(length = 100, nullable = false)
    private String nome;
    @Column(length = 11, nullable = false, unique = true)
    private String cpf;
    @Column(precision = 10, scale = 2, nullable = false)
    private BigDecimal salario;
    @Column(unique = true)
    private String telefone;

    public Funcionario() {

    }

    @Override
    public boolean equals(Object o) {
        if (o == null || getClass() != o.getClass()) return false;
        Funcionario that = (Funcionario) o;
        return Objects.equals(id, that.id) && Objects.equals(nome, that.nome) && Objects.equals(cpf, that.cpf) && Objects.equals(salario, that.salario) && Objects.equals(telefone, that.telefone);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, nome, cpf, salario, telefone);
    }
}
