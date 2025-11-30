package com.unifacisa.delivery_de_restaurant.Controller;

import com.unifacisa.delivery_de_restaurant.Entity.Endereco;
import com.unifacisa.delivery_de_restaurant.Service.EnderecoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import java.net.URI;
import java.util.List;

@RestController
@RequestMapping(value = "/endereco")
public class EnderecoController {

    @Autowired
    private EnderecoService service;

    @GetMapping
    public ResponseEntity<List<Endereco>> findAll(){
        List<Endereco> enderecos = service.findAll();
        return ResponseEntity.ok().body(enderecos);
    }

    @GetMapping(value = "/{id}")
    public ResponseEntity<Endereco> findById(@PathVariable Long id){
        Endereco endereco = service.findById(id);
        return ResponseEntity.ok().body(endereco);
    }

    @PostMapping
    public ResponseEntity<Endereco> insert(@RequestBody Endereco endereco){
        endereco = service.insert(endereco);
        URI uri = ServletUriComponentsBuilder.fromCurrentRequest().path("/{id}").buildAndExpand(endereco.getId()).toUri();
        return ResponseEntity.created(uri).body(endereco);
    }

    @DeleteMapping(value = "/{id}")
    public ResponseEntity<Endereco> delete(@PathVariable Long id){
        service.delete(id);
        return ResponseEntity.noContent().build();
    }

    @PutMapping(value = "/{id}")
    public ResponseEntity<Endereco> update(@PathVariable Long id, @RequestBody Endereco endereco){
        endereco = service.update(id, endereco);
        return ResponseEntity.ok().body(endereco);
    }

}
