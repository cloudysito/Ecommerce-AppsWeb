<%-- 
    Document   : detallesProducto
    Created on : 29/03/2026, 5:33:44 p. m.
    Author     : garfi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Detalles del Producto</title>
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

        <main class="contenido fondo-claro">
            <div class="detalles-wrapper">
                
                <a href="catalogo.jsp" class="btn-regresar-enlace">← Volver al catálogo</a>

                <div class="producto-principal-card">
                    <div class="producto-galeria">
                        <div class="imagen-destacada">
                            <img src="../imgs/audifonos.png" alt="Auriculares Inalámbricos">
                        </div>
                    </div>

                    <div class="producto-info-detalle">
                        <span class="categoria-badge">Electrónica > Audio</span>
                        <h1>Auriculares inalámbricos con Cancelación de Ruido</h1>
                        
                        <div class="calificacion-estrellas">
                            ⭐⭐⭐⭐☆ <span>(24 reseñas)</span>
                        </div>

                        <div class="precio-detalle">$149.99</div>
                        
                        <p class="descripcion-corta">
                            Disfruta de tu música sin distracciones con nuestros auriculares de última generación. Cuentan con batería de larga duración (hasta 30 horas), ajuste ergonómico para uso prolongado, y sonido de alta fidelidad con bajos profundos.
                        </p>

                        <div class="stock-status">
                            <span class="punto-verde"></span> En stock (45 disponibles)
                        </div>

                        <div class="acciones-compra">
                            <div class="grupo-cantidad">
                                <label>Cantidad</label>
                                <div class="cantidad-control">
                                    <button class="btn-cantidad">−</button>
                                    <input type="number" value="1" class="cantidad-input" readonly>
                                    <button class="btn-cantidad">+</button>
                                </div>
                            </div>
                            
                            <button class="btn-agregar-grande" onclick="window.location.href='carritoCompras.jsp'">
                                🛒 Agregar al carrito
                            </button>
                        </div>

                        <div class="detalles-tecnicos">
                            <h3>Características principales:</h3>
                            <ul>
                                <li>Conectividad Bluetooth 5.0</li>
                                <li>Cancelación activa de ruido (ANC)</li>
                                <li>Micrófono integrado para llamadas</li>
                                <li>Carga rápida vía USB-C</li>
                            </ul>
                        </div>

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
