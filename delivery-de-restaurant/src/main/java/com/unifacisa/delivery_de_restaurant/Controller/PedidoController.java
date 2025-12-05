package com.unifacisa.delivery_de_restaurant.Controller;

import com.unifacisa.delivery_de_restaurant.domain.Service.PedidoService;
import com.unifacisa.delivery_de_restaurant.shared.dtos.pedidos.CriarPedidoRequestDTO;
import com.unifacisa.delivery_de_restaurant.shared.dtos.pedidos.CriarPedidoResponseDTO;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;

@RestController
@RequestMapping(value = "/pedidos")
public class PedidoController {

    @Autowired
    private PedidoService pedidoService;

    @GetMapping("/{id}/total")
    public ResponseEntity<BigDecimal> getTotal(@PathVariable Integer id) {
        return ResponseEntity.ok(pedidoService.calcularTotal(id));
    }

    @PostMapping("/gerar")
    public ResponseEntity<CriarPedidoResponseDTO> criarPedido(@Valid
            @RequestBody CriarPedidoRequestDTO request
    ) {
        CriarPedidoResponseDTO response = pedidoService.criarPedido(request);
        return ResponseEntity.ok(response);
    }

}
