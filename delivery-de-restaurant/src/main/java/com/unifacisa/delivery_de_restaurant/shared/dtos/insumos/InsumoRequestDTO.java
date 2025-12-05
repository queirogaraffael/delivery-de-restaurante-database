package com.unifacisa.delivery_de_restaurant.shared.dtos.insumos;

import com.unifacisa.delivery_de_restaurant.domain.enums.TipoUnidade;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class InsumoRequestDTO {
    private String nome;
    private TipoUnidade unidadeMedida;
    private Integer estoqueAtual;
    private boolean perecivel;
    private LocalDate dataValidade;
}
