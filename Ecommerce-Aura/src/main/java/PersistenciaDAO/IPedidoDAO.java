/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package PersistenciaDAO;

import java.util.List;
import modelo.Pedido;
import org.bson.types.ObjectId;

/**
 *
 * @author USER
 */
public interface IPedidoDAO {
    List<Pedido> listarTodos();
    Pedido obtenerPedidoPorId(ObjectId id);
    void insertar(Pedido pedido);
    void actualizarEstado(ObjectId id, String nuevoEstado);
    void eliminar(ObjectId id);
}
