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

/**
 *
 * @author garfi
 */
@WebFilter(filterName = "ClienteFilter", urlPatterns = {
    "/views/procesoCompra.jsp",
    "/views/confirmacionCompra.jsp",
    "/views/perfilUsuario.jsp",
    "/UsuarioServlet",
    "/PedidoServlet"
})

public class ClienteFilter implements Filter {

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

        String uri = httpRequest.getRequestURI();
        String accion = httpRequest.getParameter("accion");

        if (uri.endsWith("login.jsp") || uri.endsWith("registro.jsp") || uri.contains("UsuarioServlet")) {
            chain.doFilter(request, response);
            return;
        }

        if (uri.contains("PedidoServlet") && ("procesarPago".equals(accion) || "confirmarPedido".equals(accion))) {
            if (isLoggedIn) {
                chain.doFilter(request, response);
                return;
            }
        }

        if (isLoggedIn) {
            chain.doFilter(request, response);
        } else {
            System.out.println("DEBUG: Acceso denegado a " + uri + ". Sesion: " + isLoggedIn);
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/views/login.jsp");
        }
    }

    @Override
    public void destroy() {
    }

}
