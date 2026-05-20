/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import BOs.CarritoBO;
import BOs.UsuarioBO;
import Config.JwtUtil;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import modelo.CarritoItem;
import modelo.Usuario;
import org.bson.types.ObjectId;

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
        String accion = request.getParameter("accion");

        if (accion == null) {
            HttpSession session = request.getSession(false);
            String home = (isAdmin(session)) ? "/views/indexAdmin.jsp" : "/views/index.jsp";
            response.sendRedirect(request.getContextPath() + home);
            return;
        }
        
        if ("consultarUsuarios".equals(accion)) {
            procesarConsultarUsuarios(request, response);
            return;
        }

        if ("logout".equals(accion)){
            procesarLogout(request, response);
            return;
        }

        if ("activar".equals(accion)){
            procesarActivar(request, response);
            return;
        }

        if ("desactivar".equals(accion)){
            procesarDesactivar(request, response);
            return;
        }

        HttpSession session = request.getSession(false);
        String home = (isAdmin(session)) ? "/views/indexAdmin.jsp" : "/views/index.jsp";
        response.sendRedirect(request.getContextPath() + home);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");

        if (accion == null) {
            HttpSession session = request.getSession(false);
            String home = (isAdmin(session)) ? "/views/indexAdmin.jsp" : "/views/index.jsp";
            response.sendRedirect(request.getContextPath() + home);
            return;
        }

        switch (accion) {
            case "registrar":
                procesarRegistro(request, response);
                break;
            case "login":
                procesarLogin(request, response);
                break;
            case "editarPerfil":
                procesarEditarPerfil(request, response);
                break;
            default:
                HttpSession session = request.getSession(false);
                String home = (isAdmin(session)) ? "/views/indexAdmin.jsp" : "/views/index.jsp";
                response.sendRedirect(request.getContextPath() + home);
                break;
        }
    }
    
    private void procesarConsultarUsuarios(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (!isAdmin(session)) {
            response.sendRedirect(request.getContextPath() + "/views/index.jsp");
            return;
        }
        try {
            List<Usuario> listaUsuarios = usuarioBO.consultarTodos();
            request.setAttribute("usuariosRegistrados", listaUsuarios);
            request.getRequestDispatcher("/views/gestionUsuariosAdmin.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/views/indexAdmin.jsp").forward(request, response);
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

            Usuario usuarioRegistrado = usuarioBO.registrarUsuario(nuevo);

            String token = JwtUtil.generarToken(usuarioRegistrado.getId().toString(), "Cliente");

            HttpSession session = request.getSession();
            session.setAttribute("usuarioActivo", usuarioRegistrado);
            session.setAttribute("jwtToken", token);
            session.setAttribute("rol", "Cliente");

            response.sendRedirect(request.getContextPath() + "/views/index.jsp");
        } catch (Exception e) {
            request.setAttribute("error", "Error al registrarse: " + e.getMessage());
            request.getRequestDispatcher("/views/registro.jsp").forward(request, response);
        }
}
    
    private void procesarLogin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String correo = request.getParameter("correo");
        String password = request.getParameter("password");

        try {
            Usuario usuarioLogueado = usuarioBO.iniciarSesion(correo, password);

            String token = JwtUtil.generarToken(usuarioLogueado.getId().toString(), usuarioLogueado.getRol());

            HttpSession session = request.getSession();
            session.setAttribute("usuarioActivo", usuarioLogueado);
            session.setAttribute("jwtToken", token);

            CarritoBO carritoBO = new CarritoBO();
            List<CarritoItem> carritoGuardado = carritoBO.recuperar(usuarioLogueado.getId().toHexString());
            session.setAttribute("carrito", carritoGuardado);
            
            if ("Admin".equalsIgnoreCase(usuarioLogueado.getRol())) {
                session.setAttribute("rol", "Admin");
                response.sendRedirect(request.getContextPath() + "/views/indexAdmin.jsp");
            } else {
                session.setAttribute("rol", "Cliente");
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
            session.invalidate();
        }
        response.sendRedirect(request.getContextPath() + "/views/login.jsp");
    }

    private void procesarActivar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (!isAdmin(session)) {
            response.sendRedirect(request.getContextPath() + "/views/index.jsp");
            return;
        }
        try {
            String userId = request.getParameter("id");
            if (userId == null || userId.isEmpty()) {
                request.setAttribute("error", "ID de usuario no válido.");
                procesarConsultarUsuarios(request, response);
                return;
            }

            ObjectId objectId = parseObjectId(userId);
            boolean exito = usuarioBO.cambiarEstadoUsuario(objectId, true);

            if (exito) {
                request.setAttribute("exito", "Usuario activado correctamente.");
            } else {
                request.setAttribute("error", "No se pudo activar el usuario.");
            }

            procesarConsultarUsuarios(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Error al activar el usuario: " + e.getMessage());
            procesarConsultarUsuarios(request, response);
        }
    }

    private void procesarDesactivar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (!isAdmin(session)) {
            response.sendRedirect(request.getContextPath() + "/views/index.jsp");
            return;
        }
        try {
            String userId = request.getParameter("id");
            if (userId == null || userId.isEmpty()) {
                request.setAttribute("error", "ID de usuario no válido.");
                procesarConsultarUsuarios(request, response);
                return;
            }

            ObjectId objectId = parseObjectId(userId);
            boolean exito = usuarioBO.cambiarEstadoUsuario(objectId, false);

            if (exito) {
                request.setAttribute("exito", "Usuario desactivado correctamente.");
            } else {
                request.setAttribute("error", "No se pudo desactivar el usuario.");
            }

            procesarConsultarUsuarios(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Error al desactivar el usuario: " + e.getMessage());
            procesarConsultarUsuarios(request, response);
        }
    }

    private ObjectId parseObjectId(String raw) {
        if (raw == null) return null;
        raw = raw.trim();
        int start = raw.indexOf('(');
        int end = raw.lastIndexOf(')');
        if (start != -1 && end != -1 && end > start) {
            String inside = raw.substring(start + 1, end).replace("\"", "").replace("'", "").trim();
            raw = inside;
        }
        java.util.regex.Matcher m = java.util.regex.Pattern.compile("([0-9a-fA-F]{24})").matcher(raw);
        if (m.find()) {
            return new ObjectId(m.group(1));
        }
        return new ObjectId(raw);
    }
    
    private boolean isAdmin(HttpSession session) {
        if (session == null) return false;
        Object usuarioObj = session.getAttribute("usuarioActivo");
        if (usuarioObj instanceof Usuario) {
            Usuario u = (Usuario) usuarioObj;
            return "Admin".equalsIgnoreCase(u.getRol());
        }
        Object rolAttr = session.getAttribute("rol");
        if (rolAttr != null) {
            return "Admin".equalsIgnoreCase(rolAttr.toString());
        }
        return false;
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
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("usuarioActivo") == null) {
                response.sendRedirect(request.getContextPath() + "/views/login.jsp");
                return;
            }

            Usuario usuarioActivo = (Usuario) session.getAttribute("usuarioActivo");

            String nombre = request.getParameter("nombre");
            String contrasenia = request.getParameter("contrasenia");
            String telefono = request.getParameter("telefono");
            String direccion = request.getParameter("direccion");
            
            if (nombre != null) {
                nombre = nombre.trim();
            }
            if (contrasenia != null) {
                contrasenia = contrasenia.trim();
            }
            if (telefono != null) {
                telefono = telefono.trim();
            }
            if (direccion != null) {
                direccion = direccion.trim();
            }

            if (nombre == null || nombre.isEmpty()) {
                request.setAttribute("error", "El nombre no puede estar vacío.");
                request.getRequestDispatcher("/views/perfilUsuario.jsp").forward(request, response);
                return;
            }

            usuarioActivo.setNombreCompleto(nombre);
            if (contrasenia != null && !contrasenia.isEmpty()) {
                usuarioActivo.setContrasenia(contrasenia);
            }
            usuarioActivo.setTelefono(telefono);
            usuarioActivo.setDireccion(direccion);
            
            usuarioBO.actualizarPerfil(usuarioActivo);
            session.setAttribute("usuarioActivo", usuarioActivo);
            response.sendRedirect(request.getContextPath() + "/views/perfilUsuario.jsp?success=1");
        } catch (Exception e) {
            request.setAttribute("error", "No se pudo actualizar el perfil: " + e.getMessage());
            request.getRequestDispatcher("/views/perfilUsuario.jsp").forward(request, response);
        }
    }

}