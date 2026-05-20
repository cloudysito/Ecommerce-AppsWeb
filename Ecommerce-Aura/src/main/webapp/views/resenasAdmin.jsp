
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Gestión de Reseñas - Ecommerce</title>
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/cssAdmin/common.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/cssAdmin/header-footer.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/cssAdmin/resenasAdmin.css">
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
                        <li>
                            <a href="${pageContext.request.contextPath}/CategoriaServlet?accion=listarAdmin" class="menu-item">
                                <img src="${pageContext.request.contextPath}/imgs/catalogo.png" alt="Categorías" class="menu-icon">
                                <span>Gestionar Categorías</span>
                            </a>
                        </li>
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
                            <a href="${pageContext.request.contextPath}/views/gestionUsuariosAdmin.jsp" class="menu-item">
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
                            <a href="${pageContext.request.contextPath}/ProductoServlet?accion=listar" class="menu-item">
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
                            <a href="${pageContext.request.contextPath}/ResenaServlet" class="menu-item active">
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
                <div class="resenas-wrapper">
                    <div class="page-header">
                        <h1>Gestión de Reseñas</h1>
                        <div class="search-container">
                            <input type="text" class="search-input" placeholder="Buscar reseñas...">
                        </div>
                    </div>

                    <div class="tabla-resenas-container">
                        <table class="tabla-resenas">
                            <thead>
                                <tr>
                                    <th>Usuario</th>
                                    <th>Producto</th>
                                    <th>Calificación</th>
                                    <th>Comentario</th>
                                    <th>Fecha</th>
                                    <th>Acción</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% if (listaResenas != null && !listaResenas.isEmpty()) { 
                                    for (Resena resena : listaResenas) { 
                                        int estrellas = (int) Math.round(resena.getCalificacion());
                                %>
                                <tr>
                                    <td><%= resena.getNombreUsuario() %></td>
                                    <td>ID: <%= resena.getProductoId().toString().substring(18) %>...</td>
                                    <td>
                                        <span class="estrellas">
                                            <% for (int i = 1; i <= 5; i++) { %>
                                                <span class="estrella <%= (i <= estrellas) ? "llena" : "vacia" %>">★</span>
                                            <% } %>
                                        </span>
                                        <span class="calificacion-num"><%= String.format("%.1f", resena.getCalificacion()) %></span>
                                    </td>
                                    <td class="comentario-celda"><%= resena.getComentario() %></td>
                                    <td><%= sdf.format(resena.getFecha()) %></td>
                                    <td>
                                        <form action="${pageContext.request.contextPath}/ResenaServlet" method="POST" style="display: inline;">
                                            <input type="hidden" name="accion" value="eliminar">
                                            <input type="hidden" name="idResena" value="<%= resena.getId() %>">
                                            <button type="submit" class="btn-eliminar-resena" onclick="return confirm('¿Eliminar esta reseña?')">Eliminar</button>
                                        </form>
                                    </td>
                                </tr>
                                <% } 
                                } else { %>
                                <tr>
                                    <td colspan="6" style="text-align: center; padding: 20px;">No hay reseñas registradas</td>
                                </tr>
                                <% } %>
                            </tbody>
                                    <td>María Silva</td>
                                    <td>Calculadora Científica</td>
                                    <td>
                                        <span class="estrellas">
                                            <span class="estrella llena">★</span>
                                            <span class="estrella llena">★</span>
                                            <span class="estrella llena">★</span>
                                            <span class="estrella llena">★</span>
                                            <span class="estrella llena">★</span>
                                        </span>
                                        <span class="calificacion-num">5.0</span>
                                    </td>
                                    <td class="comentario-celda">Indispensable para ingeniería...</td>
                                    <td>05 Oct 2023</td>
                                    <td><a href="#" class="btn-eliminar-resena">Eliminar</a></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>

                    <div class="pagination-container">
                        <span class="pagination-info">Mostrando 1 a 4 de 24 reseñas</span>
                        <div class="pagination-buttons">
                            <button class="btn-pagination" disabled>Anterior</button>
                            <button class="btn-pagination">Siguiente</button>
                        </div>
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

