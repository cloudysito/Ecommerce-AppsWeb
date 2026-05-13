
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Proceso de Compra</title>
        <link rel="stylesheet" type="text/css" href="../assets/cssCliente/common.css">
        <link rel="stylesheet" type="text/css" href="../assets/cssCliente/header-footer.css">
        <link rel="stylesheet" type="text/css" href="../assets/cssCliente/procesoCompra.css">
    </head>

    <body>
        <header class="barra-superior">
            <div class="header-left">
                <img src="../imgs/logo.png" alt="Logo" class="logo-img">
                <span class="logo-text">Ecommerce</span>
            </div>
            <div class="header-right">
                <a href="perfilUsuario.jsp" class="icon" title="Perfil"><img src="../imgs/perfil.png" alt="Perfil"></a>
                <a href="../UsuarioServlet?accion=logout" class="icon" title="Cerrar sesión"><img src="../imgs/salir.png"
                                                                                  alt="Cerrar sesión"></a>
                <button id="theme-toggle" class="theme-toggle" title="Cambiar tema">🌙</button>
            </div>
        </header>

        <div class="container"> <jsp:include page="menuLateralCliente.jsp" />

            <main class="contenido">
                <div class="proceso-wrapper">
                    <h1>Proceso de Compra</h1>
                    <p class="subtitulo-proceso">Unidad 2</p>

                    <div class="proceso-contenedor">
                        <div class="proceso-formulario">
                            <section class="seccion-proceso">
                                <h2>Información de Envío</h2>

                                <div class="fila-doble">
                                    <div class="campo">
                                        <label>Nombre Completo</label>
                                        <input type="text" placeholder="Usuario Estudiante">
                                    </div>
                                    <div class="campo">
                                        <label>Número de Teléfono</label>
                                        <input type="text" placeholder="(644) 000-0000">
                                    </div>
                                </div>

                                <div class="campo">
                                    <label>Dirección de Entrega</label>
                                    <input type="text" placeholder="Ingresar calle, edificio, número de apartamento...">
                                </div>

                                <div class="fila-doble">
                                    <div class="campo">
                                        <label>Ciudad</label>
                                        <input type="text" placeholder="Ciudad">
                                    </div>
                                    <div class="campo">
                                        <label>Código Postal</label>
                                        <input type="text" placeholder="C.P">
                                    </div>
                                </div>
                            </section>
                            <section class="seccion-proceso">
                                <h2>Método de Pago</h2>
                                <div class="opcion-pago">
                                    <input type="radio" id="tarjeta" name="pago" value="tarjeta" checked>
                                    <label for="tarjeta" class="label-pago">Tarjeta de Crédito / Debito</label>
                                </div>

                                <div class="datos-tarjeta">
                                    <div class="campo">
                                        <label>Número de Tarjeta</label>
                                        <input type="text" placeholder="1234 5678 9012 3456">
                                    </div>

                                    <div class="fila-doble">
                                        <div class="campo">
                                            <label>MM/AA</label>
                                            <input type="text" placeholder="MM/AA">
                                        </div>
                                        <div class="campo">
                                            <label>CVC</label>
                                            <input type="text" placeholder="CVC">
                                        </div>
                                    </div>
                                </div>

                                <div class="opcion-pago">
                                    <input type="radio" id="saldo" name="pago" value="saldo">
                                    <label for="saldo" class="label-pago">Efectivo</label>
                                </div>
                            </section>
                        </div>

                        <div class="proceso-resumen">
                            <section class="resumen-pedido">
                                <h2>Resumen del Pedido</h2>

                                <div class="item-resumen">
                                    <img src="../imgs/reloj.png" alt="Reloj" class="img-item">
                                    <div class="info-item">
                                        <p class="nombre-item">Reloj Inteligente con Funciones de Salud</p>
                                        <p class="cantidad-item">Cant: 1</p>
                                    </div>
                                    <p class="precio-item">$199.99</p>
                                </div>

                                <div class="item-resumen">
                                    <img src="../imgs/audifonos.png" alt="Auriculares" class="img-item">
                                    <div class="info-item">
                                        <p class="nombre-item">Auriculares inalámbricos con Cancelación de Ruido</p>
                                        <p class="cantidad-item">Cant: 2</p>
                                    </div>
                                    <p class="precio-item">$179.00</p>
                                </div>

                                <div class="separador"></div>

                                <div class="fila-total">
                                    <span>Subtotal</span>
                                    <span>$378.99</span>
                                </div>
                                <div class="fila-total">
                                    <span>Envío</span>
                                    <span>$5.00</span>
                                </div>
                                <div class="fila-total">
                                    <span>Impuestos</span>
                                    <span>$14.40</span>
                                </div>

                                <div class="separador"></div>

                                <div class="fila-total-final">
                                    <span>Total</span>
                                    <span class="monto-total">$398.39</span>
                                </div>

                                <button class="btn-generar-pedido" onclick="window.location.href = 'confirmacionCompra.jsp'">✓ Generar Pedido</button>
                                <p class="texto-seguro">🔒 Proceso de pago seguro</p>
                            </section>
                        </div>
                    </div>
                </div>
            </main>
        </div>

        <footer class="pie-pagina">
            <p>Aplicaciones Web</p>
        </footer>
        <script src="../assets/js/theme.js"></script>
    </body>

</html>

