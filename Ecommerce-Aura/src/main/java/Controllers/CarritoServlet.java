package controllers;

import BOs.CarritoBO;
import BOs.ProductoBO;
import BOs.interfaces.ICarritoBO;
import modelo.CarritoItem;
import modelo.Producto;
import modelo.Usuario;
import org.bson.types.ObjectId;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "CarritoServlet", urlPatterns = {"/CarritoServlet"})
public class CarritoServlet extends HttpServlet {

    private ProductoBO productoBO;
    private ICarritoBO carritoBO;

    @Override
    public void init() throws ServletException {
        this.productoBO = new ProductoBO();
        this.carritoBO = new CarritoBO();
    }

    private String getUsuarioId(HttpSession session) {
        Usuario user = (Usuario) session.getAttribute("usuarioActivo");
        return (user != null) ? user.getId().toHexString() : null;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        List<CarritoItem> carrito = (List<CarritoItem>) session.getAttribute("carrito");
        
        if (carrito == null) {
            carrito = new ArrayList<>();
            session.setAttribute("carrito", carrito);
        }

        request.setAttribute("carritoItems", carrito);
        request.getRequestDispatcher("views/carritoCompras.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String accion = request.getParameter("accion");
        HttpSession session = request.getSession();
        String usuarioId = getUsuarioId(session);
        List<CarritoItem> carrito = (List<CarritoItem>) session.getAttribute("carrito");

        if (carrito == null) {
            carrito = new ArrayList<>();
        }

        if (accion == null) {
            response.sendRedirect(request.getContextPath() + "/ProductoServlet");
            return;
        }

        if (accion.equals("agregar")) {
            String id = request.getParameter("id");
            String cantidadStr = request.getParameter("cantidad");
            int cantidadSeleccionada = (cantidadStr != null && !cantidadStr.isEmpty()) ? Integer.parseInt(cantidadStr) : 1;

            if (id != null && id.length() == 24) {
                Producto producto = productoBO.buscarProductoPorId(new ObjectId(id));
                if (producto != null) {
                    boolean encontrado = false;
                    for (CarritoItem it : carrito) {
                        if (it.getProducto().getId().toString().equals(id)) {
                            if ((it.getCantidad() + cantidadSeleccionada) <= producto.getStock()) {
                                it.setCantidad(it.getCantidad() + cantidadSeleccionada);
                            }
                            encontrado = true;
                            break;
                        }
                    }
                    if (!encontrado && cantidadSeleccionada <= producto.getStock()) {
                        carrito.add(new CarritoItem(producto, cantidadSeleccionada));
                    }
                }
            }
        } else if (accion.equals("update")) {
            String id = request.getParameter("id");
            String cantidadStr = request.getParameter("cantidad");

            if (id != null && id.length() == 24 && cantidadStr != null) {
                int nuevaCantidad = Integer.parseInt(cantidadStr);
                for (CarritoItem it : carrito) {
                    if (it.getProducto().getId().toString().equals(id)) {
                        it.setCantidad(nuevaCantidad);
                        break;
                    }
                }
            }
        } else if (accion.equals("remove")) {
            String id = request.getParameter("id");
            if (id != null && id.length() == 24) {
                carrito.removeIf(it -> it.getProducto().getId().toString().equals(id));
            }
        }

        session.setAttribute("carrito", carrito);
        if (usuarioId != null) {
            carritoBO.persistir(usuarioId, carrito);
        }

        response.sendRedirect(request.getContextPath() + "/CarritoServlet");
    }
}