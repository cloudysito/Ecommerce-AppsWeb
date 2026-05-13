package BOs;

import BOs.interfaces.IDetallePedidoBO;
import java.util.List;
import modelo.DetallePedido;
import org.bson.types.ObjectId;
import PersistenciaDAO.IDetallePedidoDAO;
import PersistenciaDAOImpl.DetallePedidoDAO;

/**
 *
 * @author garfi
 */
public class DetallePedidoBO implements IDetallePedidoBO {

    private final IDetallePedidoDAO detalleDAO;

    public DetallePedidoBO() {
        this.detalleDAO = new DetallePedidoDAO();
    }

    @Override
    public boolean procesarYGuardarDetalles(List<DetallePedido> detalles) {
        if (detalles == null || detalles.isEmpty()) {
            return false;
        }

        for (DetallePedido detalle : detalles) {

            if (detalle.getCantidad() <= 0) {
                return false;
            }

            if (detalle.getPrecioUnitario() < 0) {
                return false;
            }

            double subtotalCalculado = detalle.getCantidad() * detalle.getPrecioUnitario();
            detalle.setSubtotal(subtotalCalculado);
        }

        try {
            detalleDAO.insertarDetalles(detalles);
            return true;
        } catch (Exception e) {
            System.err.println("Error al guardar los detalles del pedido: " + e.getMessage());
            return false;
        }
    }

    @Override
    public List<DetallePedido> obtenerDetallesPorPedido(ObjectId pedidoId) {
        if (pedidoId == null) {
            return null;
        }
        return detalleDAO.obtenerPorPedido(pedidoId);
    }

    @Override
    public double calcularTotalPedido(List<DetallePedido> detalles) {
        if (detalles == null || detalles.isEmpty()) {
            return 0.0;
        }
        return detalles.stream()
                .mapToDouble(DetallePedido::getSubtotal)
                .sum();
    }

}