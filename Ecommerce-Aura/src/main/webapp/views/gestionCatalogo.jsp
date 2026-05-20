<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Gestión de Catálogo - Ecommerce</title>
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/cssAdmin/common.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/cssAdmin/header-footer.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/cssAdmin/gestionCatalogo.css">
    </head>
    <body>
        <header class="barra-superior">
            <div class="header-left">
                <a href="#" class="logo-link">
                    <img src="${pageContext.request.contextPath}/imgs/logo.png" alt="Logo" class="logo-img">
                    <span class="logo-text">Ecommerce</span>
                </a>
            </div>
            <div class="header-right">
                <div class="icons">
                    <a href="${pageContext.request.contextPath}/views/perfilUsuario.jsp" class="icon">
                        <img src="${pageContext.request.contextPath}/imgs/perfil.png" alt="Perfil">
                    </a>
                    <a href="${pageContext.request.contextPath}/UsuarioServlet?accion=logout" class="icon">
                        <img src="${pageContext.request.contextPath}/imgs/salir.png" alt="Salir">
                    </a>
                </div>
            </div>
        </header>

        <div class="container">
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
                            <a href="${pageContext.request.contextPath}/CategoriaServlet?accion=listarAdmin" class="menu-item">
                                <img src="${pageContext.request.contextPath}/imgs/catalogo.png" alt="Categorías" class="menu-icon">
                                <span>Gestionar Categorías</span>
                            </a>
                        </li>
                        <li>
                            <a href="${pageContext.request.contextPath}/ProductoServlet?accion=listarAdmin" class="menu-item active">
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
                                <img src="${pageContext.request.contextPath}/imgs/ticket.png" alt="Reseñas" class="menu-icon">
                                <span>Gestion de reseñas</span>
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

            <main class="contenido">
                <div class="catalogo-wrapper">
                    <div class="catalogo-header">
                        <h1>Gestión de catálogo (Admin)</h1>
                        <a href="${pageContext.request.contextPath}/views/crearProducto.jsp" class="btn-crear-producto">+ Crear producto</a>
                    </div>

                    <div class="tabla-catalogo-container">
                        <table class="tabla-catalogo">
                            <thead>
                                <tr>
                                    <th>Imagen</th>
                                    <th>Producto</th>
                                    <th>Categoría</th>
                                    <th>Precio</th>
                                    <th>Stock</th>
                                    <th>Características</th>
                                    <th>Acciones</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:choose>
                                    <c:when test="${not empty productos}">
                                        <c:forEach var="p" items="${productos}">
                                            <tr>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${not empty p.imagenProducto}">
                                                            <c:choose>
                                                                <c:when test="${p.imagenProducto.contains('/')}">
                                                                    <img src="${pageContext.request.contextPath}/${p.imagenProducto}" width="50" style="border-radius: 4px; object-fit: cover;">
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <img src="${pageContext.request.contextPath}/imgs/${p.imagenProducto}" width="50" style="border-radius: 4px; object-fit: cover;">
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <div style="background:#eee; width:50px; height:50px; text-align:center; line-height:50px; border-radius:4px;">📦</div>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td><strong>${p.nombre}</strong></td>
                                                <td><span class="badge" style="background: #6a0dad; color: white; padding: 4px 8px; border-radius: 4px; font-size: 0.85em;">${p.categoria}</span></td>
                                                <td>$${p.precio}</td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${p.stock > 0}">
                                                            <span style="background-color: #10b981; color: white; padding: 4px 8px; border-radius: 4px; font-weight: bold; font-size: 0.85em;">${p.stock} pzas</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span style="background-color: #ef4444; color: white; padding: 4px 8px; border-radius: 4px; font-weight: bold; font-size: 0.85em;">Agotado</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <ul style="margin: 0; padding-left: 20px; font-size: 0.9em; text-align: left;">
                                                        <c:forEach var="carac" items="${p.caracteristicas}">
                                                            <li>${carac}</li>
                                                        </c:forEach>
                                                    </ul>
                                                </td>
                                                <td class="acciones-catalogo">
                                                    <a href="${pageContext.request.contextPath}/ProductoServlet?accion=cargarEditar&id=${p.id}" class="btn-editar" title="Editar" style="text-decoration: none; margin-right: 5px;">✏️</a>
                                                    <a href="${pageContext.request.contextPath}/ProductoServlet?accion=eliminar&id=${p.id}" class="btn-eliminar" title="Eliminar" style="text-decoration: none;" onclick="return confirm('¿Estás seguro de eliminar este producto?')">🗑️</a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <tr>
                                            <td colspan="7" style="text-align: center; padding: 20px;">No hay productos registrados</td>
                                        </tr>
                                    </c:otherwise>
                                </c:choose>
                            </tbody>
                        </table>
                    </div>
                </div>
            </main>
        </div>

        <footer class="pie-pagina">
            <p>Aplicaciones Web</p>
        </footer>
        </body>
</html>