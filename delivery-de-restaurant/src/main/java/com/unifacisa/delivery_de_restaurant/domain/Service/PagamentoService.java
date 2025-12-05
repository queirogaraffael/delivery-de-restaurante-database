package com.unifacisa.delivery_de_restaurant.domain.Service;

import com.unifacisa.delivery_de_restaurant.domain.entities.Pagamento;
import com.unifacisa.delivery_de_restaurant.domain.Repositories.PagamentoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PagamentoService {

    @Autowired
    private PagamentoRepository pagamentoRepository;

    public List<Pagamento> findAll(){
        return pagamentoRepository.findAll();
    }

    public Pagamento findById(Long id){
        return pagamentoRepository.findById(id).get();
    }

    public Pagamento insert(Pagamento pagamento){
        return pagamentoRepository.save(pagamento);
    }

    public void delete(Long id){
        pagamentoRepository.deleteById(id);
    }

    public Pagamento update(Long id, Pagamento pagamento){
        Pagamento entity = pagamentoRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Pagamento Nao Encontrado"));
        updateData(entity, pagamento);
        return pagamentoRepository.save(entity);
    }

    private void updateData(Pagamento entity, Pagamento pagamento){
        entity.setDataPagamento(pagamento.getDataPagamento());
        entity.setMetodoPagamento(pagamento.getMetodoPagamento());
        entity.setStatusPagamento(pagamento.getStatusPagamento());
    }
}
