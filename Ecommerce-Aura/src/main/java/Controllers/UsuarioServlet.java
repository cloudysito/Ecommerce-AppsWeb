/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import BOS.UsuarioBO;
import java.io.IOException;
import java.io.PrintWriter;
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
        this.usuarioBO.crearAdmin();
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
            case "loginAdmin":
                procesarLoginAdmin(request, response);
                break;
            case "logout":
                procesarLogout(request, response);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/views/index.jsp");
                break;
        }
    }

    private void procesarLoginAdmin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String correo = request.getParameter("correo");
        String password = request.getParameter("password");

        try {
            Usuario adminLogueado = usuarioBO.iniciarSesion(correo, password);

            // Inicio de sesión exitoso
            HttpSession session = request.getSession();
            session.setAttribute("usuarioActivo", adminLogueado);
            session.setAttribute("rol", "Admin");

            response.sendRedirect(request.getContextPath() + "/views/indexAdmin.jsp");

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

}
