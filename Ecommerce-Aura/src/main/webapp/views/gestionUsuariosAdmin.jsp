<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Gestión de Usuarios - Ecommerce</title>
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/cssAdmin/common.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/cssAdmin/header-footer.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/cssAdmin/gestionUsuarios.css">
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
                <button id="theme-toggle" class="theme-toggle" title="Cambiar tema">🌙</button>
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
                            <a href="${pageContext.request.contextPath}/UsuarioServlet?accion=consultarUsuarios" class="menu-item active">
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
                <div class="usuarios-wrapper">
                    <div class="usuarios-header">
                        <h1>Gestión de Usuarios</h1>
                        <p class="subtitulo">Ver, editar o eliminar cuentas de usuario.</p>
                    </div>

                    <c:if test="${not empty exito}">
                        <div class="alert alert-success" style="margin: 20px 0; padding: 15px; background-color: #d4edda; color: #155724; border-radius: 4px;">
                            ✅ ${exito}
                        </div>
                    </c:if>

                    <c:if test="${not empty error}">
                        <div class="alert alert-danger" style="margin: 20px 0; padding: 15px; background-color: #f8d7da; color: #721c24; border-radius: 4px;">
                            ❌ ${error}
                        </div>
                    </c:if>

                    <div class="tabla-usuarios-container">
                        <table class="tabla-usuarios">
                            <thead>
                                <tr>
                                    <th>Nombre</th>
                                    <th>Email</th>
                                    <th>Telefono</th>
                                    <th>Rol</th>
                                    <th>Estado</th>
                                    <th>Acciones</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="u" items="${usuariosRegistrados}">
                                    <tr>
                                        <td>${u.nombreCompleto}</td>
                                        <td>${u.correo}</td>
                                        <td>${u.telefono}</td>
                                        <td>
                                            <span class="badge ${u.rol == 'Admin' ? 'badge-admin' : 'badge-cliente'}">
                                                ${u.rol}
                                            </span>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${u.activo}">
                                                    <span class="badge" style="background-color: #28a745; color: white; padding: 5px 10px; border-radius: 4px;">✅ Activo</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge" style="background-color: #dc3545; color: white; padding: 5px 10px; border-radius: 4px;">❌ Inactivo</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <div class="acciones-tabla">
                                                <c:choose>
                                                    <c:when test="${u.activo}">
                                                        <a href="${pageContext.request.contextPath}/UsuarioServlet?accion=desactivar&id=${u.id}" class="btn-desactivar-mini" onclick="return confirm('¿Desactivar este usuario?')" title="Desactivar">🔒</a>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <a href="${pageContext.request.contextPath}/UsuarioServlet?accion=activar&id=${u.id}" class="btn-activar-mini" onclick="return confirm('¿Activar este usuario?')" title="Activar">🔓</a>
                                                    </c:otherwise>
                                                </c:choose>
                                                <a href="${pageContext.request.contextPath}/UsuarioServlet?accion=eliminar&id=${u.id}" class="btn-eliminar-mini" onclick="return confirm('¿Seguro que deseas eliminar a este usuario?')" title="Eliminar">🗑️</a>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </main>
        </div>

        <footer class="pie-pagina">
            <p>Aplicaciones Web</p>
        </footer>
        <script src="${pageContext.request.contextPath}/assets/js/theme.js"></script>
    </body>
</html>