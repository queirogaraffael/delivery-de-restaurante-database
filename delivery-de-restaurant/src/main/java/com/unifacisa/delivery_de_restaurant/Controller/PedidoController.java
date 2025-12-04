package com.unifacisa.delivery_de_restaurant.Controller;

import com.unifacisa.delivery_de_restaurant.Entity.Pedido;
import com.unifacisa.delivery_de_restaurant.Service.PedidoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import java.math.BigDecimal;
import java.net.URI;
import java.util.List;

@RestController
@RequestMapping(value = "/pedido")
public class PedidoController {

    @Autowired
    private PedidoService service;

    @GetMapping
    public ResponseEntity<List<Pedido>> findAll(){
        List<Pedido> pedidos = service.findAll();
        return ResponseEntity.ok().body(pedidos);
    }

    @GetMapping(value = "/{id}")
    public ResponseEntity<Pedido> findById(@PathVariable Long id){
        Pedido pedido = service.findById(id);
        return ResponseEntity.ok().body(pedido);
    }

    @PostMapping
    public ResponseEntity<Pedido> insert(@RequestBody Pedido pedido){
        pedido = service.insert(pedido);
        URI uri = ServletUriComponentsBuilder.fromCurrentRequest().path("/{id}").buildAndExpand(pedido.getId()).toUri();
        return ResponseEntity.created(uri).body(pedido);
    }

    @DeleteMapping(value = "/{id}")
    public ResponseEntity<Pedido> delete(@PathVariable Long id){
        service.delete(id);
        return ResponseEntity.noContent().build();
    }

    @PutMapping(value = "/{id}")
    public ResponseEntity<Pedido> update(@PathVariable Long id, @RequestBody Pedido pedido){
        pedido = service.update(id, pedido);
        return ResponseEntity.ok().body(pedido);
    }

    @GetMapping("/{id}/total-db")
    public ResponseEntity<BigDecimal> getTotalDb(@PathVariable Long id) {
        BigDecimal total = service.obterTotalDoBanco(id);
        return ResponseEntity.ok(total);
    }

    @PutMapping("/{id}/fechar-db")
    public ResponseEntity<String> fecharPedidoDb(@PathVariable Long id) {
        service.fecharPedidoNoBanco(id);
        return ResponseEntity.ok("Sucesso! Procedure executada e pedido fechado.");
    }

}
