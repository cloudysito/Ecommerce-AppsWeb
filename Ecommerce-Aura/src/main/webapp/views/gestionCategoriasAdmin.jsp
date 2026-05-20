<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Gestión de Categorías - Admin</title>
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/cssAdmin/common.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/cssAdmin/header-footer.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/cssAdmin/gestionCatalogo.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/cssAdmin/gestionCategoriasAdmin.css">
    </head>
    <body>
        <header class="barra-superior">
            <div class="header-left">
                <img src="${pageContext.request.contextPath}/imgs/logo.png" alt="Logo" class="logo-img">
                <span class="logo-text">Ecommerce</span>
            </div>
            <div class="header-right">
                <a href="${pageContext.request.contextPath}/views/perfilUsuario.jsp" class="icon" title="Perfil"><img src="${pageContext.request.contextPath}/imgs/perfil.png" alt="Perfil"></a>
                <a href="${pageContext.request.contextPath}/UsuarioServlet?accion=logout" class="icon" title="Cerrar sesión"><img src="${pageContext.request.contextPath}/imgs/salir.png" alt="Cerrar sesión"></a>
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
                            <a href="${pageContext.request.contextPath}/UsuarioServlet?accion=consultarUsuarios" class="menu-item">
                                <img src="${pageContext.request.contextPath}/imgs/perfil.png" alt="Usuarios" class="menu-icon">
                                <span>Gestión de usuarios</span>
                            </a>
                        </li>
                        <li>
                            <a href="${pageContext.request.contextPath}/CategoriaServlet?accion=listarAdmin" class="menu-item active">
                                <img src="${pageContext.request.contextPath}/imgs/catalogo.png" alt="Categorías" class="menu-icon">
                                <span>Gestionar Categorías</span>
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

            <main class="contenido">
                <div class="catalogo-wrapper">
                    <h1>Gestión de Categorías de Productos</h1>

                    <c:if test="${not empty error}">
                        <div class="alerta-categoria-error">
                            ${error}
                        </div>
                    </c:if>

                    <div class="form-crear">
                        <c:choose>
                            <c:when test="${not empty categoriaEditar}">
                                <h3>Editar Categoría</h3>
                                <form action="${pageContext.request.contextPath}/CategoriaServlet" method="POST">
                                    <input type="hidden" name="accion" value="actualizar" />
                                    <input type="hidden" name="id" value="${categoriaEditar.id}" />

                                    <div class="form-group">
                                        <label for="nombre">Nombre de la Categoría:</label>
                                        <input type="text" id="nombre" name="nombre" required placeholder="Ej. Electrónica, Ropa, etc." value="${categoriaEditar.nombre}" />
                                    </div>

                                    <div class="form-group">
                                        <label for="descripcion">Descripción:</label>
                                        <textarea id="descripcion" name="descripcion" rows="3" placeholder="Breve descripción del tipo de productos...">${categoriaEditar.descripcion}</textarea>
                                    </div>

                                    <button type="submit" class="btn-guardar">Actualizar Categoría</button>
                                    <a href="${pageContext.request.contextPath}/CategoriaServlet?accion=listarAdmin" class="btn-cancelar" style="display:inline-block; margin-left:10px; text-decoration:none;">Cancelar edición</a>
                                </form>
                            </c:when>
                            <c:otherwise>
                                <h3>Agregar Nueva Categoría</h3>
                                <form action="${pageContext.request.contextPath}/CategoriaServlet" method="POST">
                                    <input type="hidden" name="accion" value="crear" />

                                    <div class="form-group">
                                        <label for="nombre">Nombre de la Categoría:</label>
                                        <input type="text" id="nombre" name="nombre" required placeholder="Ej. Electrónica, Ropa, etc." />
                                    </div>

                                    <div class="form-group">
                                        <label for="descripcion">Descripción:</label>
                                        <textarea id="descripcion" name="descripcion" rows="3" placeholder="Breve descripción del tipo de productos..."></textarea>
                                    </div>

                                    <button type="submit" class="btn-guardar">Guardar Categoría</button>
                                </form>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <div class="tabla-container">
                        <table class="tabla-catalogo">
                            <thead>
                                <tr>
                                    <th>ID (MongoDB)</th>
                                    <th>Nombre</th>
                                    <th>Descripción</th>
                                    <th>Acciones</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:choose>
                                    <c:when test="${not empty categoriasRegistradas}">
                                        <c:forEach var="cat" items="${categoriasRegistradas}">
                                            <tr>
                                                <td style="font-family: monospace; font-size: 0.9em;">${cat.id}</td>
                                                <td style="font-weight: bold;">${cat.nombre}</td>
                                                <td>${cat.descripcion}</td>
                                                <td>
                                                    <c:if test="${not empty cat.id}">
                                                        <form action="${pageContext.request.contextPath}/CategoriaServlet" method="GET" style="display:inline-block; margin-right:8px;">
                                                            <input type="hidden" name="accion" value="cargarEditar" />
                                                            <input type="hidden" name="id" value="${cat.id}" />
                                                            <button type="submit" class="btn-guardar" title="Modificar Categoría">Modificar</button>
                                                        </form>
                                                    </c:if>
                                                    <c:if test="${not empty cat.id}">
                                                        <form action="${pageContext.request.contextPath}/CategoriaServlet" method="POST" style="display:inline;" onsubmit="return confirm('¿Seguro que deseas eliminar esta categoría?');">
                                                            <input type="hidden" name="accion" value="eliminar" />
                                                            <input type="hidden" name="id" value="${cat.id}" />
                                                            <button type="submit" class="btn-eliminar" title="Eliminar Categoría">
                                                                <img src="${pageContext.request.contextPath}/imgs/basura.png" alt="Eliminar">
                                                            </button>
                                                        </form>
                                                    </c:if>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <tr>
                                            <td colspan="4" style="text-align: center; padding: 20px;">No hay categorías registradas en la base de datos.</td>
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
        <script src="${pageContext.request.contextPath}/assets/js/theme.js"></script>
    </body>
</html>

