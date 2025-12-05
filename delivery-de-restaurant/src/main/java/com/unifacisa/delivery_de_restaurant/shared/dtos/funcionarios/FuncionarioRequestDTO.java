package com.unifacisa.delivery_de_restaurant.shared.dtos.funcionarios;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class FuncionarioRequestDTO {
    private String nome;
    private String cpf;
    private BigDecimal salario;
    private String cargo;
    private String telefone;
}
