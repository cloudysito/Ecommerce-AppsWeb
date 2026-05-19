<%@ page contentType="text/html; charset=UTF-8" %>
<aside class="menu-lateral">
    <nav>
        <ul>
            <li>
                <a href="${pageContext.request.contextPath}/views/index.jsp" class="menu-item">
                    <img src="${pageContext.request.contextPath}/imgs/inicio.png" alt="Inicio" class="menu-icon">
                    <span>Inicio</span>
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/ProductoServlet" class="menu-item">
                    <img src="${pageContext.request.contextPath}/imgs/catalogo.png" alt="Catalogo" class="menu-icon">
                    <span>Catálogo de productos</span>
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/CarritoServlet" class="menu-item">
                    <img src="${pageContext.request.contextPath}/imgs/carrito.png" alt="Carrito" class="menu-icon">
                    <span>Carrito de compras</span>
                </a>
            </li>
            <li style="${empty sessionScope.usuarioActivo ? 'display:none !important;' : ''}">
                <a href="${pageContext.request.contextPath}/views/gestionPedidos.jsp" class="menu-item">
                    <img src="${pageContext.request.contextPath}/imgs/pedidos.png" alt="Pedidos" class="menu-icon">
                    <span>Mis pedidos</span>
                </a>
            </li>
            <li style="${not empty sessionScope.usuarioActivo ? 'display:none !important;' : ''}">
                <a href="${pageContext.request.contextPath}/PedidoServlet" class="menu-item">
                    <img src="${pageContext.request.contextPath}/imgs/perfil.png" alt="Login" class="menu-icon">
                    <span>Login</span>
                </a>
            </li>
        </ul>
    </nav>
</aside>