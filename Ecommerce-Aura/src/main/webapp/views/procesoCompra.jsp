
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="es">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Proceso de Compra</title>
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/cssCliente/common.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/cssCliente/header-footer.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/cssCliente/procesoCompra.css">
    </head>

    <body>
        <header class="barra-superior">
            <div class="header-left">
                <img src="${pageContext.request.contextPath}/imgs/logo.png" alt="Logo" class="logo-img">
                <span class="logo-text">Ecommerce</span>
            </div>
            <div class="header-right">
                <a href="${pageContext.request.contextPath}/views/perfilUsuario.jsp" class="icon" title="Perfil"><img src="${pageContext.request.contextPath}/imgs/perfil.png" alt="Perfil"></a>
                <a href="${pageContext.request.contextPath}/UsuarioServlet?accion=logout" class="icon" title="Cerrar sesión"><img src="${pageContext.request.contextPath}/imgs/salir.png" alt="Cerrar sesión"></a>
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
                                        <label for="nombreCompleto">Nombre Completo</label>
                                        <input type="text" id="nombreCompleto" placeholder="Usuario Estudiante">
                                    </div>
                                    <div class="campo">
                                        <label for="telefonoEnvio">Número de Teléfono</label>
                                        <input type="text" id="telefonoEnvio" placeholder="(644) 000-0000">
                                    </div>
                                </div>

                                <div class="campo">
                                    <label for="direccionEntrega">Dirección de Entrega</label>
                                    <input type="text" id="direccionEntrega" placeholder="Ingresar calle, edificio, número de apartamento...">
                                </div>

                                <div class="fila-doble">
                                    <div class="campo">
                                        <label for="ciudadEnvio">Ciudad</label>
                                        <input type="text" id="ciudadEnvio" placeholder="Ciudad">
                                    </div>
                                    <div class="campo">
                                        <label for="codigoPostal">Código Postal</label>
                                        <input type="text" id="codigoPostal" placeholder="C.P">
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
                                        <label for="numeroTarjeta">Número de Tarjeta</label>
                                        <input type="text" id="numeroTarjeta" placeholder="1234 5678 9012 3456">
                                    </div>

                                    <div class="fila-doble">
                                        <div class="campo">
                                            <label for="fechaVencimiento">MM/AA</label>
                                            <input type="text" id="fechaVencimiento" placeholder="MM/AA">
                                        </div>
                                        <div class="campo">
                                            <label for="cvc">CVC</label>
                                            <input type="text" id="cvc" placeholder="CVC">
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
                            <form action="${pageContext.request.contextPath}/procesarCompra" method="POST">
                            <section class="resumen-pedido">
                                <h2>Resumen del Pedido</h2>

                                <c:choose>
                                    <c:when test="${not empty sessionScope.carrito}">
                                        <c:set var="subtotal" value="0.0" scope="page" />
                                        <c:forEach var="it" items="${sessionScope.carrito}">
                                            <div class="item-resumen">
                                                <c:choose>
                                                    <c:when test="${not empty it.producto.imagenProducto}">
                                                        <c:choose>
                                                            <c:when test="${it.producto.imagenProducto.contains('/')}">
                                                                <img src="${pageContext.request.contextPath}/${it.producto.imagenProducto}" alt="${it.producto.nombre}" class="img-item">
                                                            </c:when>
                                                            <c:otherwise>
                                                                <img src="${pageContext.request.contextPath}/imgs/${it.producto.imagenProducto}" alt="${it.producto.nombre}" class="img-item">
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <div class="img-placeholder">📦</div>
                                                    </c:otherwise>
                                                </c:choose>

                                                <div class="info-item">
                                                    <p class="nombre-item">${it.producto.nombre}</p>
                                                    <p class="cantidad-item">Cant: ${it.cantidad}</p>
                                                </div>
                                                <p class="precio-item">$${it.producto.precio}</p>
                                            </div>
                                            <c:set var="subtotal" value="${subtotal + (it.producto.precio * it.cantidad)}" scope="page" />
                                        </c:forEach>

                                        <div class="separador"></div>

                                        <c:set var="envio" value="5.0" scope="page" />
                                        <c:set var="taxRate" value="0.038" scope="page" />
                                        <c:set var="impuestos" value="${subtotal * taxRate}" scope="page" />
                                        <c:set var="total" value="${subtotal + envio + impuestos}" scope="page" />

                                        <div class="fila-total">
                                            <span>Subtotal</span>
                                            <span>$<fmt:formatNumber value="${subtotal}" type="number" minFractionDigits="2" maxFractionDigits="2"/></span>
                                        </div>
                                        <div class="fila-total">
                                            <span>Envío</span>
                                            <span>$<fmt:formatNumber value="${envio}" type="number" minFractionDigits="2" maxFractionDigits="2"/></span>
                                        </div>
                                        <div class="fila-total">
                                            <span>Impuestos</span>
                                            <span>$<fmt:formatNumber value="${impuestos}" type="number" minFractionDigits="2" maxFractionDigits="2"/></span>
                                        </div>

                                        <div class="separador"></div>

                                        <div class="fila-total-final">
                                            <span>Total</span>
                                            <span class="monto-total">$<fmt:formatNumber value="${total}" type="number" minFractionDigits="2" maxFractionDigits="2"/></span>
                                        </div>

                                        <button type="submit" class="btn-generar-pedido">✓ Generar Pedido</button>
                                        <p class="texto-seguro">🔒 Proceso de pago seguro</p>

                                    </c:when>
                                    <c:otherwise>
                                        <p>Tu carrito está vacío.</p>
                                    </c:otherwise>
                                </c:choose>

                            </section>
                            </form>
                        </div>
                    </div>
                </div>
            </main>
        </div>

        <footer class="pie-pagina">
            <p>Aplicaciones Web</p>
        </footer>
        <script src="${pageContext.request.contextPath}/assets/js/theme.js"></script>
    </body>

</html>

