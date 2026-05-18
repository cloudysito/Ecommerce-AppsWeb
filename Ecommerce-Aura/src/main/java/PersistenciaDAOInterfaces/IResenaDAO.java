/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package PersistenciaDAOInterfaces;

import java.util.List;
import modelo.Resena;
import org.bson.types.ObjectId;

/**
 *
 * @author garfi
 */
public interface IResenaDAO {
    ObjectId agregarResena(Resena resena);
    boolean eliminarResena(ObjectId id);
    List<Resena>obtenerTodasLasResenas();
}
