package com.unifacisa.delivery_de_restaurant.Service;

import com.unifacisa.delivery_de_restaurant.Entity.Cliente;
import com.unifacisa.delivery_de_restaurant.Entity.Cliente;
import com.unifacisa.delivery_de_restaurant.Repositories.ClienteRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ClienteService {
    
    @Autowired
    private ClienteRepository clienteRepository;
    
    public List<Cliente> findAll() {
        return clienteRepository.findAll();
    }
    
    public Cliente findById(Long id) {
        return clienteRepository.findById(id).get();
    }
    
    public Cliente insert(Cliente cliente) {
        return clienteRepository.save(cliente);
    }

    public void delete(Long id){
        clienteRepository.deleteById(id);
    }

    public Cliente update(Long id, Cliente cliente){
        Cliente entity = clienteRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Cliente Nao Encontrado"));
        updateData(entity, cliente);
        return clienteRepository.save(entity);

    }

    private void updateData(Cliente entity, Cliente cliente){
        entity.setNome(cliente.getNome());
        entity.setEmail(cliente.getEmail());
        entity.setTelefone(cliente.getTelefone());
        entity.setCpf(cliente.getCpf());
    }
}
