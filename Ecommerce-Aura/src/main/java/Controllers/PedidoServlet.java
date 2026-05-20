package controllers;

import BOs.PedidoBO;
import BOs.interfaces.IPedidoBO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import modelo.Pedido;
import modelo.DetallePedido;
import modelo.CarritoItem;
import org.bson.types.ObjectId;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@WebServlet(name = "PedidoServlet", urlPatterns = "/PedidoServlet")
public class PedidoServlet extends HttpServlet {

    private IPedidoBO pedidoBO;

    @Override
    public void init() throws ServletException {
        pedidoBO = new PedidoBO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String accion = request.getParameter("accion");

        if ("misPedidos".equals(accion)) {
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("usuarioActivo") == null) {
                response.sendRedirect(request.getContextPath() + "/views/login.jsp");
                return;
            }

            modelo.Usuario usuario = (modelo.Usuario) session.getAttribute("usuarioActivo");
            List<Pedido> todos = pedidoBO.listarPedidos();
            List<Pedido> misPedidos = todos.stream()
                    .filter(p -> p.getNombreCliente().equals(usuario.getNombreCompleto()))
                    .collect(java.util.stream.Collectors.toList());

            request.setAttribute("misPedidos", misPedidos);
            request.getRequestDispatcher("/views/gestionPedidos.jsp").forward(request, response);
            return;
        }

        List<Pedido> listaPedidos = pedidoBO.listarPedidos();
        request.setAttribute("listaPedidos", listaPedidos);
        request.getRequestDispatcher("/views/pagPedidosAdmin.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String accion = request.getParameter("accion");
        HttpSession session = request.getSession();

        if ("procesarPago".equals(accion)) {
            String nombre = request.getParameter("nombreCompleto");
            String telefono = request.getParameter("telefonoEnvio");
            String calle = request.getParameter("direccionEntrega");
            String ciudad = request.getParameter("ciudadEnvio");
            String cp = request.getParameter("codigoPostal");
            String metodoPago = request.getParameter("pago");
            
            String direccionCompleta = calle + ", " + ciudad + ", C.P. " + cp;
            
            session.setAttribute("checkoutNombre", nombre);
            session.setAttribute("checkoutTelefono", telefono);
            session.setAttribute("checkoutDireccion", direccionCompleta);
            session.setAttribute("checkoutMetodoPago", metodoPago);
            
            response.sendRedirect(request.getContextPath() + "/views/confirmacionCompra.jsp");
            return;
        }

        if ("confirmarPedido".equals(accion)) {
            List<CarritoItem> carrito = (List<CarritoItem>) session.getAttribute("carrito");
            if (carrito == null || carrito.isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/views/carritoCompras.jsp");
                return;
            }

            try {
                ObjectId idNuevoPedido = new ObjectId();
                List<DetallePedido> listaDetalles = new ArrayList<>();
                double subtotal = 0.0;

                for (CarritoItem item : carrito) {
                    DetallePedido detalle = new DetallePedido();
                    detalle.setPedidoId(idNuevoPedido);
                    detalle.setNombreProducto(item.getProducto().getNombre());
                    detalle.setCantidad(item.getCantidad());
                    detalle.setPrecioUnitario(item.getProducto().getPrecio());
                    detalle.setSubtotal(item.getCantidad() * item.getProducto().getPrecio());
                    
                    listaDetalles.add(detalle);
                    subtotal += detalle.getSubtotal();
                }

                double envio = 5.0;
                double impuestos = subtotal * 0.038;
                double totalFinal = subtotal + envio + impuestos;

                Pedido nuevoPedido = new Pedido();
                nuevoPedido.setId(idNuevoPedido);
                nuevoPedido.setNombreCliente((String) session.getAttribute("checkoutNombre"));
                nuevoPedido.setDireccionEnvio((String) session.getAttribute("checkoutDireccion"));
                nuevoPedido.setMetodoPago((String) session.getAttribute("checkoutMetodoPago"));
                nuevoPedido.setEstado("Pendiente");
                nuevoPedido.setFecha(new Date());
                nuevoPedido.setTotal(totalFinal);
                nuevoPedido.setProductos(listaDetalles);

                pedidoBO.crearPedido(nuevoPedido);

                session.removeAttribute("carrito");
                session.removeAttribute("checkoutNombre");
                session.removeAttribute("checkoutTelefono");
                session.removeAttribute("checkoutDireccion");
                session.removeAttribute("checkoutMetodoPago");

                request.setAttribute("numeroPedido", idNuevoPedido.toHexString());
                request.getRequestDispatcher("/views/exitoCompra.jsp").forward(request, response);

            } catch (Exception e) {
                request.setAttribute("error", "Error al procesar: " + e.getMessage());
                request.getRequestDispatcher("/views/confirmacionCompra.jsp").forward(request, response);
            }
            return;
        }

        if ("actualizarEstado".equals(accion)) {
            String idStr = request.getParameter("id");
            String nuevoEstado = request.getParameter("nuevoEstado");

            if (idStr != null && nuevoEstado != null) {
                ObjectId id = new ObjectId(idStr);
                pedidoBO.cambiarEstado(id, nuevoEstado);
            }
        }
        response.sendRedirect(request.getContextPath() + "/PedidoServlet");
    }
}