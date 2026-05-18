package modelo;

import org.bson.types.ObjectId;

public class DetallePedido {

    private ObjectId pedidoId;
    private String nombreProducto;
    private int cantidad;
    private double precioUnitario;
    private double subtotal;

    public DetallePedido() {
    }

    public DetallePedido(String nombreProducto, int cantidad, double precioUnitario) {
        this(null, nombreProducto, cantidad, precioUnitario);
    }

    public DetallePedido(ObjectId pedidoId, String nombreProducto, int cantidad, double precioUnitario) {
        this.pedidoId = pedidoId;
        this.nombreProducto = nombreProducto;
        this.cantidad = cantidad;
        this.precioUnitario = precioUnitario;
        this.subtotal = cantidad * precioUnitario;
    }
    //getters y setters
    public ObjectId getPedidoId() {
        return pedidoId;
    }

    public void setPedidoId(ObjectId pedidoId) {
        this.pedidoId = pedidoId;
    }

    public String getNombreProducto() {
        return nombreProducto;
    }

    public void setNombreProducto(String nombreProducto) {
        this.nombreProducto = nombreProducto;
    }

    public int getCantidad() {
        return cantidad;
    }

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }

    public double getPrecioUnitario() {
        return precioUnitario;
    }

    public void setPrecioUnitario(double precioUnitario) {
        this.precioUnitario = precioUnitario;
    }

    public double getSubtotal() {
        return subtotal;
    }

    public void setSubtotal(double subtotal) {
        this.subtotal = subtotal;
    }
    
}
