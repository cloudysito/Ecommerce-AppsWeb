/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package BOs.interfaces;

import java.util.List;
import modelo.CarritoItem;

/**
 *
 * @author emiim
 */
public interface ICarritoBO {
    void persistir(String usuarioId, List<CarritoItem> carrito);
    List<CarritoItem> recuperar(String usuarioId);
    void eliminar(String usuarioId);
}
