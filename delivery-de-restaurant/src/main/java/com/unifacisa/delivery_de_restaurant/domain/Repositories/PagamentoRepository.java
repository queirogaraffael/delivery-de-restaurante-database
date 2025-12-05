package com.unifacisa.delivery_de_restaurant.domain.Repositories;

import com.unifacisa.delivery_de_restaurant.domain.entities.Pagamento;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PagamentoRepository extends JpaRepository<Pagamento, Long> {
}
