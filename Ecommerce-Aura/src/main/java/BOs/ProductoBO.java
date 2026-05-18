package BOs;

import BOs.interfaces.IProductoBO;
import modelo.Producto;
import org.bson.types.ObjectId;
import PersistenciaDAOInterfaces.IProductoDAO;
import PersistenciaDAO.ProductoDAO;

import java.util.List;

public class ProductoBO implements IProductoBO {

    private IProductoDAO productoDAO;

    public ProductoBO() {
        this.productoDAO = new ProductoDAO();
    }

    @Override
    public List<Producto> listarProductos() {
        if (this.productoDAO == null) {
            this.productoDAO = new ProductoDAO(); 
        }
        return productoDAO.obtenerProductos();
    }

    @Override
    public Producto buscarProductoPorId(ObjectId id) {
        return productoDAO.obtenerProductoPorId(id);
    }

    @Override
    public void registrarProducto(Producto producto) {
        if (producto.getPrecio() > 0) {
            productoDAO.insertar(producto);
        }
    }

    @Override
    public void actualizarProducto(Producto producto) {
        productoDAO.actualizar(producto);
    }

    @Override
    public void eliminarProducto(ObjectId id) {
        productoDAO.eliminar(id);
    }

    @Override
    public List<Producto> filtrarProductos(String nombre, String categoria, Double min, Double max) {
        return productoDAO.buscarProductos(nombre, categoria, min, max);
    }

    @Override
    public List<Producto> listarProductosFiltrados(String nombre, String categoria, String tipoPrecio, Double precio) {
        if (this.productoDAO == null) {
            this.productoDAO = new ProductoDAO(); 
        }
        return productoDAO.obtenerProductosFiltrados(nombre, categoria, tipoPrecio, precio);
    }

}
