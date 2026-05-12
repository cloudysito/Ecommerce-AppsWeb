<%-- 
    Document   : catalogo
    Created on : 29/03/2026, 5:24:44 p. m.
    Author     : garfi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Catálogo de Productos</title>
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
            <div class="catalogo-wrapper">
                <h1 class="titulo-izq">Catálogo</h1>

                <div class="filtros-container">
                    <h2>Filtrar Productos</h2>
                    
                    <div class="filtros-grid">
                        <div class="grupo-filtro">
                            <label>Nombre del producto</label>
                            <div class="input-con-icono">
                                <span>🔍</span>
                                <input type="text" placeholder="Buscar...">
                            </div>
                        </div>

                        <div class="grupo-filtro">
                            <label>Rango de precio</label>
                            <div class="controles-precio">
                                <label class="radio-label">
                                    <input type="radio" name="rango" value="menor"> Menor que
                                </label>
                                <label class="radio-label">
                                    <input type="radio" name="rango" value="mayor"> Mayor que
                                </label>
                                <div class="input-con-icono-izq">
                                    <span>$</span>
                                    <input type="text" placeholder="00.00" class="input-corto">
                                </div>
                                <button class="btn-aplicar">Aplicar Filtros</button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="tabla-pedidos-container"> <table class="tabla-pedidos tabla-catalogo">
                        <thead>
                            <tr>
                                <th>IMAGEN</th>
                                <th>NOMBRE</th>
                                <th>PRECIO</th>
                                <th>DETALLES</th>
                                <th>ACCIONES</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>
                                    <div class="img-placeholder" style="background-color: #4a5568;">💻</div>
                                </td>
                                <td><span class="fw-bold">Laptop Pro 15"</span></td>
                                <td>$1,299.00</td>
                                <td><a href="detallesProducto.html" class="link-detalles">👁 Detalles</a></td>
                                <td>
                                    <div class="acciones-catalogo">
                                        <button class="btn-agregar">🛒 Agregar al carrito</button>
                                        <button class="btn-resena" onclick="window.location.href='crearReseña.jsp'">💬 Dejar reseña</button>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div class="img-placeholder" style="background-color: #fbd38d;">📱</div>
                                </td>
                                <td><span class="fw-bold">Smartphone Ultra</span></td>
                                <td>$899.50</td>
                                <td><a href="#" class="link-detalles">👁 Detalles</a></td>
                                <td>
                                    <div class="acciones-catalogo">
                                        <button class="btn-agregar">🛒 Agregar al carrito</button>
                                        <button class="btn-resena" onclick="window.location.href='crearReseña.jsp'">💬 Dejar reseña</button>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <img src="../imgs/audifonos.png" alt="Auriculares" class="img-catalogo">
                                </td>
                                <td><span class="fw-bold">Auriculares Inalámbricos</span></td>
                                <td>$149.99</td>
                                <td><a href="#" class="link-detalles">👁 Detalles</a></td>
                                <td>
                                    <div class="acciones-catalogo">
                                        <button class="btn-agregar">🛒 Agregar al carrito</button>
                                        <button class="btn-resena" onclick="window.location.href='crearReseña.jsp'">💬 Dejar reseña</button>
                                    </div>
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
