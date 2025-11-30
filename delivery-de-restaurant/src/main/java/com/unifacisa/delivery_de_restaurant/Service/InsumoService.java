package com.unifacisa.delivery_de_restaurant.Service;

import com.unifacisa.delivery_de_restaurant.Entity.Insumo;
import com.unifacisa.delivery_de_restaurant.Repositories.InsumoRepository;
import jakarta.persistence.EntityNotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class InsumoService {

    @Autowired
    private InsumoRepository insumoRepository;

    public List<Insumo> findAll(){
        return insumoRepository.findAll();
    }

    public Insumo findById(Long id){
        return insumoRepository.findById(id).get();
    }

    public Insumo insert(Insumo insumo){
        return insumoRepository.save(insumo);
    }

    public void delete(Long id){
        insumoRepository.deleteById(id);
    }

    public Insumo update(Long id, Insumo insumo){
        Insumo entity = insumoRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Insumo Nao Encontrado"));
        updateData(entity, insumo);
        return insumoRepository.save(entity);

    }

    private void updateData(Insumo entity, Insumo insumo){
        entity.setNome(insumo.getNome());
        entity.setDataValidade(insumo.getDataValidade());
        entity.setPerecivel(entity.isPerecivel());
        entity.setEstoqueAtual(entity.getEstoqueAtual());
        entity.setUnidadeMedida(entity.getUnidadeMedida());
    }
}
