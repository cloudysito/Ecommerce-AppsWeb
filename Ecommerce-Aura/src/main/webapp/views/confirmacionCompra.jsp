<%-- 
    Document   : confirmacionCompra
    Created on : 29/03/2026, 5:25:54 p. m.
    Author     : garfi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Confirmación de Compra</title>
    <link rel="stylesheet" type="text/css" href="../assets/styles.css">
</head>

<body>
    <header class="barra-superior">
        <div class="header-left">
            <img src="../imgs/logo.png" alt="Logo" class="logo-img">
            <span class="logo-text">Ecommerce</span>
        </div>
        <div class="header-right">
            <a href="#perfil" class="icon" title="Perfil"><img src="../imgs/perfil.png" alt="Perfil"></a>
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
            <div class="confirmacion-wrapper">
                <div class="confirmacion-container">
                    <div class="confirmacion-icono">
                        <img src="../imgs/palomita.png" alt="Confirmación" class="icono-confirmacion">
                    </div>
                    
                    <h1>Orden Confirmada</h1>
                    <p class="confirmacion-mensaje">¡Gracias por tu compra! Hemos recibido tu pedido y lo estamos preparando para el envío.</p>
                    
                    <div class="confirmacion-detalles">
                        <div class="detalle-item">
                            <label class="detalle-label">Número de Pedido</label>
                            <p class="detalle-valor">#ORD-987654321</p>
                        </div>
                        
                        <div class="detalle-item">
                            <label class="detalle-label">Fecha de Compra</label>
                            <p class="detalle-valor">26 de Octubre, 2023</p>
                        </div>
                        
                        <div class="detalle-item">
                            <label class="detalle-label">Dirección de Envío</label>
                            <p class="detalle-valor">
                                Juan Pérez<br>
                                123 Avenida Universidad, Apt 4B<br>
                                Ciudad Universitaria, ST 12345
                            </p>
                        </div>
                        
                        <div class="detalle-item">
                            <label class="detalle-label">Costo Total</label>
                            <p class="detalle-valor total">$398.39</p>
                        </div>
                    </div>
                    
                    <a href="#inicio" class="btn-volver">Volver al Inicio</a>
                </div>
            </div>
        </main>
    </div>
</body>

</html>
