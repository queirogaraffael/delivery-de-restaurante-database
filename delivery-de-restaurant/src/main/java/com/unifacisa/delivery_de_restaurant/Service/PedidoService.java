package com.unifacisa.delivery_de_restaurant.Service;

import com.unifacisa.delivery_de_restaurant.Entity.Pedido;
import com.unifacisa.delivery_de_restaurant.Repositories.PedidoRepository;
import jakarta.persistence.EntityNotFoundException;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.List;

@Service
public class PedidoService {

    @Autowired
    private PedidoRepository pedidoRepository;

    public List<Pedido> findAll(){
        return pedidoRepository.findAll();
    }

    public Pedido findById(Long id){
        return pedidoRepository.findById(id).get();
    }

    public Pedido insert(Pedido pedido) {

        if (pedido.getItens() != null) {
            pedido.getItens().forEach(item -> item.setPedido(pedido));
        }

        return pedidoRepository.save(pedido);
    }

    public void delete(Long id){
        pedidoRepository.deleteById(id);
    }

    public Pedido update(Long id, Pedido pedido){
        Pedido entity = pedidoRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Pedido Nao Encontrado"));
        updateData(entity, pedido);
        return pedidoRepository.save(entity);
    }

    private void updateData(Pedido entity, Pedido pedido){
        entity.setDataPedido(pedido.getDataPedido());
        entity.setObservacao(pedido.getObservacao());
        entity.setFuncionario(pedido.getFuncionario());
        entity.setTaxaEntrega(entity.getTaxaEntrega());
        entity.setStatusPedido(pedido.getStatusPedido());
        entity.setPagamento(pedido.getPagamento());
    }

    public BigDecimal obterTotalDoBanco(Long idPedido) {
        return pedidoRepository.calcularTotalViaBanco(idPedido);
    }

    //Para procedure que alteram dados, isso é obrigatorio
    @Transactional
    public void fecharPedidoNoBanco(Long idPedido) {
        pedidoRepository.fecharPedidoViaProcedure(idPedido);
    }
}
