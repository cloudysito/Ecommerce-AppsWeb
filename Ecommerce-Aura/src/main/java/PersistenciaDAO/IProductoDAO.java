package PersistenciaDAO;

import modelo.Producto;
import org.bson.types.ObjectId;

import java.util.List;

public interface IProductoDAO {
    List<Producto> obtenerProductos();
    Producto obtenerProductoPorId(ObjectId id);
    void insertar(Producto producto);
    void actualizar(Producto producto);
    void eliminar(ObjectId id);
}
