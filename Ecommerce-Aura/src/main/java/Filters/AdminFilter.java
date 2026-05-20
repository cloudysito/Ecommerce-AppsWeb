package filters;

import Config.JwtUtil;
import io.jsonwebtoken.Claims;
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
    "/views/gestionUsuariosAdmin.jsp",
    "/views/pagPedidosAdmin.jsp",
    "/ResenaServlet",
    "/UsuarioServlet",
    "/PedidoServlet",
    "/PagoServlet"
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

        String accion = httpRequest.getParameter("accion");
        String uri = httpRequest.getRequestURI();

        if (uri.contains("UsuarioServlet")
                && ("login".equals(accion) || "logout".equals(accion) || "registrar".equals(accion))) {
            chain.doFilter(request, response);
            return;
        }

        if (uri.contains("UsuarioServlet") && "editarPerfil".equals(accion)) {
            HttpSession session2 = httpRequest.getSession(false);
            if (session2 != null && session2.getAttribute("usuarioActivo") != null) {
                chain.doFilter(request, response);
                return;
            } else {
                httpResponse.sendRedirect(httpRequest.getContextPath() + "/views/login.jsp");
                return;
            }
        }

        if (uri.contains("PedidoServlet") && "misPedidos".equals(accion)) {
            chain.doFilter(request, response);
            return;
        }

        HttpSession session = httpRequest.getSession(false);
        boolean isLoggedIn = (session != null && session.getAttribute("usuarioActivo") != null);
        String token = isLoggedIn ? (String) session.getAttribute("jwtToken") : null;

        // Validar JWT
        Claims claims = null;
        if (token != null) {
            claims = JwtUtil.validarToken(token);
        }

        boolean isAdmin = isLoggedIn && "Admin".equals(session.getAttribute("rol")) && claims != null;

        if (isLoggedIn && claims != null) {
            String tokenRol = (String) claims.get("rol");
            if ("Admin".equals(tokenRol)) {
                chain.doFilter(request, response);
            } else {
                httpResponse.sendRedirect(httpRequest.getContextPath() + "/views/login.jsp");
            }
        } else {
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/views/login.jsp");
        }
    }

    @Override
    public void destroy() {
        // Se ejecuta cuando el filtro se destruye. Lo dejamos vacío.
    }
}
