package com.unifacisa.delivery_de_restaurant.Controller;

import com.unifacisa.delivery_de_restaurant.Entity.Produto;
import com.unifacisa.delivery_de_restaurant.Service.ProdutoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import java.net.URI;
import java.util.List;

@RestController
@RequestMapping(value = "/produto")
public class ProdutoController {

    @Autowired
    private ProdutoService service;

    @GetMapping
    public ResponseEntity<List<Produto>> findAll(){
        List<Produto> produtos = service.findAll();
        return ResponseEntity.ok().body(produtos);
    }

    @GetMapping(value = "/{id}")
    public ResponseEntity<Produto> findById(@PathVariable Long id){
        Produto produto = service.findById(id);
        return ResponseEntity.ok().body(produto);
    }

    @PostMapping
    public ResponseEntity<Produto> insert(@RequestBody Produto produto){
        produto = service.insert(produto);
        URI uri = ServletUriComponentsBuilder.fromCurrentRequest().path("/{id}").buildAndExpand(produto.getId()).toUri();
        return ResponseEntity.created(uri).body(produto);
    }

    @DeleteMapping(value = "/{id}")
    public ResponseEntity<Produto> delete(@PathVariable Long id){
        service.delete(id);
        return ResponseEntity.noContent().build();
    }

    @PutMapping(value = "/{id}")
    public ResponseEntity<Produto> update(@PathVariable Long id, @RequestBody Produto produto){
        produto = service.update(id, produto);
        return ResponseEntity.ok().body(produto);
    }

}
