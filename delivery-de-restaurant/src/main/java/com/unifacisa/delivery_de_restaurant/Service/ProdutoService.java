package com.unifacisa.delivery_de_restaurant.Service;

import com.unifacisa.delivery_de_restaurant.Entity.Produto;
import com.unifacisa.delivery_de_restaurant.Repositories.ProdutoRepository;
import jakarta.persistence.EntityNotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProdutoService {

    @Autowired
    private ProdutoRepository produtoRepository;

    public List<Produto> findAll(){
        return produtoRepository.findAll();
    }

    public Produto findById(Long id){
        return produtoRepository.findById(id).get();
    }

    public Produto insert(Produto produto){
        return produtoRepository.save(produto);
    }

    public void delete(Long id){
        produtoRepository.deleteById(id);
    }

    public Produto update(Long id, Produto produto){
        Produto entity = produtoRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Produto Nao Encontrado"));
        updateData(entity, produto);
        return produtoRepository.save(entity);
    }

    private void updateData(Produto entity, Produto produto){
        entity.setCategoria(produto.getCategoria());
        entity.setNome(produto.getNome());
        entity.setDescricao(produto.getDescricao());
        entity.setPrecoVenda(produto.getPrecoVenda());
        entity.setEstoqueAtual(produto.getEstoqueAtual());
        entity.setUnidadeMedida(produto.getUnidadeMedida());
        entity.setUnidadeMedida(produto.getUnidadeMedida());
    }
}
