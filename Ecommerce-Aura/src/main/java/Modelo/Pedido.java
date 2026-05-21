package modelo;

import org.bson.types.ObjectId;
import org.bson.codecs.pojo.annotations.BsonId;
import java.util.Date;
import java.util.List;

public class Pedido {

    @BsonId
    private ObjectId id;
    private ObjectId usuarioId;
    private String nombreCliente;
    private Date fecha;
    private double total;
    private String estado;
    private List<DetallePedido> productos;
    private String metodoPago;   
    private String direccionEnvio;

    public Pedido() {
    }

    public Pedido(String nombreCliente, double total, List<DetallePedido> productos) {
        this.nombreCliente = nombreCliente;
        this.total = total;
        this.productos = productos;
        this.fecha = new Date(); 
        this.estado = "Pendiente"; 
    }

    public String getDireccionEnvio() {
        return direccionEnvio;
    }

    public void setDireccionEnvio(String direccionEnvio) {
        this.direccionEnvio = direccionEnvio;
    }

    public ObjectId getId() {
        return id;
    }

    public void setId(ObjectId id) {
        this.id = id;
    }

    public ObjectId getUsuarioId() {
        return usuarioId;
    }

    public void setUsuarioId(ObjectId usuarioId) {
        this.usuarioId = usuarioId;
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

    public String getMetodoPago() {
        return metodoPago;
    }

    public void setMetodoPago(String metodoPago) {
        this.metodoPago = metodoPago;
    }
    
    
}
