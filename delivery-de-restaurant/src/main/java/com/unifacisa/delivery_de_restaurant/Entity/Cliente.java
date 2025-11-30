package com.unifacisa.delivery_de_restaurant.Entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import org.springframework.stereotype.Service;

import java.io.Serializable;
import java.util.Objects;

@Entity
@Getter
@Setter
public class Cliente implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_cliente")
    private Long id;
    @Column(length = 100, nullable = false)
    private String nome;
    @Column(length = 11, unique = true, nullable = false)
    private String cpf;
    @Column(length = 255, unique = true, nullable = false)
    private String email;
    @Column(length = 100)
    private String telefone;

    @OneToOne(mappedBy = "cliente", cascade = CascadeType.ALL)
    private Endereco endereco;

    public Cliente() {

    }

    @Override
    public boolean equals(Object o) {

        if (o == null || getClass() != o.getClass()) return false;
        Cliente cliente = (Cliente) o;
        return Objects.equals(id, cliente.id) && Objects.equals(nome, cliente.nome) && Objects.equals(cpf, cliente.cpf) && Objects.equals(email, cliente.email) && Objects.equals(telefone, cliente.telefone) && Objects.equals(endereco, cliente.endereco);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, nome, cpf, email, telefone, endereco);
    }
}
