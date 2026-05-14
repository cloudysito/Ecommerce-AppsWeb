package modelo;

import java.util.List;
import org.bson.types.ObjectId;

public class Producto {

    private ObjectId id;
    private String nombre;
    private double precio;
    private String descripcion;
    private String imagenProducto;
    private int stock;
    private String categoria;
    private List<String> caracteristicas;

    public Producto() {
    }

    public Producto(String nombre, double precio, String descripcion, String imagenProducto, int stock, String categoria, List<String> caracteristicas) {
        this.nombre = nombre;
        this.precio = precio;
        this.descripcion = descripcion;
        this.imagenProducto = imagenProducto;
        this.stock = stock;
        this.categoria = categoria;
        this.caracteristicas = caracteristicas;
    }

    public ObjectId getId() {
        return id;
    }

    public void setId(ObjectId id) {
        this.id = id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public double getPrecio() {
        return precio;
    }

    public void setPrecio(double precio) {
        this.precio = precio;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public String getImagenProducto() {
        return imagenProducto;
    }

    public void setImagenProducto(String imagenProducto) {
        this.imagenProducto = imagenProducto;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    public String getCategoria() {
        return categoria;
    }

    public void setCategoria(String categoria) {
        this.categoria = categoria;
    }

    public List<String> getCaracteristicas() {
        return caracteristicas;
    }

    public void setCaracteristicas(List<String> caracteristicas) {
        this.caracteristicas = caracteristicas;
    }
    
    public boolean isDisponible() {
        return this.stock > 0;
    }
}
