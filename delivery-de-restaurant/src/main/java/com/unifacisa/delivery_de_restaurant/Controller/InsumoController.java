package com.unifacisa.delivery_de_restaurant.Controller;

import com.unifacisa.delivery_de_restaurant.Entity.Insumo;
import com.unifacisa.delivery_de_restaurant.Service.InsumoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import java.net.URI;
import java.util.List;

@RestController
@RequestMapping(value = "/insumo")
public class InsumoController {

    @Autowired
    private InsumoService service;

    @GetMapping
    public ResponseEntity<List<Insumo>> findAll(){
        List<Insumo> insumos = service.findAll();
        return ResponseEntity.ok().body(insumos);
    }

    @GetMapping(value = "/{id}")
    public ResponseEntity<Insumo> findById(@PathVariable Long id){
        Insumo insumo = service.findById(id);
        return ResponseEntity.ok().body(insumo);
    }

    @PostMapping
    public ResponseEntity<Insumo> insert(@RequestBody Insumo insumo){
        insumo = service.insert(insumo);
        URI uri = ServletUriComponentsBuilder.fromCurrentRequest().path("/{id}").buildAndExpand(insumo.getId()).toUri();
        return ResponseEntity.created(uri).body(insumo);
    }

    @DeleteMapping(value = "/{id}")
    public ResponseEntity<Insumo> delete(@PathVariable Long id){
        service.delete(id);
        return ResponseEntity.noContent().build();
    }

    @PutMapping(value = "/{id}")
    public ResponseEntity<Insumo> update(@PathVariable Long id, @RequestBody Insumo insumo){
        insumo = service.update(id, insumo);
        return ResponseEntity.ok().body(insumo);
    }

}
