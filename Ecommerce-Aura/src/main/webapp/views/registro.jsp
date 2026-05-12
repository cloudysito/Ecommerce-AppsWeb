<%-- 
    Document   : registro
    Created on : 29/03/2026, 5:45:36 p. m.
    Author     : garfi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Proyecto ECommerce</title>
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

            <main class="contenido fondo-login">
                <div class="contenedor-registro">
                    <div class="tarjeta-registro"> <div class="cabecera-registro">
                            <h2>Crear Cuenta</h2>
                            <p>Regístrate para comenzar a comprar lo que necesitas para la universidad.</p>
                        </div>

                        <form class="formulario-registro">

                            <div class="grid-formularios">
                                <div class="grupo-formulario">
                                    <label for="nombre">Nombre completo</label>
                                    <input type="text" id="nombre" placeholder="Juan Pérez">
                                </div>

                                <div class="grupo-formulario">
                                    <label for="correo">Correo electrónico</label>
                                    <input type="email" id="correo" placeholder="juan.perez@universidad.edu">
                                </div>

                                <div class="grupo-formulario">
                                    <label for="password">Contraseña</label>
                                    <input type="password" id="password" placeholder="••••••••">
                                </div>

                                <div class="grupo-formulario">
                                    <label for="confirm_password">Confirmación de contraseña</label>
                                    <input type="password" id="confirm_password" placeholder="••••••••">
                                </div>

                                <div class="grupo-formulario">
                                    <label for="telefono">Teléfono</label>
                                    <input type="text" id="telefono" placeholder="+1 (555) 000-0000">
                                </div>
                            </div>

                            <div class="grupo-formulario">
                                <label for="direccion">Dirección de envío</label>
                                <textarea id="direccion" rows="4" placeholder="Av. Universidad 123, Depto 4B, Ciudad, Estado, CP"></textarea>
                            </div>

                            <div class="grupo-checkbox">
                                <input type="checkbox" id="terminos">
                                <label for="terminos">Acepto los <a href="#">Términos de Servicio</a> y la <a href="#">Política de Privacidad</a></label>
                            </div>

                            <div class="contenedor-boton">
                                <button type="submit" class="btn-crear">Crear cuenta</button>
                            </div>

                        </form>

                        <div class="pie-login">
                            <p>¿Ya tienes una cuenta? <a href="login.jsp">Inicia sesión aquí</a></p>
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
