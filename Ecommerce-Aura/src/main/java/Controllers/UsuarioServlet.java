/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import BOs.UsuarioBO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import modelo.Usuario;

/**
 *
 * @author USER
 */
@WebServlet(name = "UsuarioServlet", urlPatterns = {"/UsuarioServlet"})
public class UsuarioServlet extends HttpServlet {

    private UsuarioBO usuarioBO;

    @Override
    public void init() throws ServletException {
        this.usuarioBO = new UsuarioBO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/views/index.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");

        if (accion == null) {
            response.sendRedirect(request.getContextPath() + "/views/index.jsp");
            return;
        }

        switch (accion) {
            case "registrar":
                procesarRegistro(request, response);
                break;
            case "loginAdmin":
                procesarLoginAdmin(request, response);
                break;
            case "editarPerfil":
                procesarEditarPerfil(request, response);
                break;
            case "logout":
                procesarLogout(request, response);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/views/index.jsp");
                break;
        }
    }

    private void procesarRegistro(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
         
        try {
            String nombre = request.getParameter("nombre");
            String correo = request.getParameter("correo");
            String contraseña = request.getParameter("contrasenia");
            String confirmar = request.getParameter("confirmar_contrasenia");
            String telefono = request.getParameter("telefono");
            String direccion = request.getParameter("direccion");

            if (contraseña == null || confirmar == null || !contraseña.equals(confirmar)) {
                request.setAttribute("error", "Las contraseñas no coinciden.");
                request.getRequestDispatcher("/views/registro.jsp").forward(request, response);
                return;
            }

            Usuario nuevo = new Usuario();
            nuevo.setNombreCompleto(nombre);
            nuevo.setCorreo(correo);
            nuevo.setContrasenia(contraseña);
            nuevo.setTelefono(telefono);
            nuevo.setDireccion(direccion);

            usuarioBO.registrarUsuario(nuevo);

            response.sendRedirect(request.getContextPath() + "/views/login.jsp?registro=exito");
        } catch (Exception e) {
            request.setAttribute("error", "Error al registrarse: " + e.getMessage());
            request.getRequestDispatcher("/views/registro.jsp").forward(request, response);
        }
}
    
    private void procesarLoginAdmin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String correo = request.getParameter("correo");
        String password = request.getParameter("password");

        try {
            Usuario usuarioLogueado = usuarioBO.iniciarSesion(correo, password);

            HttpSession session = request.getSession();
            session.setAttribute("usuarioActivo", usuarioLogueado);
            session.setAttribute("rol", usuarioLogueado.getRol());

            if ("Admin".equals(usuarioLogueado.getRol())) {
                response.sendRedirect(request.getContextPath() + "/views/indexAdmin.jsp");
            } else {
                response.sendRedirect(request.getContextPath() + "/views/index.jsp");
            }

        } catch (Exception e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/views/login.jsp").forward(request, response);
        }
    }

    private void procesarLogout(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate(); // Destruye la sesión
        }
        response.sendRedirect(request.getContextPath() + "/views/login.jsp");
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    private void procesarEditarPerfil(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // La sesión está garantizada por ClienteFilter
            HttpSession session = request.getSession(false);
            Usuario usuarioActivo = (Usuario) session.getAttribute("usuarioActivo");
            
            usuarioActivo.setNombreCompleto(request.getParameter("nombre"));
            usuarioActivo.setTelefono(request.getParameter("telefono"));
            usuarioActivo.setDireccion(request.getParameter("direccion"));
            
            usuarioBO.actualizarPerfil(usuarioActivo);
            session.setAttribute("usuarioActivo", usuarioActivo);
            response.sendRedirect(request.getContextPath() + "/views/perfilUsuario.jsp");
        } catch (Exception e) {
            request.setAttribute("error", "No se pudo actualizar el perfil: " + e.getMessage());
            request.getRequestDispatcher("/views/perfilUsuario.jsp").forward(request, response);
        }
    }

}