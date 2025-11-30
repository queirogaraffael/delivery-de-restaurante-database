package com.unifacisa.delivery_de_restaurant.Controller;

import com.unifacisa.delivery_de_restaurant.Entity.CategoriaProduto;
import com.unifacisa.delivery_de_restaurant.Service.CategoriaProdutoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import java.net.URI;
import java.util.List;

@RestController
@RequestMapping(value = "/categoria")
public class CategoriaProdutoController {

    @Autowired
    private CategoriaProdutoService service;

    @GetMapping
    public ResponseEntity<List<CategoriaProduto>> findAll(){
        List<CategoriaProduto> categorias = service.findAll();
        return ResponseEntity.ok().body(categorias);
    }

    @GetMapping(value = "/{id}")
    public ResponseEntity<CategoriaProduto> findById(@PathVariable Long id){
        CategoriaProduto categoria = service.findById(id);
        return ResponseEntity.ok().body(categoria);
    }

    @PostMapping
    public ResponseEntity<CategoriaProduto> insert(@RequestBody CategoriaProduto categoriaProduto){
        categoriaProduto = service.insert(categoriaProduto);
        URI uri = ServletUriComponentsBuilder.fromCurrentRequest().path("/{id}").buildAndExpand(categoriaProduto.getId()).toUri();
        return ResponseEntity.created(uri).body(categoriaProduto);
    }

    @DeleteMapping(value = "/{id}")
    public ResponseEntity<CategoriaProduto> delete(@PathVariable Long id){
        service.delete(id);
        return ResponseEntity.noContent().build();
    }

    @PutMapping(value = "/{id}")
    public ResponseEntity<CategoriaProduto> update(@PathVariable Long id, @RequestBody CategoriaProduto categoriaProduto){
        categoriaProduto = service.update(id, categoriaProduto);
        return ResponseEntity.ok().body(categoriaProduto);
    }

}
