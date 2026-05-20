/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package BOs;

import BOs.interfaces.ICarritoBO;
import PersistenciaDAO.CarritoDAO;
import PersistenciaDAOInterfaces.ICarritoDAO;
import java.util.List;
import modelo.CarritoItem;

/**
 *
 * @author emiim
 */
public class CarritoBO implements ICarritoBO {
    private final ICarritoDAO carritoDAO;
    
    public CarritoBO() {
        this.carritoDAO = new CarritoDAO();
    }
    
    @Override
    public void persistir(String usuarioId, List<CarritoItem> carrito) {
        if (usuarioId != null && carrito != null) {
            carritoDAO.guardarCarrito(usuarioId, carrito);
        }
    }

    @Override
    public List<CarritoItem> recuperar(String usuarioId) {
        if (usuarioId == null) return null;
        return carritoDAO.obtenerCarrito(usuarioId);
    }
    
}
