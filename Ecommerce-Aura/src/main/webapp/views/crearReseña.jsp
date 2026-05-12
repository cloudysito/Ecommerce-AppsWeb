<%-- 
    Document   : crearReseña
    Created on : 29/03/2026, 5:32:58 p. m.
    Author     : garfi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Crear Reseña</title>
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
            <a href="#cerrar-sesion" class="icon" title="Cerrar sesión"><img src="../imgs/salir.png" alt="Cerrar sesión"></a>
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
            <div class="resena-container">
                <h1>Crear Reseña</h1>
                <p class="subtitulo">Comparte tu experiencia con este producto para ayudar a otros.</p>

                <section class="producto-resena">
                    <h2>Producto a Reseñar</h2>
                    <div class="producto-info">
                        <img src="../imgs/audifonos.png" alt="Producto" class="producto-imagen">
                        <div class="producto-detalles">
                            <h3>Auriculares inalámbricos con Cancelación de Ruido</h3>
                            <p class="categoria">Electrónica > Audio</p>
                        </div>
                    </div>
                </section>

                <section class="calificacion-general">
                    <h2>Calificación General</h2>
                    <div class="puntuacion-container">
                        <label for="puntuacion">Puntuación Numérica (1-5)</label>
                        <div class="escala-puntuacion">
                            <span class="label-escala">Deficiente</span>
                            <input type="range" id="puntuacion" name="puntuacion" min="1" max="5" value="4"
                                class="slider">
                            <span class="label-escala">Excelente</span>
                            <span class="valor-puntuacion" id="valor-puntuacion">4</span>
                        </div>
                    </div>
                </section>

                <section class="experiencia">
                    <h2>Tu Experiencia</h2>
                    <textarea id="experiencia" placeholder="¿Qué te gustó o disgustó? ¿Cómo utilizaste el producto?"
                        rows="8"></textarea>
                </section>

                <div class="botones-accion">
                    <button class="boton-cancelar">Cancelar</button>
                    <button class="boton-enviar">Enviar reseña</button>
                </div>
            </div>
        </main>
    </div>

    <footer class="pie-pagina">
        <p>Aplicaciones Web – Unidad 2</p>
    </footer>
</body>

</html>
