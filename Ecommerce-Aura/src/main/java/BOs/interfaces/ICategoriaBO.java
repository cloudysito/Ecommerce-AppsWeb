/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package BOs.interfaces;

import modelo.Categoria;
import java.util.List;
import java.util.Optional;
import org.bson.types.ObjectId;

/**
 *
 * @author emiim
 */
public interface ICategoriaBO {
    public void registrarCategoria(Categoria categoria) throws Exception;
    public List<Categoria> listarCategorias() throws Exception;
    public Optional<Categoria> obtenerCategoriaPorId(ObjectId id) throws Exception;
    public void actualizarCategoria(Categoria categoria) throws Exception;
    public void borrarCategoria(ObjectId id) throws Exception;
}
