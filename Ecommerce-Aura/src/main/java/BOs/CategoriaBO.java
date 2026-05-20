/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package BOs;

import BOs.interfaces.ICategoriaBO;
import modelo.Categoria;
import PersistenciaDAO.CategoriaDAO;
import PersistenciaDAOInterfaces.ICategoriaDAO;
import java.util.List;
import java.util.Optional;
import org.bson.types.ObjectId;

/**
 *
 * @author emiim
 */
public class CategoriaBO implements ICategoriaBO {
    private final ICategoriaDAO categoriaDAO;
    
    public CategoriaBO() {
        this.categoriaDAO = new CategoriaDAO();
    }

    @Override
    public void registrarCategoria(Categoria categoria) throws Exception {
        if (categoria == null) {
            throw new Exception("La categoría es obligatoria.");
        }
        if (categoria.getNombre() == null || categoria.getNombre().trim().isEmpty()) {
            throw new Exception("El nombre de la categoría es obligatorio.");
        }
        categoria.setNombre(categoria.getNombre().trim());
        if (categoria.getDescripcion() != null) {
            categoria.setDescripcion(categoria.getDescripcion().trim());
        }
        if (categoria.getId() == null) {
            categoria.setId(new ObjectId());
        }
        
        categoriaDAO.insertar(categoria);
    }

    @Override
    public List<Categoria> listarCategorias() throws Exception {
        return categoriaDAO.consultarTodas();
    }

    @Override
    public Categoria obtenerCategoriaPorId(ObjectId id) throws Exception {
        if (id == null) throw new Exception("ID invalido.");
        return categoriaDAO.consultarPorId(id);
    }

    @Override
    public void modificarCategoria(Categoria categoria) throws Exception {
        if (categoria.getNombre() == null || categoria.getNombre().trim().isEmpty()) {
            throw new Exception("El nombre es obligatorio para actualizar.");
        }
        categoriaDAO.actualizar(categoria);
    }

    @Override
    public void borrarCategoria(ObjectId id) throws Exception {
        if (id == null) {
            throw new Exception("El ID de la categoria no es valido.");
        }
        
        categoriaDAO.eliminar(id);
    }
    
    
}
