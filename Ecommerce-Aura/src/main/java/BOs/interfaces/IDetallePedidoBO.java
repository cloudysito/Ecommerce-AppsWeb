/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package BOS.interfaces;

import java.util.List;
import modelo.DetallePedido;
import org.bson.types.ObjectId;

/**
 *
 * @author garfi
 */
public interface IDetallePedidoBO {
    boolean procesarYGuardarDetalles(List<DetallePedido> detalles);
    List<DetallePedido> obtenerDetallesPorPedido(ObjectId pedidoId);
    double calcularTotalPedido(List<DetallePedido> detalles);
}
