package controllers;

import BOs.PedidoBO;
import BOs.CarritoBO;
import BOs.ProductoBO;
import BOs.interfaces.IPedidoBO;
import BOs.interfaces.ICarritoBO;
import BOs.interfaces.IProductoBO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import modelo.Pedido;
import modelo.DetallePedido;
import modelo.CarritoItem;
import modelo.Producto;
import org.bson.types.ObjectId;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@WebServlet(name = "PedidoServlet", urlPatterns = "/PedidoServlet")
public class PedidoServlet extends HttpServlet {

    private IPedidoBO pedidoBO;
    private ICarritoBO carritoBO;
    private IProductoBO productoBO;

    @Override
    public void init() throws ServletException {
        pedidoBO = new PedidoBO();
        carritoBO = new CarritoBO();
        productoBO = new ProductoBO();
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
            List<Pedido> misPedidos = new ArrayList<>();
            for (Pedido p : todos) {
                if (p.getUsuarioId() != null && usuario.getId() != null && p.getUsuarioId().equals(usuario.getId())) {
                    misPedidos.add(p);
                } else if (p.getNombreCliente() != null && p.getNombreCliente().equals(usuario.getNombreCompleto())) {
                    // fallback to name match for older records
                    misPedidos.add(p);
                }
            }

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
            session.removeAttribute("ultimaCompraPedidoId");
            session.removeAttribute("ultimaCompraTotal");
            session.removeAttribute("ultimaCompraFecha");
            session.removeAttribute("ultimaCompraMetodoPago");
            session.removeAttribute("ultimaCompraDireccion");

            response.sendRedirect(request.getContextPath() + "/views/confirmacionCompra.jsp");
            return;
        }

        if ("confirmarPedido".equals(accion)) {
            List<CarritoItem> carrito = (List<CarritoItem>) session.getAttribute("carrito");
            String usuarioId = null;
            if (session.getAttribute("usuarioActivo") != null) {
                usuarioId = ((modelo.Usuario) session.getAttribute("usuarioActivo")).getId().toHexString();
            }

            if (carrito == null || carrito.isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/views/carritoCompras.jsp");
                return;
            }

            try {
                ObjectId idNuevoPedido = new ObjectId();
                List<DetallePedido> listaDetalles = new ArrayList<>();
                double subtotal = 0.0;

                for (CarritoItem item : carrito) {
                    Producto productoActual = productoBO.buscarProductoPorId(item.getProducto().getId());
                    if (productoActual == null) {
                        request.setAttribute("error", "Uno de los productos ya no está disponible.");
                        request.getRequestDispatcher("/views/confirmacionCompra.jsp").forward(request, response);
                        return;
                    }

                    if (item.getCantidad() <= 0) {
                        request.setAttribute("error", "La cantidad de uno de los productos no es válida.");
                        request.getRequestDispatcher("/views/confirmacionCompra.jsp").forward(request, response);
                        return;
                    }

                    if (item.getCantidad() > productoActual.getStock()) {
                        request.setAttribute("error", "No hay stock suficiente para " + productoActual.getNombre() + ".");
                        request.getRequestDispatcher("/views/confirmacionCompra.jsp").forward(request, response);
                        return;
                    }

                    DetallePedido detalle = new DetallePedido();
                    detalle.setPedidoId(idNuevoPedido);
                    detalle.setNombreProducto(productoActual.getNombre());
                    detalle.setCantidad(item.getCantidad());
                    detalle.setPrecioUnitario(productoActual.getPrecio());
                    detalle.setSubtotal(item.getCantidad() * productoActual.getPrecio());
                    
                    listaDetalles.add(detalle);
                    subtotal += detalle.getSubtotal();
                }

                double envio = 5.0;
                double impuestos = subtotal * 0.038;
                double totalFinal = subtotal + envio + impuestos;

                modelo.Usuario usuarioActivo = (modelo.Usuario) session.getAttribute("usuarioActivo");
                String nombreCliente = (String) session.getAttribute("checkoutNombre");
                if (nombreCliente == null || nombreCliente.trim().isEmpty()) {
                    nombreCliente = (usuarioActivo != null) ? usuarioActivo.getNombreCompleto() : "Cliente";
                }

                String direccionEnvio = (String) session.getAttribute("checkoutDireccion");
                if (direccionEnvio == null || direccionEnvio.trim().isEmpty()) {
                    direccionEnvio = (usuarioActivo != null) ? usuarioActivo.getDireccion() : "No disponible";
                }

                String metodoPagoPedido = (String) session.getAttribute("checkoutMetodoPago");
                if (metodoPagoPedido == null || metodoPagoPedido.trim().isEmpty()) {
                    metodoPagoPedido = "contraEntrega";
                }

                Pedido nuevoPedido = new Pedido();
                nuevoPedido.setId(idNuevoPedido);
                if (usuarioActivo != null && usuarioActivo.getId() != null) {
                    nuevoPedido.setUsuarioId(usuarioActivo.getId());
                }
                nuevoPedido.setNombreCliente(nombreCliente);
                nuevoPedido.setDireccionEnvio(direccionEnvio);
                nuevoPedido.setMetodoPago(metodoPagoPedido);
                nuevoPedido.setEstado("Pendiente");
                nuevoPedido.setFecha(new Date());
                nuevoPedido.setTotal(totalFinal);
                nuevoPedido.setProductos(listaDetalles);

                pedidoBO.crearPedido(nuevoPedido);

                for (CarritoItem item : carrito) {
                    Producto productoActual = productoBO.buscarProductoPorId(item.getProducto().getId());
                    if (productoActual != null) {
                        productoBO.actualizarStock(productoActual.getId(), productoActual.getStock() - item.getCantidad());
                    }
                }

                session.removeAttribute("carrito");
                session.removeAttribute("checkoutNombre");
                session.removeAttribute("checkoutTelefono");
                session.removeAttribute("checkoutDireccion");
                session.removeAttribute("checkoutMetodoPago");

                if (usuarioId != null) {
                    carritoBO.eliminar(usuarioId);
                }

                session.setAttribute("ultimaCompraPedidoId", idNuevoPedido.toHexString());
                session.setAttribute("ultimaCompraTotal", totalFinal);
                session.setAttribute("ultimaCompraFecha", nuevoPedido.getFecha());
                session.setAttribute("ultimaCompraMetodoPago", metodoPagoPedido);
                session.setAttribute("ultimaCompraDireccion", direccionEnvio);

                response.sendRedirect(request.getContextPath() + "/views/confirmacionCompra.jsp?finalizada=1");

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