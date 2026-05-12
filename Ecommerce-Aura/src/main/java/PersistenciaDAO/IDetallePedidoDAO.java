package PersistenciaDAO;

import modelo.DetallePedido;
import org.bson.types.ObjectId;

import java.util.List;

public interface IDetallePedidoDAO {
    void insertarDetalles(List<DetallePedido> detallePedido);
    List<DetallePedido> obtenerPorPedido(ObjectId pedidoId);
}
