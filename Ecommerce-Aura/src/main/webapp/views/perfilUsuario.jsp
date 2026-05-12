<%-- 
    Document   : perfilUsuario
    Created on : 29/03/2026, 5:44:01 p. m.
    Author     : garfi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Perfil de Usuario - Ecommerce</title>
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
                                <img src="../imgs/inicio.png" alt="Inicio" class="menu-icon">
                                <a href="index.jsp">Inicio</a>
                            </div>
                        </li>
                        <li>
                            <div class="menu-item">
                                <img src="../imgs/catalogo.png" alt="Catálogo de productos" class="menu-icon">
                                <a href="catalogo.jsp">Catálogo de productos</a>
                            </div>
                        </li>
                        <li>
                            <div class="menu-item">
                                <img src="../imgs/carrito.png" alt="Carrito de compras" class="menu-icon">
                                <a href="carritoCompras.jsp">Carrito de compras</a>
                            </div>
                        </li>
                        <li>
                            <div class="menu-item">
                                <img src="../imgs/pedidos.png" alt="Gestión de pedidos" class="menu-icon">
                                <a href="gestionPedidos.jsp">Gestión de pedidos</a>
                            </div>
                        </li>
                    </ul>
                </nav>
            </aside>

            <main class="contenido pantalla-centrada">
                <div class="contenedor-perfil">
                    <div class="tarjeta-perfil">

                        <div class="cabecera-perfil">
                            <h2>Perfil de Usuario</h2>
                        </div>

                        <form class="formulario-perfil">

                            <div class="grupo-formulario">
                                <label for="nombre">Nombre completo</label>
                                <input type="text" id="nombre" value="Juan Pérez">
                            </div>

                            <div class="grupo-formulario">
                                <label for="correo">Correo electrónico</label>
                                <input type="email" id="correo" value="juan.perez@universidad.edu">
                            </div>

                            <div class="grupo-formulario">
                                <label for="telefono">Teléfono</label>
                                <input type="text" id="telefono" value="+1 (555) 000-0000">
                            </div>

                            <div class="grupo-formulario">
                                <label for="direccion">Dirección de envío</label>
                                <textarea id="direccion" rows="3">Av. Universidad 123, Depto 4B, Ciudad, Estado, CP</textarea>
                            </div>

                            <div class="contenedor-boton-derecha">
                                <button type="button" class="btn-guardar">Guardar</button>
                            </div>

                        </form>
                    </div>
                </div>
            </main>
        </div>

        <footer class="pie-pagina">
            <p>Aplicaciones Web – Unidad 2</p>
        </footer>
    </body>

</html>
