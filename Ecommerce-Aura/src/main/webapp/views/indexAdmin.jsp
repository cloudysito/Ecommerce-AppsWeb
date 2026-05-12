<%-- 
    Document   : indexAdmin
    Created on : 29/03/2026, 5:42:13 p. m.
    Author     : garfi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Panel de Administrador</title>
        <link rel="stylesheet" type="text/css" href="../assets/styles.css">
    </head>

    <body>
        <header class="barra-superior">
            <div class="header-left">
                <img src="../imgs/logo.png" alt="Logo" class="logo-img">
                <span class="logo-text">Ecommerce</span>
            </div>
            <div class="header-right">
                <a href="perfilUsuario.jsp" class="icon" title="Perfil"><img src="../imgs/perfil.png" alt="Perfil"></a>
                <a href="#cerrar-sesion" class="icon" title="Cerrar sesión"><img src="../imgs/salir.png"
                                                                                 alt="Cerrar sesión"></a>
            </div>
        </header>

        <div class="container">
            <aside class="menu-lateral">
                <nav>
                    <ul>
                        <li>
                            <div class="menu-item">
                                <img src="../imgs/catalogo.png" alt="Gestión de catálogo" class="menu-icon">
                                <a href="../ProductoServlet?accion=listar">Gestión de catálogo</a>
                            </div>
                        </li>
                        <li>
                            <div class="menu-item">
                                <img src="../imgs/pedidos.png" alt="Gestión de pedidos" class="menu-icon">
                                <a href="gestionPedidos.jsp">Gestión de pedidos</a>
                            </div>
                        </li>
                        <li>
                            <div class="menu-item">
                                <img src="../imgs/reseña.png" alt="Gestión de reseñas" class="menu-icon">
                                <a href="../ResenaServlet">Gestión de reseñas</a>
                            </div>
                        </li>
                        <li>
                            <div class="menu-item">
                                <img src="../imgs/admin.png" alt="Administrador" class="menu-icon">
                                <a href="indexAdmin.jsp">Administrador</a>
                            </div>
                        </li>
                    </ul>
                </nav>
            </aside>

            <main class="contenido">
                <h1>Panel de Administrador</h1>
                <p class="subtitulo">Gestión centralizada de la plataforma</p>

                <div class="admin-grid">
                    <div class="admin-card">
                        <img src="../imgs/usuariosCirculo.png" alt="Gestionar Usuarios" class="card-icon">
                        <h3>Gestionar Usuarios (Admin)</h3>
                        <p>Ver, editar o eliminar cuentas de usuario.</p>
                        <a href="gestionUsuariosAdmin.jsp">Ir a Usuarios →</a>
                    </div>

                    <div class="admin-card">
                        <img src="../imgs/catalogoCirculo.png" alt="Catálogo" class="card-icon">
                        <h3>Catálogo (Admin)</h3>
                        <p>Añadir, actualizar o eliminar productos.</p>
                        <a href="../ProductoServlet?accion=listar">Ir a Productos →</a>
                    </div>

                    <div class="admin-card">
                        <img src="../imgs/ticketCirculo.png" alt="Pedidos" class="card-icon">
                        <h3>Pedidos (Admin)</h3>
                        <p>Rastrear y actualizar pedidos de clientes.</p>
                        <a href="gestionPedidos.jsp">Ir a Pedidos →</a>
                    </div>

                    <div class="admin-card">
                        <img src="../imgs/reseñaCirculo.png" alt="Reseñas" class="card-icon">
                        <h3>Reseñas (Admin)</h3>
                        <p>Moderar reseñas de productos y valoraciones.</p>
                        <a href="../ResenaServlet">Ir a Reseñas →</a>
                    </div>
                </div>
            </main>
        </div>
    </body>
    <footer class="pie-pagina">
        <p>Aplicaciones Web – Unidad 2</p>
    </footer>

</html>
