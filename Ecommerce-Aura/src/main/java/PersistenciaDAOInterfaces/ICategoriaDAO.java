/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package PersistenciaDAOInterfaces;

import modelo.Categoria;
import java.util.List;
import java.util.Optional;
import org.bson.types.ObjectId;

/**
 *
 * @author emiim
 */
public interface ICategoriaDAO {
    public void insertar(Categoria categoria) throws Exception;
    public List<Categoria> consultarTodas() throws Exception;
    public Optional<Categoria> consultarPorId(ObjectId id) throws Exception;
    public void actualizar(Categoria categoria) throws Exception;
    public void eliminar(ObjectId id) throws Exception;
}
