<%-- 
    Document   : gestionPedidos
    Created on : 29/03/2026, 5:39:16 p. m.
    Author     : garfi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Gestión de Pedidos</title>
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
                <div class="pedidos-wrapper">
                    <h1>Gestión de Pedidos</h1>

                    <div class="tabla-pedidos-container">
                        <table class="tabla-pedidos">
                            <thead>
                                <tr>
                                    <th>N° DE PEDIDO</th>
                                    <th>FECHA</th>
                                    <th>TOTAL PAGADO</th>
                                    <th>ESTADO</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>
                                        <div class="celda-pedido">
                                            <img src="../imgs/ticket.png" alt="Pedido" class="icono-pedido">
                                            <span>#ORD-1001</span>
                                        </div>
                                    </td>
                                    <td>26 Oct, 2023</td>
                                    <td>$125.00</td>
                                    <td><span class="estado-pedido estado-pendiente">Pendiente</span></td>
                                </tr>
                                <tr>
                                    <td>
                                        <div class="celda-pedido">
                                            <img src="../imgs/ticket.png" alt="Pedido" class="icono-pedido">
                                            <span>#ORD-1002</span>
                                        </div>
                                    </td>
                                    <td>25 Oct, 2023</td>
                                    <td>$45.50</td>
                                    <td><span class="estado-pedido estado-enviado">Enviado</span></td>
                                </tr>
                                <tr>
                                    <td>
                                        <div class="celda-pedido">
                                            <img src="../imgs/ticket.png" alt="Pedido" class="icono-pedido">
                                            <span>#ORD-1003</span>
                                        </div>
                                    </td>
                                    <td>20 Oct, 2023</td>
                                    <td>$320.00</td>
                                    <td><span class="estado-pedido estado-entregado">Entregado</span></td>
                                </tr>
                                <tr>
                                    <td>
                                        <div class="celda-pedido">
                                            <img src="../imgs/ticket.png" alt="Pedido" class="icono-pedido">
                                            <span>#ORD-1004</span>
                                        </div>
                                    </td>
                                    <td>19 Oct, 2023</td>
                                    <td>$89.99</td>
                                    <td><span class="estado-pedido estado-entregado">Entregado</span></td>
                                </tr>
                                <tr>
                                    <td>
                                        <div class="celda-pedido">
                                            <img src="../imgs/ticket.png" alt="Pedido" class="icono-pedido">
                                            <span>#ORD-1005</span>
                                        </div>
                                    </td>
                                    <td>18 Oct, 2023</td>
                                    <td>$210.50</td>
                                    <td><span class="estado-pedido estado-pendiente">Pendiente</span></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </main>
        </div>
    </body>

</html>
