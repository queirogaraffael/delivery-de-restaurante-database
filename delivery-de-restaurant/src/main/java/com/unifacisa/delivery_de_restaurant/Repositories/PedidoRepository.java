package com.unifacisa.delivery_de_restaurant.Repositories;

import com.unifacisa.delivery_de_restaurant.Entity.Pagamento;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PedidoRepository extends JpaRepository<Pagamento, Long> {

}
