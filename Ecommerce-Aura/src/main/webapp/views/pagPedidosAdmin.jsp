<%@page import="modelo.Pedido"%>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Pedidos Admin - Ecommerce</title>
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/cssAdmin/common.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/cssAdmin/header-footer.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/cssAdmin/gestionPedidos.css">
    </head>
    <body>
        <%
            List<Pedido> listaPedidos = (List<Pedido>) request.getAttribute("listaPedidos");
        %>
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
                            <a href="${pageContext.request.contextPath}/UsuarioServlet?accion=consultarUsuarios" class="menu-item">
                                <img src="${pageContext.request.contextPath}/imgs/perfil.png" alt="Usuarios" class="menu-icon">
                                <span>Gestión de usuarios</span>
                            </a>
                        </li>
                        <li>
                            <%-- CORREGIDO: Ahora apunta a la lista de administración --%>
                            <a href="${pageContext.request.contextPath}/ProductoServlet?accion=listarAdmin" class="menu-item">
                                <img src="${pageContext.request.contextPath}/imgs/catalogo.png" alt="Catálogo" class="menu-icon">
                                <span>Gestión de catálogo</span>
                            </a>
                        </li>
                        <li>
                            <a href="${pageContext.request.contextPath}/PedidoServlet" class="menu-item active">
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
                                    <th>Método de Pago</th>
                                    <th>Fecha de compra</th>
                                    <th>Monto Pagado</th>
                                    <th>Estado</th>
                                    <th>Acción</th>
                                </tr>
                            </thead>
                            <tbody id="tbody-pedidos">
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
                                <tr class="fila-pedido">
                                    <td><%= pedido.getId().toString().substring(18)%>...</td>
                                    <td><%= pedido.getNombreCliente()%></td>
                                    <td><%= pedido.getMetodoPago() != null ? pedido.getMetodoPago() : "N/A"%></td>
                                    <td><%= pedido.getFecha()%></td>
                                    <td>$<%= String.format("%.2f", pedido.getTotal())%></td>
                                    <td><span class="estado-pedido <%= estadoClass%>"><%= estadoTexto%></span></td>
                                    <td>
                                        <form action="${pageContext.request.contextPath}/PedidoServlet" method="POST" style="display: inline;">
                                            <input type="hidden" name="accion" value="actualizarEstado">
                                            <input type="hidden" name="id" value="<%= pedido.getId()%>">
                                            <select name="nuevoEstado" class="select-estado" onchange="this.form.submit()">
                                                <option value="">-- Cambiar estado --</option>
                                                <option value="Pendiente" <%= "Pendiente".equals(estadoTexto) ? "selected" : ""%>>Pendiente</option>
                                                <option value="Enviado" <%= "Enviado".equals(estadoTexto) ? "selected" : ""%>>Enviado</option>
                                                <option value="Entregado" <%= "Entregado".equals(estadoTexto) ? "selected" : ""%>>Entregado</option>
                                            </select>
                                        </form>
                                    </td>
                                </tr>
                                <% }
                                } else { %>
                                <tr>
                                    <td colspan="5" style="text-align: center; padding: 20px;">No hay pedidos registrados</td>
                                </tr>
                                <% }%>
                            </tbody>
                        </table>
                    </div>

                    <div class="pagination-container">
                        <span class="pagination-info" id="pagination-info"></span>
                        <div class="pagination-buttons">
                            <button class="btn-pagination" id="btn-anterior" onclick="cambiarPagina(-1)" disabled>Anterior</button>
                            <button class="btn-pagination" id="btn-siguiente" onclick="cambiarPagina(1)">Siguiente</button>
                        </div>
                    </div>
                </div>
            </main>
        </div>

        <footer class="pie-pagina">
            <p>Aplicaciones Web</p>
        </footer>
        <script src="${pageContext.request.contextPath}/assets/js/theme.js"></script>
        <script>
                                const filasPorPagina = 5;
                                let paginaActual = 1;
                                const filas = Array.from(document.querySelectorAll('.fila-pedido'));
                                const total = filas.length;

                                function mostrarPagina(pagina) {
                                    const inicio = (pagina - 1) * filasPorPagina;
                                    const fin = inicio + filasPorPagina;

                                    filas.forEach((fila, index) => {
                                        fila.style.display = (index >= inicio && index < fin) ? '' : 'none';
                                    });

                                    const mostrando = Math.min(fin, total);
                                    const desde = inicio + 1;
                                    document.getElementById('pagination-info').textContent =
                                            'Mostrando ' + desde + ' a ' + mostrando + ' de ' + total + ' pedidos';

                                    document.getElementById('btn-anterior').disabled = pagina === 1;
                                    document.getElementById('btn-siguiente').disabled = fin >= total;
                                }

                                function cambiarPagina(direccion) {
                                    paginaActual += direccion;
                                    mostrarPagina(paginaActual);
                                }

                                mostrarPagina(paginaActual);
        </script>
    </body>
</html>