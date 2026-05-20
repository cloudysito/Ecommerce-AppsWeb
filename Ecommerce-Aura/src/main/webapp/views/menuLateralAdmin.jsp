<%@ page contentType="text/html; charset=UTF-8" %>
<aside class="menu-lateral">
    <nav>
        <ul>
            <li>
                <a href="${pageContext.request.contextPath}/views/indexAdmin.jsp" class="menu-item">
                    <img src="${pageContext.request.contextPath}/imgs/inicio.png" alt="Inicio" class="menu-icon">
                    <span>Inicio</span>
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/UsuarioServlet?accion=consultarUsuarios" class="menu-item">
                    <img src="${pageContext.request.contextPath}/imgs/perfil.png" alt="Usuarios" class="menu-icon">
                    <span>Gestión de usuarios</span>
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/ProductoServlet?accion=listarAdmin" class="menu-item">
                    <img src="${pageContext.request.contextPath}/imgs/catalogo.png" alt="Catálogo" class="menu-icon">
                    <span>Gestión de catálogo</span>
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/PedidoServlet" class="menu-item">
                    <img src="${pageContext.request.contextPath}/imgs/pedidos.png" alt="Pedidos" class="menu-icon">
                    <span>Gestión de pedidos</span>
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/ResenaServlet" class="menu-item">
                    <img src="${pageContext.request.contextPath}/imgs/pedidos.png" alt="Reseñas" class="menu-icon">
                    <span>Gestión de reseñas</span>
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/views/crearProducto.jsp" class="menu-item">
                    <img src="${pageContext.request.contextPath}/imgs/catalogo.png" alt="Agregar producto" class="menu-icon">
                    <span>Agregar producto</span>
                </a>
            </li>
        </ul>
    </nav>
</aside>