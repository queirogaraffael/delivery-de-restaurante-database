package com.unifacisa.delivery_de_restaurant.Controller;

import com.unifacisa.delivery_de_restaurant.domain.entities.Pagamento;
import com.unifacisa.delivery_de_restaurant.domain.Service.PagamentoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import java.net.URI;
import java.util.List;

@RestController
@RequestMapping(value = "/pagamento")
public class PagamentoController {

    @Autowired
    private PagamentoService service;

    @GetMapping
    public ResponseEntity<List<Pagamento>> findAll(){
        List<Pagamento> pagamentos = service.findAll();
        return ResponseEntity.ok().body(pagamentos);
    }

    @GetMapping(value = "/{id}")
    public ResponseEntity<Pagamento> findById(@PathVariable Long id){
        Pagamento pagamento = service.findById(id);
        return ResponseEntity.ok().body(pagamento);
    }

    @PostMapping
    public ResponseEntity<Pagamento> insert(@RequestBody Pagamento pagamento){
        pagamento = service.insert(pagamento);
        URI uri = ServletUriComponentsBuilder.fromCurrentRequest().path("/{id}").buildAndExpand(pagamento.getId()).toUri();
        return ResponseEntity.created(uri).body(pagamento);
    }

    @DeleteMapping(value = "/{id}")
    public ResponseEntity<Pagamento> delete(@PathVariable Long id){
        service.delete(id);
        return ResponseEntity.noContent().build();
    }

    @PutMapping(value = "/{id}")
    public ResponseEntity<Pagamento> update(@PathVariable Long id, @RequestBody Pagamento pagamento){
        pagamento = service.update(id, pagamento);
        return ResponseEntity.ok().body(pagamento);
    }

}
