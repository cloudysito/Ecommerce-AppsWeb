package BOs.interfaces;

import modelo.Producto;
import org.bson.types.ObjectId;
import java.util.List;

public interface IProductoBO {
    List<Producto> listarProductos();
    Producto buscarProductoPorId(ObjectId id);
    void registrarProducto(Producto producto);
    void actualizarProducto(Producto producto);
    void eliminarProducto(ObjectId id);
    List<Producto> filtrarProductos(String nombre, String categoria, Double min, Double max);
    List<Producto> listarProductosFiltrados(String nombre, String categoria, String tipoPrecio, Double precio);
}
