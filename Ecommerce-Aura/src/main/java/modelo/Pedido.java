package modelo;

import org.bson.types.ObjectId;
import java.util.Date;
import java.util.List;

public class Pedido {

    private ObjectId id;
    private String nombreCliente;
    private Date fecha;
    private double total;
    private String estado;
    private List<DetallePedido> productos;

    public Pedido() {
    }

    public Pedido(String nombreCliente, double total, List<DetallePedido> productos) {
        this.nombreCliente = nombreCliente;
        this.total = total;
        this.productos = productos;
        this.fecha = new Date(); // Fecha actual
        this.estado = "Pendiente"; // Estado inicial por defecto
    }

    public ObjectId getId() {
        return id;
    }

    public void setId(ObjectId id) {
        this.id = id;
    }

    public String getNombreCliente() {
        return nombreCliente;
    }

    public void setNombreCliente(String nombreCliente) {
        this.nombreCliente = nombreCliente;
    }

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public List<DetallePedido> getProductos() {
        return productos;
    }

    public void setProductos(List<DetallePedido> productos) {
        this.productos = productos;
    }
}
