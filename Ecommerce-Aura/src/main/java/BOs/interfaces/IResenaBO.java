/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package BOs.interfaces;

import java.util.List;
import modelo.Resena;
import org.bson.types.ObjectId;

/**
 *
 * @author USER
 */
public interface IResenaBO {
    List<Resena> obtenerTodasLasResenas() throws Exception;
    void eliminarResena(String idResenaTexto) throws Exception ;
    void crearResena(Resena resena) throws Exception;
    List<Resena> obtenerResenasPorProducto(ObjectId productoId) throws Exception;
}
