<%-- 
    Document   : pagPedidosAdmin
    Created on : 29/03/2026, 5:43:24 p. m.
    Author     : garfi
--%>

<%@page import="java.util.List"%>
<%@page import="modelo.Pedido"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    List<Pedido> listaPedidos = (List<Pedido>) request.getAttribute("listaPedidos");
    SimpleDateFormat sdf = new SimpleDateFormat("dd MMM yyyy");
%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Pedidos Admin - Ecommerce</title>
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
                            <a href="../PedidoServlet" class="menu-item active">
                                <img src="${pageContext.request.contextPath}/imgs/pedidos.png" alt="Pedidos" class="menu-icon">
                                <span>Gestión de pedidos</span>
                            </a>
                        </li>
                        <li>
                            <a href="../ResenaServlet" class="menu-item">
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
                <div class="pedidos-wrapper">
                    <div class="page-header">
                        <h1>Pedidos (Admin)</h1>
                        <div class="search-container">
                            <input type="text" class="search-input" placeholder="Buscar pedidos...">
                        </div>
                    </div>

                    <div class="tabla-pedidos-container">
                        <table class="tabla-pedidos">
                            <thead>
                                <tr>
                                    <th>Número de pedido</th>
                                    <th>Correo del cliente</th>
                                    <th>Estado</th>
                                    <th>Acción</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% if (listaPedidos != null && !listaPedidos.isEmpty()) { 
                                    for (Pedido pedido : listaPedidos) { 
                                        String estadoClass = "";
                                        String estadoTexto = pedido.getEstado();
                                        if ("Pendiente".equalsIgnoreCase(estadoTexto)) {
                                            estadoClass = "estado-pendiente";
                                        } else if ("Enviado".equalsIgnoreCase(estadoTexto)) {
                                            estadoClass = "estado-enviado";
                                        } else if ("Entregado".equalsIgnoreCase(estadoTexto)) {
                                            estadoClass = "estado-entregado";
                                        }
                                %>
                                <tr>
                                    <td><%= pedido.getId().toString().substring(18) %>...</td>
                                    <td><%= pedido.getNombreCliente() %></td>
                                    <td><span class="estado-pedido <%= estadoClass %>"><%= estadoTexto %></span></td>
                                    <td>
                                        <form action="../PedidoServlet" method="POST" style="display: inline;">
                                            <input type="hidden" name="accion" value="actualizarEstado">
                                            <input type="hidden" name="id" value="<%= pedido.getId() %>">
                                            <select name="nuevoEstado" class="select-estado" onchange="this.form.submit()">
                                                <option value="">-- Cambiar estado --</option>
                                                <option value="Pendiente" <%= "Pendiente".equals(estadoTexto) ? "selected" : "" %>>Pendiente</option>
                                                <option value="Enviado" <%= "Enviado".equals(estadoTexto) ? "selected" : "" %>>Enviado</option>
                                                <option value="Entregado" <%= "Entregado".equals(estadoTexto) ? "selected" : "" %>>Entregado</option>
                                                <option value="Cancelado" <%= "Cancelado".equals(estadoTexto) ? "selected" : "" %>>Cancelado</option>
                                            </select>
                                        </form>
                                    </td>
                                </tr>
                                <% } 
                                } else { %>
                                <tr>
                                    <td colspan="4" style="text-align: center; padding: 20px;">No hay pedidos registrados</td>
                                </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>

                    <div class="pagination-container">
                        <span class="pagination-info">Mostrando 1 a 3 de 15 pedidos</span>
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
