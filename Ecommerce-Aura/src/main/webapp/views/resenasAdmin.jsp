<%-- 
    Document   : resenasAdmin
    Created on : 29/03/2026, 5:46:05 p. m.
    Author     : garfi
--%>

<%@page import="java.util.List"%>
<%@page import="modelo.Resena"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    List<Resena> listaResenas = (List<Resena>) request.getAttribute("listaResenas");
    SimpleDateFormat sdf = new SimpleDateFormat("dd MMM yyyy");
%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Gestión de Reseñas - Ecommerce</title>
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/stylesAdmin.css">
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
                    <a href="perfilUsuario.jsp" class="icon">
                        <img src="${pageContext.request.contextPath}/imgs/perfil.png" alt="Perfil">
                    </a>
                    <a href="#" class="icon">
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
                            <a href="indexAdmin.jsp" class="menu-item">
                                <img src="${pageContext.request.contextPath}/imgs/inicio.png" alt="Inicio" class="menu-icon">
                                <span>Inicio</span>
                            </a>
                        </li>
                        <li>
                            <a href="gestionUsuariosAdmin.jsp" class="menu-item">
                                <img src="${pageContext.request.contextPath}/imgs/perfil.png" alt="Usuarios" class="menu-icon">
                                <span>Gestión de usuarios</span>
                            </a>
                        </li>
                        <li>
                            <a href="../ProductoServlet?accion=listar" class="menu-item">
                                <img src="${pageContext.request.contextPath}/imgs/catalogo.png" alt="Catálogo" class="menu-icon">
                                <span>Gestión de catálogo</span>
                            </a>
                        </li>
                        <li>
                            <a href="../PedidoServlet" class="menu-item">
                                <img src="${pageContext.request.contextPath}/imgs/pedidos.png" alt="Pedidos" class="menu-icon">
                                <span>Gestión de pedidos</span>
                            </a>
                        </li>
                        <li>
                            <a href="../ResenaServlet" class="menu-item active">
                                <img src="${pageContext.request.contextPath}/imgs/ticket.png" alt="Reseñas" class="menu-icon">
                                <span>Gestion de reseñas</span>
                            </a>
                        </li>
                        <li>
                            <a href="crearProducto.jsp" class="menu-item">
                                <img src="${pageContext.request.contextPath}/imgs/perfil.png" alt="Admin" class="menu-icon">
                                <span>Administrador</span>
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
                                        <form action="../ResenaServlet" method="POST" style="display: inline;">
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
            <p>Aplicaciones Web – Unidad 2</p>
        </footer>
    </body>
</html>
