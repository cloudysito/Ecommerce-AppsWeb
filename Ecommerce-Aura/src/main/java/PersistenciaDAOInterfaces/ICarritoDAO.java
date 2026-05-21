/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package PersistenciaDAOInterfaces;

import java.util.List;
import modelo.CarritoItem;

/**
 *
 * @author emiim
 */
public interface ICarritoDAO {
    void guardarCarrito(String usuarioId, List<CarritoItem> items);
    List<CarritoItem> obtenerCarrito(String usuarioId);
    void eliminarCarrito(String usuarioId);
}
