<%-- 
    Document   : editarProducto
    Created on : 29/03/2026, 5:37:14 p. m.
    Author     : garfi
--%>

<%@page import="modelo.Producto"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Producto producto = (Producto) request.getAttribute("producto");
    if (producto == null) {
        response.sendRedirect("../ProductoServlet?accion=listar");
        return;
    }
%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Editar Producto - Ecommerce</title>
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
                            <a href="../ResenaServlet" class="menu-item">
                                <img src="${pageContext.request.contextPath}/imgs/ticket.png" alt="Reseñas" class="menu-icon">
                                <span>Gestion de reseñas</span>
                            </a>
                        </li>
                        <li>
                            <a href="crearProducto.jsp" class="menu-item active">
                                <img src="${pageContext.request.contextPath}/imgs/perfil.png" alt="Admin" class="menu-icon">
                                <span>Administrador</span>
                            </a>
                        </li>
                    </ul>
                </nav>
            </aside>

            <main class="contenido">
                <div class="editar-producto-wrapper">
                    <div class="editar-producto-header">
                        <h1>Editar Producto</h1>
                        <p class="subtitulo">Actualiza los detalles del producto seleccionado.</p>
                    </div>

                    <form class="editar-producto-form" action="../ProductoServlet" method="POST" enctype="multipart/form-data">
                        <input type="hidden" name="accion" value="actualizar">
                        <input type="hidden" name="id" value="<%= producto.getId() %>">
                        <input type="hidden" name="imagenActual" value="<%= producto.getImagenProducto() != null ? producto.getImagenProducto() : "" %>">
                        
                        <div class="imagen-editar-container">
                            <% if (producto.getImagenProducto() != null && !producto.getImagenProducto().isEmpty()) { %>
                                <img src="../<%= producto.getImagenProducto() %>" alt="Producto" style="max-width: 200px; max-height: 200px; object-fit: cover; border-radius: 8px;">
                            <% } else { %>
                                <div class="imagen-editar-placeholder">
                                    <div class="imagen-icono">🖼️</div>
                                    <span>Sin imagen actual</span>
                                </div>
                            <% } %>
                            <div class="campo-editar" style="margin-top: 10px;">
                                <label for="imagenProducto">Actualizar Imagen (Opcional)</label>
                                <input type="file" id="imagenProducto" name="imagenProducto" accept="image/*">
                            </div>
                        </div>

                        <div class="campo-editar">
                            <label for="nombre">Nombre del producto</label>
                            <input type="text" id="nombre" name="nombre" value="<%= producto.getNombre() %>" required>
                        </div>

                        <div class="campo-editar">
                            <label for="descripcion">Descripción</label>
                            <textarea id="descripcion" name="descripcion" rows="3" required><%= producto.getDescripcion() %></textarea>
                        </div>

                        <div class="campos-fila-editar">
                            <div class="campo-editar">
                                <label for="precio">Precio ($)</label>
                                <input type="number" step="0.01" id="precio" name="precio" value="<%= producto.getPrecio() %>" required>
                            </div>
                            <div class="campo-editar">
                                <label for="stock">Stock (Unidades)</label>
                                <input type="number" id="stock" name="stock" value="<%= producto.getStock() %>" required>
                            </div>
                        </div>

                        <div class="campo-editar">
                            <label for="categoria">Categoría</label>
                            <input type="text" id="categoria" name="categoria" value="<%= producto.getCategoria() %>" required>
                        </div>

                        <div class="botones-editar">
                            <a href="../ProductoServlet?accion=listar" class="btn-cancelar-editar">Cancelar</a>
                            <button type="submit" class="btn-actualizar">🔄 Actualizar</button>
                        </div>
                    </form>
                </div>
            </main>
        </div>

        <footer class="pie-pagina">
            <p>Aplicaciones Web – Unidad 2</p>
        </footer>
    </body>
</html>
