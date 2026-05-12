package filters;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;


@WebFilter(filterName = "AdminFilter", urlPatterns = {
    "/views/indexAdmin.jsp",
    "/views/resenasAdmin.jsp",
    "/views/gestionCatalogo.jsp",
    "/views/gestionPedidos.jsp",
    "/views/gestionUsuariosAdmin.jsp",
    "/views/pagPedidosAdmin.jsp",
    "/ResenaServlet",
    "/ProductoServlet" // Añádelo cuando lo creemos
})
public class AdminFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);

        boolean isLoggedIn = (session != null && session.getAttribute("usuarioActivo") != null);
        boolean isAdmin = isLoggedIn && "Admin".equals(session.getAttribute("rol"));

        if (isAdmin) {
            chain.doFilter(request, response);
        } else {
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/views/login.jsp");
        }
    }

    @Override
    public void destroy() {
        // Se ejecuta cuando el filtro se destruye. Lo dejamos vacío.
    }
}