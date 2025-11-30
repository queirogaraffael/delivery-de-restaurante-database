package com.unifacisa.delivery_de_restaurant.Service;

import com.unifacisa.delivery_de_restaurant.Entity.Endereco;
import com.unifacisa.delivery_de_restaurant.Repositories.EnderecoRepository;
import jakarta.persistence.EntityNotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EnderecoService {

    @Autowired
    private EnderecoRepository enderecoRepository;

    public List<Endereco> findAll(){
        return enderecoRepository.findAll();
    }

    public Endereco findById(Long id){
        return enderecoRepository.findById(id).get();
    }

    public Endereco insert(Endereco endereco){
        return enderecoRepository.save(endereco);
    }

    public void delete(Long id){
        enderecoRepository.deleteById(id);
    }

    public Endereco update(Long id, Endereco endereco){
        Endereco entity = enderecoRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Endereco Nao Encontrado"));
        updateData(entity, endereco);
        return enderecoRepository.save(entity);

    }

    private void updateData(Endereco entity, Endereco endereco){
        entity.setCep(endereco.getCep());
        entity.setCidade(endereco.getCidade());
        entity.setComplemento(endereco.getComplemento());
        entity.setNumero(endereco.getNumero());
        entity.setBairro(endereco.getBairro());
        entity.setRua(endereco.getRua());
    }
}
