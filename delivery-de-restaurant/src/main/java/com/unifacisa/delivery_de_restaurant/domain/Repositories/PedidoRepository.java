package com.unifacisa.delivery_de_restaurant.domain.Repositories;

import com.unifacisa.delivery_de_restaurant.domain.entities.Pedido;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.math.BigDecimal;

public interface PedidoRepository extends JpaRepository<Pedido, Long>, PedidoRepositoryCustom {

    @Query(value = "SELECT fn_calcular_total_pedido(:idPedido)", nativeQuery = true)
    BigDecimal calcularTotalPedido(@Param("idPedido") Integer idPedido);
}

