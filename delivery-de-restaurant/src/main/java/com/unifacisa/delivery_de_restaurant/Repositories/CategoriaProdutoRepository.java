package com.unifacisa.delivery_de_restaurant.Repositories;

import com.unifacisa.delivery_de_restaurant.Entity.CategoriaProduto;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CategoriaProdutoRepository extends JpaRepository<CategoriaProduto, Long> {

}
