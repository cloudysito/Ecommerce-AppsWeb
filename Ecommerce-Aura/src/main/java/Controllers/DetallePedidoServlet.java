/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controllers;

import BOs.DetallePedidoBO;
import BOs.PedidoBO;
import BOs.ProductoBO;
import BOs.interfaces.IDetallePedidoBO;
import BOs.interfaces.IPedidoBO;
import BOs.interfaces.IProductoBO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import modelo.CarritoItem;
import modelo.DetallePedido;
import modelo.Pedido;
import modelo.Producto;
import org.bson.types.ObjectId;

/**
 *
 * @author garfi
 */
@WebServlet(name = "DetallePedidoServlet", urlPatterns = {"/procesarCompra"})
public class DetallePedidoServlet extends HttpServlet {

    private IDetallePedidoBO detalleBO;
    private IPedidoBO pedidoBO;
    private IProductoBO productoBO;

    @Override
    public void init() throws ServletException {
        super.init();
        this.detalleBO = new DetallePedidoBO();
        this.pedidoBO = new PedidoBO();
        this.productoBO = new ProductoBO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/views/procesoCompra.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("usuarioActivo") == null) {
            response.sendRedirect(request.getContextPath() + "/views/login.jsp");
            return;
        }

        modelo.Usuario usuarioActivo = (modelo.Usuario) session.getAttribute("usuarioActivo");
        if (!usuarioActivo.isActivo()) {
            request.setAttribute("mensajeError", "Tu cuenta ha sido desactivada. No puedes procesar compras.");
            request.getRequestDispatcher("/views/carritoCompras.jsp").forward(request, response);
            return;
        }

        List<CarritoItem> carrito = (List<CarritoItem>) session.getAttribute("carrito");

        if (carrito == null || carrito.isEmpty()) {
            request.setAttribute("mensajeError", "Tu carrito está vacío.");
            request.getRequestDispatcher("/views/carritoCompras.jsp").forward(request, response);
            return;
        }

        List<DetallePedido> detalles = new ArrayList<>();
        double total = 0.0;

        for (CarritoItem item : carrito) {
            Producto productoActual = productoBO.buscarProductoPorId(item.getProducto().getId());
            if (productoActual == null) {
                request.setAttribute("mensajeError", "Uno de los productos ya no está disponible.");
                request.getRequestDispatcher("/views/carritoCompras.jsp").forward(request, response);
                return;
            }

            if (item.getCantidad() <= 0) {
                request.setAttribute("mensajeError", "La cantidad del carrito no es válida.");
                request.getRequestDispatcher("/views/carritoCompras.jsp").forward(request, response);
                return;
            }

            if (item.getCantidad() > productoActual.getStock()) {
                request.setAttribute("mensajeError", "No hay stock suficiente para " + productoActual.getNombre() + ".");
                request.getRequestDispatcher("/views/carritoCompras.jsp").forward(request, response);
                return;
            }

            DetallePedido detalle = new DetallePedido(productoActual.getNombre(), item.getCantidad(), productoActual.getPrecio());
            detalles.add(detalle);
            total += detalle.getSubtotal();
        }

        Pedido pedido = new Pedido(((modelo.Usuario) session.getAttribute("usuarioActivo")).getNombreCompleto(), total, detalles);
        ObjectId pedidoId = new ObjectId();
        pedido.setId(pedidoId);
        for (DetallePedido detalle : detalles) {
            detalle.setPedidoId(pedidoId);
        }

        pedidoBO.crearPedido(pedido);
        boolean detallesGuardados = detalleBO.procesarYGuardarDetalles(detalles);

        if (!detallesGuardados) {
            request.setAttribute("mensajeError", "No se pudieron guardar los detalles de la compra.");
            request.getRequestDispatcher("/views/carritoCompras.jsp").forward(request, response);
            return;
        }

        for (CarritoItem item : carrito) {
            Producto productoActual = productoBO.buscarProductoPorId(item.getProducto().getId());
            if (productoActual != null) {
                productoBO.actualizarStock(productoActual.getId(), productoActual.getStock() - item.getCantidad());
            }
        }

        session.removeAttribute("carrito");
        session.setAttribute("ultimaCompraPedidoId", pedidoId.toString());
        session.setAttribute("ultimaCompraTotal", total);
        session.setAttribute("ultimaCompraFecha", pedido.getFecha());
        session.setAttribute("ultimaCompraDireccion", ((modelo.Usuario) session.getAttribute("usuarioActivo")).getDireccion());
        response.sendRedirect(request.getContextPath() + "/views/confirmacionCompra.jsp");
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Controlador encargado de procesar la compra y guardar los detalles del pedido";
    }// </editor-fold>
}
