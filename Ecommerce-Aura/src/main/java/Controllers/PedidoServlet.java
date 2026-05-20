package controllers;

import BOs.PedidoBO;
import BOs.interfaces.IPedidoBO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import modelo.Pedido;
import org.bson.types.ObjectId;
import java.io.IOException;
import java.util.List;

@WebServlet (name = "PedidoServlet", urlPatterns = "/PedidoServlet")
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
        // Verificar sesión
        jakarta.servlet.http.HttpSession session = request.getSession(false);
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
        if ("actualizarEstado".equals(accion)) {
            String idStr = request.getParameter("id");
            String nuevoEstado = request.getParameter("nuevoEstado");

            if (idStr != null && nuevoEstado != null) {
                ObjectId  id = new ObjectId(idStr);
                pedidoBO.cambiarEstado(id, nuevoEstado);
            }
        }
        response.sendRedirect("PedidoServlet");
    }
}
