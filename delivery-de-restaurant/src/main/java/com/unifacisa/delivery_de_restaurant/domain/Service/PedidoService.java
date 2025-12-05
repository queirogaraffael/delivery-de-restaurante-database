package com.unifacisa.delivery_de_restaurant.domain.Service;

import com.unifacisa.delivery_de_restaurant.domain.Repositories.PedidoRepository;
import com.unifacisa.delivery_de_restaurant.shared.dtos.itempedido.ItemPedidoDTO;
import com.unifacisa.delivery_de_restaurant.shared.dtos.pedidos.CriarPedidoRequestDTO;
import com.unifacisa.delivery_de_restaurant.shared.dtos.pedidos.CriarPedidoResponseDTO;
import com.unifacisa.delivery_de_restaurant.shared.dtos.pedidos.ResultadoProcessarPedidoDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.time.Duration;
import java.util.List;

@Service
public class PedidoService {

    @Autowired
    private PedidoRepository pedidoRepository;

    public BigDecimal calcularTotal(Integer idPedido) {
        return pedidoRepository.calcularTotalPedido(idPedido);
    }

    public CriarPedidoResponseDTO criarPedido(CriarPedidoRequestDTO req) {

        List<ItemPedidoDTO> itens = req.getItens().stream()
                .map(i -> new ItemPedidoDTO(
                        i.getIdProduto(),
                        i.getQuantidade()
                ))
                .toList();

        Duration previsao = Duration.ofMinutes(req.getPrevisaoEntregaMinutos());

        ResultadoProcessarPedidoDTO resultado =
                pedidoRepository.processarNovoPedido(
                        req.getIdCliente(),
                        req.getMetodoPagamento(),
                        req.getIdFuncionarioAtendimento(),
                        req.getIdFuncionarioEntrega(),
                        req.getTaxaEntrega(),
                        previsao,
                        itens,
                        req.getObservacao()
                );

        return new CriarPedidoResponseDTO(
                resultado.getTotalCalculado(),
                resultado.getIdPedidoGerado(),
                resultado.getIdPagamentoGerado()
        );
    }
}
