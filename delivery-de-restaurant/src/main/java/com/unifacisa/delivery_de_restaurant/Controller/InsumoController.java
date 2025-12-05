package com.unifacisa.delivery_de_restaurant.Controller;

import com.unifacisa.delivery_de_restaurant.domain.Service.InsumoService;
import com.unifacisa.delivery_de_restaurant.shared.dtos.insumos.InsumoRequestDTO;
import com.unifacisa.delivery_de_restaurant.shared.dtos.insumos.InsumoResponseDTO;
import com.unifacisa.delivery_de_restaurant.shared.dtos.insumos.InsumoUpdateDTO;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import java.net.URI;

@RestController
@RequestMapping(value = "/insumos")
public class InsumoController {

    @Autowired
    private InsumoService service;

    @PostMapping
    public ResponseEntity<InsumoResponseDTO> insert(@Valid @RequestBody InsumoRequestDTO insumo){
        InsumoResponseDTO insumoResponseDTO = service.insert(insumo);
        URI uri = ServletUriComponentsBuilder.fromCurrentRequest().path("/{id}").buildAndExpand(insumoResponseDTO.getId()).toUri();
        return ResponseEntity.created(uri).body(insumoResponseDTO);
    }

    @GetMapping(value = "/{id}")
    public ResponseEntity<InsumoResponseDTO> findById(@PathVariable Long id){
        InsumoResponseDTO insumoResponseDTO = service.findById(id);
        return ResponseEntity.ok().body(insumoResponseDTO);
    }

    @PutMapping(value = "/{id}")
    public ResponseEntity<InsumoResponseDTO> update(@PathVariable Long id, @Valid @RequestBody InsumoUpdateDTO insumo){        InsumoResponseDTO insumoResponseDTO = service.update(id, insumo);
        return ResponseEntity.ok().body(insumoResponseDTO);
    }

    @DeleteMapping(value = "/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id){
        service.delete(id);
        return ResponseEntity.noContent().build();
    }
}
