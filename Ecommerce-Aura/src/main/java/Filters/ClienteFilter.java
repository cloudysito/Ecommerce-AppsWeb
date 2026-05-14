/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
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
    "/UsuarioServlet"
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

        // Si es el servlet, solo bloquear la acción editarPerfil
        if (uri.contains("UsuarioServlet")) {
            if ("editarPerfil".equals(accion) && !isLoggedIn) {
                httpResponse.sendRedirect(httpRequest.getContextPath() + "/views/login.jsp");
            } else {
                chain.doFilter(request, response);
            }
            return;
        }

        // Para las JSPs protegidas, exigir sesión activa
        if (isLoggedIn) {
            chain.doFilter(request, response);
        } else {
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/views/login.jsp");
        }
    }

    @Override
    public void destroy() {
    }

}