package com.unifacisa.delivery_de_restaurant.domain.Repositories;

import com.unifacisa.delivery_de_restaurant.domain.entities.Funcionario;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface FuncionarioRepository extends JpaRepository<Funcionario, Long> {
    Optional<Funcionario> findByIdAndAtivoTrue(Long id);
}