package PersistenciaDAOInterfaces;

import modelo.Producto;
import org.bson.types.ObjectId;

import java.util.List;

public interface IProductoDAO {
    List<Producto> obtenerProductos();
    Producto obtenerProductoPorId(ObjectId id);
    List<Producto> buscarProductos(String nombre, String categoria, Double minPrecio, Double maxPrecio);
    void insertar(Producto producto);
    void actualizar(Producto producto);
    void eliminar(ObjectId id);
    List<Producto> obtenerProductosFiltrados(String nombre, String categoria, String tipoPrecio, Double precio);
}
