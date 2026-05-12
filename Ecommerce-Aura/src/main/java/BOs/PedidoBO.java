package BOS;

import BOS.interfaces.IPedidoBO;
import modelo.Pedido;
import org.bson.types.ObjectId;
import PersistenciaDAO.IPedidoDAO;
import PersistenciaDAOImpl.PedidoDAO;

import java.util.List;

public class PedidoBO implements IPedidoBO {
    private final IPedidoDAO pedidoDAO;

    public PedidoBO() {
        this.pedidoDAO = new PedidoDAO();
    }

    @Override
    public List<Pedido> listarPedidos() {
        return pedidoDAO.listarTodos();
    }

    @Override
    public void cambiarEstado(ObjectId id, String nuevoEstado) {
        if (nuevoEstado.equals("Pendiente") ||  nuevoEstado.equals("Cancelado") || nuevoEstado.equals("Entregado")){
            pedidoDAO.actualizarEstado(id, nuevoEstado);
        }
    }

    @Override
    public void crearPedido(Pedido pedido) {
        pedidoDAO.insertar(pedido);
    }
}
