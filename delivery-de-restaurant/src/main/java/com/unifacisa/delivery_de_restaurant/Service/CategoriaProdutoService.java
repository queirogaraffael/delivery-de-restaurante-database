package com.unifacisa.delivery_de_restaurant.Service;

import com.unifacisa.delivery_de_restaurant.Entity.CategoriaProduto;
import com.unifacisa.delivery_de_restaurant.Repositories.CategoriaProdutoRepository;
import jakarta.persistence.EntityNotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CategoriaProdutoService {

    @Autowired
    private CategoriaProdutoRepository categoriaProdutoRepository;

    public List<CategoriaProduto> findAll(){
        return categoriaProdutoRepository.findAll();
    }

    public CategoriaProduto findById(Long id){
        return categoriaProdutoRepository.findById(id).get();
    }

    public CategoriaProduto insert(CategoriaProduto categoriaProduto){
        return categoriaProdutoRepository.save(categoriaProduto);
    }

    public void delete(Long id){
        categoriaProdutoRepository.deleteById(id);
    }

    public CategoriaProduto update(Long id, CategoriaProduto categoriaProduto){
        CategoriaProduto entity = categoriaProdutoRepository.findById(id)
                        .orElseThrow(() -> new RuntimeException("CategoriaProduto Nao Encontrado"));
        updateData(entity, categoriaProduto);
        return categoriaProdutoRepository.save(entity);

    }

    private void updateData(CategoriaProduto entity, CategoriaProduto categoriaProduto){
        entity.setNome(categoriaProduto.getNome());
        entity.setDescricao(categoriaProduto.getDescricao());
    }
}
