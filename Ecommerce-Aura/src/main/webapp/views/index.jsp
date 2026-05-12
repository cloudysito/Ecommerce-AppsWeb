<%-- 
    Document   : index
    Created on : 29/03/2026, 5:41:23 p. m.
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
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@700;800&display=swap" rel="stylesheet">
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

            <main class="contenido">
                <section class="productos-destacados">
                    <div class="productos-grid">

                        <div class="producto">
                            <h3 class="titulo-principal">Proyecto ECommerce</h3>
                            <p class="subtitulo-principal">Unidad 2</p>

                            <div class="texto-desarrollo">
                                <h3> Equipo de Desarrollo</h3>
                            </div>

                            <div class="equipo-desarrollo">

                                <div class="tarjeta-desarrollador">
                                    <div class="icono-dev">
                                        <span>&lt;&gt;</span>
                                    </div>
                                    <div class="info-dev">
                                        <p class="nombre-dev">Maria Jose Enriquez Lara</p>
                                        <p class="id-dev">ID: 00000252337</p>
                                    </div>
                                </div>

                                <div class="tarjeta-desarrollador">
                                    <div class="icono-dev">
                                        <span>&lt;&gt;</span>
                                    </div>
                                    <div class="info-dev">
                                        <p class="nombre-dev">Jose Adolfo Ortega Ruiz</p>
                                        <p class="id-dev">ID: 00000252882</p>
                                    </div>
                                </div>

                                <div class="tarjeta-desarrollador">
                                    <div class="icono-dev">
                                        <span>&lt;&gt;</span>
                                    </div>
                                    <div class="info-dev">
                                        <p class="nombre-dev">Emiliano Marquez Esquer</p>
                                        <p class="id-dev">ID: 00000252714</p>
                                    </div>
                                </div>

                                <div class="info-proyecto">
                                    <h3>&#8505; Sobre este proyecto</h3>
                                    <p>Esta aplicación web es parte de los requerimientos para la Unidad 2. Implementa la estructura básica solicitada, incluyendo navegación consistente, manejo de modos claro/oscuro y diseño responsivo utilizando HTML Y CSS.</p>
                                </div>

                            </div> 
                        </div>
                    </div>
                </section>
            </main>
        </div>

        <footer class="pie-pagina">
            <p>Aplicaciones Web – Unidad 2</p>
        </footer>
    </body>

</html>
