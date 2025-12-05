package com.unifacisa.delivery_de_restaurant.domain.Service;

import com.unifacisa.delivery_de_restaurant.domain.Repositories.InsumoRepository;
import com.unifacisa.delivery_de_restaurant.domain.entities.Insumo;
import com.unifacisa.delivery_de_restaurant.exceptions.ResourceNotFoundException;
import com.unifacisa.delivery_de_restaurant.shared.dtos.insumos.InsumoRequestDTO;
import com.unifacisa.delivery_de_restaurant.shared.dtos.insumos.InsumoResponseDTO;
import com.unifacisa.delivery_de_restaurant.shared.dtos.insumos.InsumoUpdateDTO;
import org.springframework.stereotype.Service;

@Service
public class InsumoService {

    private final InsumoRepository insumoRepository;

    public InsumoService(InsumoRepository insumoRepository) {
        this.insumoRepository = insumoRepository;
    }

    public InsumoResponseDTO insert(InsumoRequestDTO dto) {
        Insumo entity = new Insumo();
        entity.setNome(dto.getNome());
        entity.setUnidadeMedida(dto.getUnidadeMedida());
        entity.setEstoqueAtual(dto.getEstoqueAtual());
        entity.setPerecivel(dto.isPerecivel());
        entity.setDataValidade(dto.getDataValidade());
        entity.setAtivo(true);

        entity = insumoRepository.save(entity);
        return toResponseDTO(entity);
    }

    public InsumoResponseDTO findById(Long id) {
        Insumo entity = insumoRepository.findByIdAndAtivoTrue(id)
                .orElseThrow(() -> new ResourceNotFoundException("Insumo não encontrado ou inativo"));
        return toResponseDTO(entity);
    }

    public InsumoResponseDTO update(Long id, InsumoUpdateDTO dto) {
        Insumo entity = insumoRepository.findByIdAndAtivoTrue(id)
                .orElseThrow(() -> new ResourceNotFoundException("Insumo não encontrado ou inativo"));

        entity.setNome(dto.getNome());
        entity.setUnidadeMedida(dto.getUnidadeMedida());
        entity.setEstoqueAtual(dto.getEstoqueAtual());
        entity.setPerecivel(dto.getPerecivel());
        entity.setDataValidade(dto.getDataValidade());

        entity = insumoRepository.save(entity);
        return toResponseDTO(entity);
    }

    public void delete(Long id) {
        Insumo entity = insumoRepository.findByIdAndAtivoTrue(id)
                .orElseThrow(() -> new ResourceNotFoundException("Insumo não encontrado para exclusão"));

        entity.setAtivo(false);
        insumoRepository.save(entity);
    }

    private InsumoResponseDTO toResponseDTO(Insumo entity) {
        return new InsumoResponseDTO(
                entity.getId(),
                entity.getNome(),
                entity.getUnidadeMedida(),
                entity.getEstoqueAtual(),
                entity.isPerecivel(),
                entity.getDataValidade()
        );
    }
}
