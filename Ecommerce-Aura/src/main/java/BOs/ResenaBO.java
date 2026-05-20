/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package BOs;

import BOs.interfaces.IResenaBO;
import java.util.List;
import modelo.Resena;
import org.bson.types.ObjectId;
import PersistenciaDAOInterfaces.IResenaDAO;
import PersistenciaDAO.ResenaDAO;

/**
 *
 * @author USER
 */
public class ResenaBO implements IResenaBO {

    private final IResenaDAO resenaDAO;

    public ResenaBO() {

        this.resenaDAO = new ResenaDAO();
    }

    @Override
    public List<Resena> obtenerTodasLasResenas() throws Exception {
        try {
            List<Resena> lista = resenaDAO.obtenerTodasLasResenas();
            if (lista == null | lista.isEmpty()) {
                System.out.println("no hay resenas registradas actualmente");

            }
            return lista;
        } catch (Exception e) {
            throw new Exception("error al intentar obetener las resenas" + e.getMessage());
        }
    }

    @Override
    public void eliminarResena(String idResenaTexto) throws Exception {
        if (idResenaTexto == null || idResenaTexto.trim().isEmpty()) {
            throw new Exception("el id de la resena no puede estar vacio");
        }
        if (!ObjectId.isValid(idResenaTexto)) {
            throw new Exception("el identificador de la resena no tiene un formato valido");
        }
        try {
            ObjectId id = new ObjectId(idResenaTexto);
            resenaDAO.eliminarResena(id);
        } catch (Exception e) {
            throw new Exception("ocurrio un error al intententar eliminar una resena");
        }
    }

    @Override
    public void crearResena(Resena resena) throws Exception {
        if (resena == null) {
            throw new Exception("La reseña no puede ser nula.");
        }
        if (resena.getComentario() == null || resena.getComentario().isBlank()) {
            throw new Exception("El comentario no puede estar vacío.");
        }
        try {
            resenaDAO.crearResena(resena);
        } catch (Exception e) {
            throw new Exception("Error al crear la reseña: " + e.getMessage());
        }
    }

    @Override
    public List<Resena> obtenerResenasPorProducto(ObjectId productoId) throws Exception {
        try {
            return resenaDAO.obtenerResenasPorProducto(productoId);
        } catch (Exception e) {
            throw new Exception("Error al obtener reseñas: " + e.getMessage());
        }
    }

}
