package controllers;

import BOs.CategoriaBO;
import BOs.interfaces.ICategoriaBO;
import modelo.Categoria;
import org.bson.types.ObjectId;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "CategoriaServlet", urlPatterns = {"/CategoriaServlet"})
public class CategoriaServlet extends HttpServlet {

    private ICategoriaBO categoriaBO;

    @Override
    public void init() throws ServletException {
        this.categoriaBO = new CategoriaBO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String accion = request.getParameter("accion");
        if (accion == null) {
            accion = "listarAdmin"; // Acción por defecto
        }

        try {
            if (accion.equals("listarAdmin")) {
                List<Categoria> lista = categoriaBO.listarCategorias();
                
                request.setAttribute("categoriasRegistradas", lista);
                
                request.getRequestDispatcher("/views/gestionCategoriasAdmin.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/views/indexAdmin.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String accion = request.getParameter("accion");
        if (accion == null) {
            response.sendRedirect(request.getContextPath() + "/CategoriaServlet?accion=listarAdmin");
            return;
        }

        try {
            if (accion.equals("crear")) {
                String nombre = request.getParameter("nombre");
                String descripcion = request.getParameter("descripcion");

                Categoria nuevaCategoria = new Categoria();
                nuevaCategoria.setNombre(nombre);
                nuevaCategoria.setDescripcion(descripcion);

                categoriaBO.registrarCategoria(nuevaCategoria);

                response.sendRedirect(request.getContextPath() + "/CategoriaServlet?accion=listarAdmin");

            } else if (accion.equals("eliminar")) {
                String idStr = request.getParameter("id");

                if (idStr != null && idStr.length() == 24) {
                    ObjectId id = new ObjectId(idStr);                   
                    categoriaBO.borrarCategoria(id);
                }

                response.sendRedirect(request.getContextPath() + "/CategoriaServlet?accion=listarAdmin");
            }
        } catch (Exception e) {
            request.setAttribute("error", e.getMessage());
            response.sendRedirect(request.getContextPath() + "/CategoriaServlet?accion=listarAdmin");
        }
    }
}