<%-- 
    Document   : carritoCompras
    Created on : 29/03/2026, 5:22:48 p. m.
    Author     : garfi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tu Carrito</title>
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
            <div class="carrito-wrapper">
                <h1>Tu Carrito</h1>

                <div class="carrito-container">
                    <table class="tabla-carrito">
                        <thead>
                            <tr>
                                <th>Producto</th>
                                <th>Precio</th>
                                <th>Cantidad</th>
                                <th>Subtotal</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>
                                    <div class="producto-celda">
                                        <img src="../imgs/reloj.png" alt="Reloj Inteligente" class="producto-miniatura">
                                        <div>
                                            <p class="producto-nombre">Reloj Inteligente Modelo X</p>
                                            <p class="producto-color">Color: Turquesa</p>
                                        </div>
                                    </div>
                                </td>
                                <td>$199.99</td>
                                <td>
                                    <div class="cantidad-control">
                                        <button class="btn-cantidad">−</button>
                                        <input type="number" value="1" class="cantidad-input" readonly>
                                        <button class="btn-cantidad">+</button>
                                    </div>
                                </td>
                                <td>$199.99</td>
                                <td>
                                    <button class="btn-eliminar" title="Eliminar"><img src="../imgs/basura.png"
                                            alt="Eliminar"></button>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div class="producto-celda">
                                        <img src="../imgs/audifonos.png" alt="Audífonos" class="producto-miniatura">
                                        <div>
                                            <p class="producto-nombre">Audífonos Inalámbricos Pro</p>
                                            <p class="producto-color">Color: Lila</p>
                                        </div>
                                    </div>
                                </td>
                                <td>$89.50</td>
                                <td>
                                    <div class="cantidad-control">
                                        <button class="btn-cantidad">−</button>
                                        <input type="number" value="2" class="cantidad-input" readonly>
                                        <button class="btn-cantidad">+</button>
                                    </div>
                                </td>
                                <td>$179.00</td>
                                <td>
                                    <button class="btn-eliminar" title="Eliminar"><img src="../imgs/basura.png"
                                            alt="Eliminar"></button>
                                </td>
                            </tr>
                        </tbody>
                    </table>

                    <div class="carrito-footer">
                        <a href="#continuar" class="btn-continuar">← Continuar comprando</a>

                        <div class="totales-pago">
                            <div class="total-section">
                                <span class="total-label">Total a pagar:</span>
                                <span class="total-monto">$378.99</span>
                            </div>
                            <button class="btn-pagar" onclick="window.location.href='procesoCompra.jsp'">Pagar
                                ahora</button>
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
