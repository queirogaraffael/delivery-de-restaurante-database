package com.unifacisa.delivery_de_restaurant.Repositories;

import com.unifacisa.delivery_de_restaurant.Entity.Pedido;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.math.BigDecimal;

public interface PedidoRepository extends JpaRepository<Pedido, Long> {

    @Query(value = "SELECT fn_calcular_total_pedido(:id)", nativeQuery = true)
    BigDecimal calcularTotalViaBanco(@Param("id") Long id);

    @Modifying
    @Query(value = "CALL prc_fechar_pedido(:id)", nativeQuery = true)
    void fecharPedidoViaProcedure(@Param("id") Long id);
}
