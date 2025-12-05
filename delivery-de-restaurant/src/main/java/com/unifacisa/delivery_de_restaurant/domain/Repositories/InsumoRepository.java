package com.unifacisa.delivery_de_restaurant.domain.Repositories;

import com.unifacisa.delivery_de_restaurant.domain.entities.Insumo;
import org.springframework.data.jpa.repository.JpaRepository;

public interface InsumoRepository extends JpaRepository<Insumo, Long> {
}
