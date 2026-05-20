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
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.Optional;

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
        if (accion == null || accion.isBlank()) {
            accion = "listarAdmin";
        }

        if ("listarAdmin".equals(accion)) {
            procesarListarAdmin(request, response);
            return;
        }

        if ("cargarEditar".equals(accion)) {
            procesarCargarEditar(request, response);
            return;
        }

        response.sendRedirect(request.getContextPath() + "/CategoriaServlet?accion=listarAdmin");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String accion = request.getParameter("accion");
        if (accion == null) {
            response.sendRedirect(request.getContextPath() + "/CategoriaServlet?accion=listarAdmin");
            return;
        }

        switch (accion) {
            case "crear":
                procesarCrear(request, response);
                break;
            case "actualizar":
                procesarActualizar(request, response);
                break;
            case "eliminar":
                procesarEliminar(request, response);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/CategoriaServlet?accion=listarAdmin");
                break;
        }
    }

    private void procesarListarAdmin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (!isAdmin(request.getSession(false))) {
            response.sendRedirect(request.getContextPath() + "/views/index.jsp");
            return;
        }

        try {
            List<Categoria> lista = categoriaBO.listarCategorias();
            request.setAttribute("categoriasRegistradas", lista);
            request.getRequestDispatcher("/views/gestionCategoriasAdmin.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/views/indexAdmin.jsp").forward(request, response);
        }
    }

    private void procesarCargarEditar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (!isAdmin(request.getSession(false))) {
            response.sendRedirect(request.getContextPath() + "/views/index.jsp");
            return;
        }

        try {
            String idStr = request.getParameter("id");
            ObjectId id = parseObjectId(idStr);
            if (id == null) {
                throw new Exception("ID de categoría no válido.");
            }

            Optional<Categoria> categoria = categoriaBO.obtenerCategoriaPorId(id);
            if (categoria.isEmpty()) {
                throw new Exception("La categoría no fue encontrada.");
            }

            request.setAttribute("categoriaEditar", categoria.get());
            request.setAttribute("categoriasRegistradas", categoriaBO.listarCategorias());
            request.getRequestDispatcher("/views/gestionCategoriasAdmin.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/views/indexAdmin.jsp").forward(request, response);
        }
    }

    private void procesarCrear(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (!isAdmin(request.getSession(false))) {
            response.sendRedirect(request.getContextPath() + "/views/index.jsp");
            return;
        }

        try {
            String nombre = request.getParameter("nombre");
            String descripcion = request.getParameter("descripcion");

            Categoria nuevaCategoria = new Categoria();
            nuevaCategoria.setNombre(nombre);
            nuevaCategoria.setDescripcion(descripcion);

            categoriaBO.registrarCategoria(nuevaCategoria);
            response.sendRedirect(request.getContextPath() + "/CategoriaServlet?accion=listarAdmin");
        } catch (Exception e) {
            request.setAttribute("error", e.getMessage());
            procesarListarAdmin(request, response);
        }
    }

    private void procesarActualizar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (!isAdmin(request.getSession(false))) {
            response.sendRedirect(request.getContextPath() + "/views/index.jsp");
            return;
        }

        try {
            String idStr = request.getParameter("id");
            ObjectId id = parseObjectId(idStr);
            if (id == null) {
                throw new Exception("ID de categoría no válido.");
            }

            Categoria categoria = new Categoria();
            categoria.setId(id);
            categoria.setNombre(request.getParameter("nombre"));
            categoria.setDescripcion(request.getParameter("descripcion"));

            categoriaBO.actualizarCategoria(categoria);
            response.sendRedirect(request.getContextPath() + "/CategoriaServlet?accion=listarAdmin");
        } catch (Exception e) {
            request.setAttribute("error", e.getMessage());
            procesarListarAdmin(request, response);
        }
    }

    private void procesarEliminar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (!isAdmin(request.getSession(false))) {
            response.sendRedirect(request.getContextPath() + "/views/index.jsp");
            return;
        }

        try {
            String idStr = request.getParameter("id");
            ObjectId id = parseObjectId(idStr);
            if (id == null) {
                throw new Exception("ID de categoría no válido.");
            }

            categoriaBO.borrarCategoria(id);
            response.sendRedirect(request.getContextPath() + "/CategoriaServlet?accion=listarAdmin");
        } catch (Exception e) {
            request.setAttribute("error", e.getMessage());
            procesarListarAdmin(request, response);
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
        try {
            return new ObjectId(raw);
        } catch (Exception e) {
            return null;
        }
    }

    private boolean isAdmin(HttpSession session) {
        if (session == null) return false;
        Object rol = session.getAttribute("rol");
        return rol != null && "Admin".equalsIgnoreCase(rol.toString());
    }
}