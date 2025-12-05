package com.unifacisa.delivery_de_restaurant.Controller;

import com.unifacisa.delivery_de_restaurant.domain.Service.FuncionarioService;
import com.unifacisa.delivery_de_restaurant.shared.dtos.funcionarios.FuncionarioRequestDTO;
import com.unifacisa.delivery_de_restaurant.shared.dtos.funcionarios.FuncionarioResponseDTO;
import com.unifacisa.delivery_de_restaurant.shared.dtos.funcionarios.FuncionarioUpdateDTO;
import jakarta.validation.Valid;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import java.net.URI;

@RestController
@RequestMapping(value = "/funcionarios")
public class FuncionarioController {

    private final FuncionarioService service;

    public FuncionarioController(FuncionarioService service) {
        this.service = service;
    }

    @PostMapping
    public ResponseEntity<FuncionarioResponseDTO> insert(@Valid @RequestBody FuncionarioRequestDTO funcionario){
        FuncionarioResponseDTO funcionarioCriado = service.insert(funcionario);

        URI uri = ServletUriComponentsBuilder.fromCurrentRequest()
                .path("/{id}")
                .buildAndExpand(funcionarioCriado.getId())
                .toUri();

        return ResponseEntity.created(uri).body(funcionarioCriado);
    }

    @GetMapping(value = "/{id}")
    public ResponseEntity<FuncionarioResponseDTO> findById(@PathVariable Long id){
        FuncionarioResponseDTO funcionarioResponseDTO = service.findById(id);
        return ResponseEntity.ok().body(funcionarioResponseDTO);
    }

    @PutMapping(value = "/{id}")
    public ResponseEntity<FuncionarioResponseDTO> update(@PathVariable Long id, @Valid @RequestBody FuncionarioUpdateDTO funcionario){
        FuncionarioResponseDTO funcionarioResponseDTO = service.update(id, funcionario);
        return ResponseEntity.ok().body(funcionarioResponseDTO);
    }

    @DeleteMapping(value = "/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id){
        service.delete(id);
        return ResponseEntity.noContent().build();
    }
}
