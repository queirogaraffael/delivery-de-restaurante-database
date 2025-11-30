package com.unifacisa.delivery_de_restaurant.Service;

import com.unifacisa.delivery_de_restaurant.Entity.Funcionario;
import com.unifacisa.delivery_de_restaurant.Repositories.FuncionarioRepository;
import jakarta.persistence.EntityNotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class FuncionarioService {

    @Autowired
    private FuncionarioRepository funcionarioRepository;

    public List<Funcionario> findAll(){
        return funcionarioRepository.findAll();
    }

    public Funcionario findById(Long id){
        return funcionarioRepository.findById(id).get();
    }

    public Funcionario insert(Funcionario funcionario){
        return funcionarioRepository.save(funcionario);
    }

    public void delete(Long id){
        funcionarioRepository.deleteById(id);
    }

    public Funcionario update(Long id, Funcionario funcionario){
        Funcionario entity = funcionarioRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Funcionario Nao Encontrado"));
        updateData(entity, funcionario);
        return funcionarioRepository.save(entity);

    }

    private void updateData(Funcionario entity, Funcionario funcionario){
        entity.setNome(funcionario.getNome());
        entity.setCpf(funcionario.getCpf());
        entity.setSalario(funcionario.getSalario());
        entity.setTelefone(funcionario.getTelefone());
    }
}
