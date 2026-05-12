/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controllers;

import BOS.DetallePedidoBO;
import BOS.interfaces.IDetallePedidoBO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import modelo.DetallePedido;

/**
 *
 * @author garfi
 */
@WebServlet(name = "DetallePedidoServlet", urlPatterns = {"/procesarCompra"})
public class DetallePedidoServlet extends HttpServlet {

    private IDetallePedidoBO detalleBO;

    @Override
    public void init() throws ServletException {
        super.init();
        this.detalleBO = new DetallePedidoBO();
    }
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet DetallePedidoServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet DetallePedidoServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/views/carritoCompras.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        List<DetallePedido> carrito = (List<DetallePedido>) session.getAttribute("carrito");

        if (carrito == null || carrito.isEmpty()) {
            request.setAttribute("mensajeError", "Tu carrito está vacío.");
            request.getRequestDispatcher("views/carritoCompras.jsp").forward(request, response);
            return;
        }

        boolean compraExitosa = detalleBO.procesarYGuardarDetalles(carrito);

        if (compraExitosa) {
            session.removeAttribute("carrito");
            response.sendRedirect(request.getContextPath() + "/views/confirmacionCompra.jsp");
        } else {
            request.setAttribute("mensajeError", "Hubo un problema al procesar tu pedido. Inténtalo de nuevo.");
            request.getRequestDispatcher("views/carritoCompras.jsp").forward(request, response);
        }
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
