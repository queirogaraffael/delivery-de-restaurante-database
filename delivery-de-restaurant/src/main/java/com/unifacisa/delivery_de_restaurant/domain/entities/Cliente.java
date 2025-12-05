package com.unifacisa.delivery_de_restaurant.domain.entities;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Cliente {

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
}