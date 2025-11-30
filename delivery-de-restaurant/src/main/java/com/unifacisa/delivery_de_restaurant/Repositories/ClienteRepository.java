package com.unifacisa.delivery_de_restaurant.Repositories;

import com.unifacisa.delivery_de_restaurant.Entity.Cliente;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ClienteRepository extends JpaRepository<Cliente, Long> {

}
