package BOS.interfaces;

import modelo.Producto;
import org.bson.types.ObjectId;
import java.util.List;

public interface IProductoBO {
    List<Producto> listarProductos();
    Producto buscarProductoPorId(ObjectId id);
    void registrarProducto(Producto producto);
    void actualizarProducto(Producto producto);
    void eliminarProducto(ObjectId id);
}
