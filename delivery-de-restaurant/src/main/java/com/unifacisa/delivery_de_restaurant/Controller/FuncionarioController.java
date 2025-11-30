package com.unifacisa.delivery_de_restaurant.Controller;

import com.unifacisa.delivery_de_restaurant.Entity.Funcionario;
import com.unifacisa.delivery_de_restaurant.Service.FuncionarioService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import java.net.URI;
import java.util.List;

@RestController
@RequestMapping(value = "/funcionario")
public class FuncionarioController {

    @Autowired
    private FuncionarioService service;

    @GetMapping
    public ResponseEntity<List<Funcionario>> findAll(){
        List<Funcionario> funcionarios = service.findAll();
        return ResponseEntity.ok().body(funcionarios);
    }

    @GetMapping(value = "/{id}")
    public ResponseEntity<Funcionario> findById(@PathVariable Long id){
        Funcionario funcionario = service.findById(id);
        return ResponseEntity.ok().body(funcionario);
    }

    @PostMapping
    public ResponseEntity<Funcionario> insert(@RequestBody Funcionario funcionario){
        funcionario = service.insert(funcionario);
        URI uri = ServletUriComponentsBuilder.fromCurrentRequest().path("/{id}").buildAndExpand(funcionario.getId()).toUri();
        return ResponseEntity.created(uri).body(funcionario);
    }

    @DeleteMapping(value = "/{id}")
    public ResponseEntity<Funcionario> delete(@PathVariable Long id){
        service.delete(id);
        return ResponseEntity.noContent().build();
    }

    @PutMapping(value = "/{id}")
    public ResponseEntity<Funcionario> update(@PathVariable Long id, @RequestBody Funcionario funcionario){
        funcionario = service.update(id, funcionario);
        return ResponseEntity.ok().body(funcionario);
    }

}
