package BOS.interfaces;

import modelo.Pedido;
import org.bson.types.ObjectId;

import java.util.List;

public interface IPedidoBO {
    List<Pedido> listarPedidos();
    void cambiarEstado(ObjectId id, String nuevoEstado);
    void crearPedido(Pedido pedido);
}
