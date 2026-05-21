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
        List<Producto> productos = productoDAO.obtenerProductos();

        for (Producto p : productos) {
            if (p.getImagenProducto() == null || p.getImagenProducto().trim().isEmpty()) {
                String nombre = p.getNombre() != null ? p.getNombre().toLowerCase() : "";
                String categoria = p.getCategoria() != null ? p.getCategoria().toLowerCase() : "";
                String imagen = "catalogo.png"; // default

                if (nombre.contains("laptop") || nombre.contains("notebook") || categoria.contains("computo") || categoria.contains("laptops")) {
                    imagen = "laptop.png";
                } else if (nombre.contains("audif") || nombre.contains("auricular") || categoria.contains("audio")) {
                    imagen = "audifonos.png";
                } else if (nombre.contains("silla") || categoria.contains("muebles")) {
                    imagen = "silla.png";
                } else if (nombre.contains("reloj") || nombre.contains("watch") || categoria.contains("accesorios")) {
                    imagen = "reloj.png";
                }

                p.setImagenProducto(imagen);
                try {
                    productoDAO.actualizar(p);
                } catch (Exception ignored) {
                }
            }
        }

        return productos;
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
    public void actualizarStock(ObjectId id, int nuevoStock) {
        if (productoDAO == null) {
            productoDAO = new ProductoDAO();
        }
        productoDAO.actualizarStock(id, nuevoStock);
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
