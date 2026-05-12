/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import BOS.ResenaBO;
import BOS.UsuarioBO;
import BOS.interfaces.IResenaBO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import modelo.Resena;

/**
 *
 * @author USER
 */
@WebServlet(name = "ResenaServlet", urlPatterns = {"/ResenaServlet"})
public class ResenaServlet extends HttpServlet {

    private IResenaBO resenaBO;
    @Override
     public void init() throws ServletException{
        this.resenaBO = new ResenaBO();
    }
    

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            List<Resena> listaResenas = resenaBO.obtenerTodasLasResenas();
            request.setAttribute("listaResenas", listaResenas);
            request.getRequestDispatcher("views/indexAdmin.jsp").forward(request, response);
        
        } catch (Exception e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("views/indexAdmin.jsp").forward(request, response);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accion = request.getParameter("accion");
        if("eliminar".equals(accion)){
            String idResena = request.getParameter("idResena");
            try {
                resenaBO.eliminarResena(idResena);
                response.sendRedirect(request.getContextPath() + "/ResenaServlet");
            } catch (Exception e) {
                request.setAttribute("error", e.getMessage());
                doGet(request, response);
            }
        }else{
            response.sendRedirect(request.getContextPath() + "/ResenaServlet");
        }
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
