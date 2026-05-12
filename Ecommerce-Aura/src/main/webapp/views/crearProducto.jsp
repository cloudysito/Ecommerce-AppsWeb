<%-- 
    Document   : crearProducto
    Created on : 29/03/2026, 5:26:41 p. m.
    Author     : garfi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Crear Producto - Ecommerce</title>
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
            <div class="producto-wrapper">
                <div class="producto-header">
                    <h1>Crear Nuevo Producto</h1>
                    <p class="subtitulo">Añade los detalles del nuevo producto para el catálogo.</p>
                </div>

                <form class="producto-form" action="../ProductoServlet" method="POST" enctype="multipart/form-data">
                    <div class="form-content">
                        <div class="form-fields">
                            <div class="campo-producto">
                                <label for="nombre">Nombre del producto</label>
                                <input type="text" id="nombre" name="nombre" placeholder="Ej. Camiseta Algodón Premium" required>
                            </div>

                            <div class="campo-producto">
                                <label for="descripcion">Descripción</label>
                                <textarea id="descripcion" name="descripcion" rows="4" placeholder="Describe las características del producto..." required></textarea>
                            </div>

                            <div class="campos-fila">
                                <div class="campo-producto">
                                    <label for="precio">Precio</label>
                                    <input type="number" step="0.01" id="precio" name="precio" placeholder="0.00" required>
                                </div>
                                <div class="campo-producto">
                                    <label for="stock">Cantidad en stock</label>
                                    <input type="number" id="stock" name="stock" value="0" required>
                                </div>
                            </div>

                            <div class="campo-producto">
                                <label for="categoria">Categoría</label>
                                <input type="text" id="categoria" name="categoria" placeholder="Ej. Electrónica, Ropa, Muebles" required>
                            </div>

                            <div class="campo-producto">
                                <label for="imagenProducto">Imagen del producto (opcional)</label>
                                <input type="file" id="imagenProducto" name="imagenProducto" accept="image/*">
                            </div>

                            <div class="botones-producto">
                                <a href="../ProductoServlet?accion=listar" class="btn-cancelar">Cancelar</a>
                                <button type="submit" class="btn-añadir">Añadir producto</button>
                            </div>
                        </div>

                        <div class="imagen-upload">
                            <div class="imagen-placeholder">
                                <div class="imagen-icono">🖼️</div>
                                <span>Agregar Imagen</span>
                                <p style="font-size: 12px; color: #666; margin-top: 5px;">Selecciona un archivo usando el campo de arriba</p>
                            </div>
                        </div>
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
