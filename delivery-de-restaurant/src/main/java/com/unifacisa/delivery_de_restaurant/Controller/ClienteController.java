package com.unifacisa.delivery_de_restaurant.Controller;

import com.unifacisa.delivery_de_restaurant.Entity.Cliente;
import com.unifacisa.delivery_de_restaurant.Service.ClienteService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import java.net.URI;
import java.util.List;

@RestController
@RequestMapping(value = "/cliente")
public class ClienteController {

    @Autowired
    private ClienteService service;

    @GetMapping
    public ResponseEntity<List<Cliente>> findAll(){
        List<Cliente> clientes = service.findAll();
        return ResponseEntity.ok().body(clientes);
    }

    @GetMapping(value = "/{id}")
    public ResponseEntity<Cliente> findById(@PathVariable Long id){
        Cliente cliente = service.findById(id);
        return ResponseEntity.ok().body(cliente);
    }

    @PostMapping
    public ResponseEntity<Cliente> insert(@RequestBody Cliente cliente){
        cliente = service.insert(cliente);
        URI uri = ServletUriComponentsBuilder.fromCurrentRequest().path("/{id}").buildAndExpand(cliente.getId()).toUri();
        return ResponseEntity.created(uri).body(cliente);
    }

    @DeleteMapping(value = "/{id}")
    public ResponseEntity<Cliente> delete(@PathVariable Long id){
        service.delete(id);
        return ResponseEntity.noContent().build();
    }

    @PutMapping(value = "/{id}")
    public ResponseEntity<Cliente> update(@PathVariable Long id, @RequestBody Cliente cliente){
        cliente = service.update(id, cliente);
        return ResponseEntity.ok().body(cliente);
    }

}
