<%@page import="modelo.Resena"%>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
    List<Resena> listaResenas = (List<Resena>) request.getAttribute("listaResenas");
    SimpleDateFormat sdf = new SimpleDateFormat("dd MMM yyyy");
%>
﻿
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
                    <a href="${pageContext.request.contextPath}/UsuarioServlet?accion=logout" class="icon">
                        <img src="${pageContext.request.contextPath}/imgs/salir.png" alt="Salir">
                    </a>
                </div>
            </div>
        </header>

        <div class="container">
            <jsp:include page="menuLateralAdmin.jsp" />

            <main class="contenido">
                <div class="resenas-wrapper">
                    <div class="page-header">
                        <h1>Gestión de Reseñas</h1>
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
                                    <td><%= resena.getNombreUsuario()%></td>
                                    <td>ID: <%= resena.getProductoId().toString().substring(18)%>...</td>
                                    <td>
                                        <span class="estrellas">
                                            <% for (int i = 1; i <= 5; i++) {%>
                                            <span class="estrella <%= (i <= estrellas) ? "llena" : "vacia"%>">★</span>
                                            <% }%>
                                        </span>
                                        <span class="calificacion-num"><%= String.format("%.1f", resena.getCalificacion())%></span>
                                    </td>
                                    <td class="comentario-celda"><%= resena.getComentario()%></td>
                                    <td><%= sdf.format(resena.getFecha())%></td>
                                    <td>
                                        <form action="${pageContext.request.contextPath}/ResenaServlet" method="POST" style="display: inline;">
                                            <input type="hidden" name="accion" value="eliminar">
                                            <input type="hidden" name="idResena" value="<%= resena.getId()%>">
                                            <button type="submit" class="btn-eliminar-resena" onclick="return confirm('¿Eliminar esta reseña?')">Eliminar</button>
                                        </form>
                                    </td>
                                </tr>
                                <% }
                                } else { %>
                                <tr>
                                    <td colspan="6" style="text-align: center; padding: 20px;">No hay reseñas registradas</td>
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
        <script>
            const filasPorPagina = 5;
            let paginaActual = 1;
            const filas = Array.from(document.querySelectorAll('.tabla-resenas tbody tr')).filter( fila => !fila.querySelector('td[colspan]'));
            const total = filas.length;

            function mostrarPagina(pagina) {
                const inicio = (pagina - 1) * filasPorPagina;
                const fin = inicio + filasPorPagina;

                filas.forEach((fila, index) => {
                    fila.style.display = (index >= inicio && index < fin) ? '' : 'none';
                });

                const desde = inicio + 1;
                const mostrando = Math.min(fin, total);
                document.getElementById('pagination-info').textContent =
                        document.getElementById('pagination-info').textContent = total === 1
                        ? '1 reseña en total'
                        : 'Mostrando ' + desde + ' a ' + mostrando + ' de ' + total + ' reseñas';

                document.getElementById('btn-anterior').disabled = pagina === 1;
                document.getElementById('btn-siguiente').disabled = fin >= total;
            }
            
            const totalPaginas = Math.ceil(total / filasPorPagina);
            if (paginaActual > totalPaginas && totalPaginas > 0) {
                paginaActual = totalPaginas;
                mostrarPagina(paginaActual);
            }

            function cambiarPagina(direccion) {
                paginaActual += direccion;
                mostrarPagina(paginaActual);
            }

            if (total === 0) {
                document.getElementById('pagination-info').textContent = '';
                document.getElementById('btn-anterior').disabled = true;
                document.getElementById('btn-siguiente').disabled = true;
            } else {
                mostrarPagina(paginaActual);
}
        </script>
    </body>
</html>

