package com.unifacisa.delivery_de_restaurant.Repositories;

import com.unifacisa.delivery_de_restaurant.Entity.Produto;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ProdutoRepository extends JpaRepository<Produto, Long> {
}
