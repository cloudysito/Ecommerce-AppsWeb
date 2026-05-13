package controllers;

import BOs.ProductoBO;
import modelo.Producto;
import modelo.CarritoItem;
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

    @Override
    public void init() throws ServletException {
        this.productoBO = new ProductoBO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        List<CarritoItem> carrito = (List<CarritoItem>) session.getAttribute("carrito");
        if (carrito == null) carrito = new ArrayList<>();

        request.setAttribute("carritoItems", carrito);
        request.getRequestDispatcher("views/carritoCompras.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String accion = request.getParameter("accion");
        if (accion == null) {
            response.sendRedirect(request.getContextPath() + "/ProductoServlet");
            return;
        }

        if (accion.equals("agregar")) {
            String id = request.getParameter("id");
            if (id == null || id.isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/ProductoServlet");
                return;
            }
            Producto producto = productoBO.buscarProductoPorId(new ObjectId(id));
            if (producto == null) {
                response.sendRedirect(request.getContextPath() + "/ProductoServlet");
                return;
            }

            HttpSession session = request.getSession();
            List<CarritoItem> carrito = (List<CarritoItem>) session.getAttribute("carrito");
            if (carrito == null) {
                carrito = new ArrayList<>();
            }

            boolean encontrado = false;
            for (CarritoItem it : carrito) {
                if (it.getProducto().getId().toString().equals(id)) {
                    it.setCantidad(it.getCantidad() + 1);
                    encontrado = true;
                    break;
                }
            }
            if (!encontrado) {
                carrito.add(new CarritoItem(producto, 1));
            }

            session.setAttribute("carrito", carrito);

            String referer = request.getHeader("Referer");
            if (referer != null) response.sendRedirect(referer);
            else response.sendRedirect(request.getContextPath() + "/ProductoServlet");
        } else if (accion.equals("remove")) {
            String id = request.getParameter("id");
            HttpSession session = request.getSession();
            List<CarritoItem> carrito = (List<CarritoItem>) session.getAttribute("carrito");
            if (carrito != null && id != null) {
                carrito.removeIf(it -> it.getProducto().getId().toString().equals(id));
                session.setAttribute("carrito", carrito);
            }
            response.sendRedirect(request.getContextPath() + "/CarritoServlet");
        } else {
            response.sendRedirect(request.getContextPath() + "/ProductoServlet");
        }
    }
}

