package com.unifacisa.delivery_de_restaurant.domain.Service;

import com.unifacisa.delivery_de_restaurant.domain.Repositories.FuncionarioRepository;
import com.unifacisa.delivery_de_restaurant.domain.entities.Funcionario;
import com.unifacisa.delivery_de_restaurant.exceptions.ResourceNotFoundException;
import com.unifacisa.delivery_de_restaurant.shared.dtos.funcionarios.FuncionarioRequestDTO;
import com.unifacisa.delivery_de_restaurant.shared.dtos.funcionarios.FuncionarioResponseDTO;
import com.unifacisa.delivery_de_restaurant.shared.dtos.funcionarios.FuncionarioUpdateDTO;
import org.springframework.stereotype.Service;

@Service
public class FuncionarioService {

    private final FuncionarioRepository funcionarioRepository;

    public FuncionarioService(FuncionarioRepository funcionarioRepository) {
        this.funcionarioRepository = funcionarioRepository;
    }

    public FuncionarioResponseDTO insert(FuncionarioRequestDTO dto) {
        Funcionario entity = new Funcionario();
        updateEntityFromDTO(entity, dto);
        entity.setAtivo(true);

        entity = funcionarioRepository.save(entity);
        return toResponseDTO(entity);
    }

    public FuncionarioResponseDTO findById(Long id) {
        Funcionario entity = funcionarioRepository.findByIdAndAtivoTrue(id)
                .orElseThrow(() -> new ResourceNotFoundException("Funcionário não encontrado ou inativo"));
        return toResponseDTO(entity);
    }

    public FuncionarioResponseDTO update(Long id, FuncionarioUpdateDTO dto) {
        Funcionario entity = funcionarioRepository.findByIdAndAtivoTrue(id)
                .orElseThrow(() -> new ResourceNotFoundException("Funcionário não encontrado ou inativo"));

        entity.setNome(dto.getNome());
        entity.setCpf(dto.getCpf());
        entity.setSalario(dto.getSalario());
        entity.setCargo(dto.getCargo());
        entity.setTelefone(dto.getTelefone());

        entity = funcionarioRepository.save(entity);
        return toResponseDTO(entity);
    }

    public void delete(Long id) {
        Funcionario entity = funcionarioRepository.findByIdAndAtivoTrue(id)
                .orElseThrow(() -> new ResourceNotFoundException("Funcionário não encontrado para exclusão"));

        entity.setAtivo(false);
        funcionarioRepository.save(entity);
    }

    private void updateEntityFromDTO(Funcionario entity, FuncionarioRequestDTO dto) {
        entity.setNome(dto.getNome());
        entity.setCpf(dto.getCpf());
        entity.setSalario(dto.getSalario());
        entity.setCargo(dto.getCargo());
        entity.setTelefone(dto.getTelefone());
    }

    private FuncionarioResponseDTO toResponseDTO(Funcionario entity) {
        return new FuncionarioResponseDTO(
                entity.getId(),
                entity.getNome(),
                entity.getCpf(),
                entity.getSalario(),
                entity.getCargo(),
                entity.getTelefone()
        );
    }
}
