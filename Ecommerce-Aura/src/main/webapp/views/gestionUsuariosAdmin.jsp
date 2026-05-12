<%-- 
    Document   : gestionUsuariosAdmin
    Created on : 29/03/2026, 5:40:32 p. m.
    Author     : garfi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Gestión de Usuarios - Ecommerce</title>
        <link rel="stylesheet" type="text/css" href="../assets/stylesAdmin.css">
    </head>
    <body>
        <header class="barra-superior">
            <div class="header-left">
                <a href="#" class="logo-link">
                    <img src="../imgs/logo.png" alt="Logo" class="logo-img">
                    <span class="logo-text">Ecommerce</span>
                </a>
            </div>
            <div class="header-right">
                <div class="icons">
                    <a href="perfilUsuario.jsp" class="icon">
                        <img src="../imgs/perfil.png" alt="Perfil">
                    </a>
                    <a href="#" class="icon">
                        <img src="../imgs/salir.png" alt="Salir">
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
                                <img src="../imgs/inicio.png" alt="Inicio" class="menu-icon">
                                <span>Inicio</span>
                            </a>
                        </li>
                        <li>
                            <a href="gestionUsuariosAdmin.jsp" class="menu-item active">
                                <img src="../imgs/perfil.png" alt="Usuarios" class="menu-icon">
                                <span>Gestión de usuarios</span>
                            </a>
                        </li>
                        <li>
                            <a href="../ProductoServlet?accion=listar" class="menu-item">
                                <img src="../imgs/catalogo.png" alt="Catálogo" class="menu-icon">
                                <span>Gestión de catálogo</span>
                            </a>
                        </li>
                        <li>
                            <a href="../PedidoServlet" class="menu-item">
                                <img src="../imgs/pedidos.png" alt="Pedidos" class="menu-icon">
                                <span>Gestión de pedidos</span>
                            </a>
                        </li>
                        <li>
                            <a href="../ResenaServlet" class="menu-item">
                                <img src="../imgs/ticket.png" alt="Reseñas" class="menu-icon">
                                <span>Gestion de reseñas</span>
                            </a>
                        </li>
                        <li>
                            <a href="crearProducto.jsp" class="menu-item">
                                <img src="../imgs/perfil.png" alt="Admin" class="menu-icon">
                                <span>Administrador</span>
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

                    <div class="tabla-usuarios-container">
                        <table class="tabla-usuarios">
                            <thead>
                                <tr>
                                    <th>Nombre</th>
                                    <th>Email</th>
                                    <th>Rol</th>
                                    <th>Estado</th>
                                    <th>Fecha de Registro</th>
                                    <th>Acciones</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>Juan Pérez</td>
                                    <td>juan@example.com</td>
                                    <td>Cliente</td>
                                    <td><span class="estado-usuario estado-activo">Activo</span></td>
                                    <td>15/10/2023</td>
                                    <td class="acciones-celda">
                                        <a href="#" class="btn-cambiar-estado">Cambiar Estado</a>
                                        <a href="#" class="btn-eliminar-usuario">Eliminar</a>
                                    </td>
                                </tr>
                                <tr>
                                    <td>María García</td>
                                    <td>maria@example.com</td>
                                    <td>Admin</td>
                                    <td><span class="estado-usuario estado-activo">Activo</span></td>
                                    <td>12/10/2023</td>
                                    <td class="acciones-celda">
                                        <a href="#" class="btn-cambiar-estado">Cambiar Estado</a>
                                        <a href="#" class="btn-eliminar-usuario">Eliminar</a>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Carlos López</td>
                                    <td>carlos@example.com</td>
                                    <td>Cliente</td>
                                    <td><span class="estado-usuario estado-inactivo">Inactivo</span></td>
                                    <td>10/10/2023</td>
                                    <td class="acciones-celda">
                                        <a href="#" class="btn-cambiar-estado">Cambiar Estado</a>
                                        <a href="#" class="btn-eliminar-usuario">Eliminar</a>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </main>
        </div>

        <footer class="pie-pagina">
            <p>Aplicaciones Web – Unidad 2</p>
        </footer>
    </body>
</html>
