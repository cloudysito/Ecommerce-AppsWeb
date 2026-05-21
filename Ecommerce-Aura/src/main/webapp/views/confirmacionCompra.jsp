<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="es">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Confirmación de Compra</title>
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/cssCliente/common.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/cssCliente/header-footer.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/cssCliente/confirmacionCompra.css">
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
            </div>
        </header>

        <div class="container">
            <jsp:include page="menuLateralCliente.jsp" />

            <main class="contenido">
                <c:set var="compraFinalizada" value="${param.finalizada == '1'}" />
                <c:set var="previewTotal" value="0.0" scope="page" />
                <c:set var="totalActual" value="0.0" scope="page" />
                <c:set var="metodoActual" value="" scope="page" />

                <c:if test="${not compraFinalizada and not empty sessionScope.carrito}">
                    <c:forEach var="it" items="${sessionScope.carrito}">
                        <c:set var="previewTotal" value="${previewTotal + (it.producto.precio * it.cantidad)}" scope="page" />
                    </c:forEach>
                </c:if>

                <c:choose>
                    <c:when test="${compraFinalizada}">
                        <c:set var="totalActual" value="${sessionScope.ultimaCompraTotal}" scope="page" />
                        <c:set var="metodoActual" value="${sessionScope.ultimaCompraMetodoPago}" scope="page" />
                    </c:when>
                    <c:otherwise>
                        <c:set var="totalActual" value="${previewTotal}" scope="page" />
                        <c:set var="metodoActual" value="${sessionScope.checkoutMetodoPago}" scope="page" />
                    </c:otherwise>
                </c:choose>

                <div class="confirmacion-wrapper">
                    <div class="confirmacion-container">
                        <div class="confirmacion-icono">
                            <img src="${pageContext.request.contextPath}/imgs/palomita.png" alt="Confirmación" class="icono-confirmacion">
                        </div>

                        <c:choose>
                            <c:when test="${compraFinalizada}">
                                <h1>Orden Confirmada</h1>
                                <p class="confirmacion-mensaje">¡Gracias por tu compra! Hemos recibido tu pedido y lo estamos preparando para el envío.</p>
                            </c:when>
                            <c:otherwise>
                                <h1>Confirmar compra</h1>
                                <p class="confirmacion-mensaje">Revisa tu información antes de finalizar el pedido.</p>
                            </c:otherwise>
                        </c:choose>

                        <c:if test="${not empty error or not empty mensajeError}">
                            <p class="confirmacion-mensaje" style="color:#ff8080; margin-top:10px;">
                                <c:choose>
                                    <c:when test="${not empty error}">${error}</c:when>
                                    <c:otherwise>${mensajeError}</c:otherwise>
                                </c:choose>
                            </p>
                        </c:if>

                        <div class="confirmacion-detalles">
                            <div class="detalle-item">
                                <label class="detalle-label">Número de Pedido</label>
                                <p class="detalle-valor">
                                    <c:choose>
                                        <c:when test="${compraFinalizada}">#${sessionScope.ultimaCompraPedidoId}</c:when>
                                        <c:otherwise>#PENDIENTE</c:otherwise>
                                    </c:choose>
                                </p>
                            </div>

                            <div class="detalle-item">
                                <label class="detalle-label">Fecha de Compra</label>
                                <p class="detalle-valor">
                                    <c:choose>
                                        <c:when test="${compraFinalizada}">${sessionScope.ultimaCompraFecha}</c:when>
                                        <c:otherwise>No disponible</c:otherwise>
                                    </c:choose>
                                </p>
                            </div>

                            <div class="detalle-item">
                                <label class="detalle-label">Dirección de Envío</label>
                                <p class="detalle-valor">
                                    <c:choose>
                                        <c:when test="${compraFinalizada}">
                                            ${sessionScope.usuarioActivo.nombreCompleto}<br>
                                            ${sessionScope.ultimaCompraDireccion}
                                        </c:when>
                                        <c:otherwise>
                                            <c:choose>
                                                <c:when test="${not empty sessionScope.checkoutNombre}">${sessionScope.checkoutNombre}</c:when>
                                                <c:otherwise>${sessionScope.usuarioActivo.nombreCompleto}</c:otherwise>
                                            </c:choose><br>
                                            <c:choose>
                                                <c:when test="${not empty sessionScope.checkoutDireccion}">${sessionScope.checkoutDireccion}</c:when>
                                                <c:otherwise>No disponible</c:otherwise>
                                            </c:choose>
                                        </c:otherwise>
                                    </c:choose>
                                </p>
                            </div>

                            <div class="detalle-item">
                                <label class="detalle-label">Costo Total</label>
                                <p class="detalle-valor total">$
                                    <fmt:formatNumber value="${totalActual}" type="number" minFractionDigits="2" maxFractionDigits="2"/>
                                </p>
                            </div>
                            <div class="detalle-item">
                                <label class="detalle-label">Método de Pago</label>
                                <p class="detalle-valor">
                                    <c:choose>
                                        <c:when test="${metodoActual == 'tarjeta'}">💳 Tarjeta</c:when>
                                        <c:when test="${metodoActual == 'transferencia'}">🏦 Transferencia Bancaria</c:when>
                                        <c:when test="${metodoActual == 'contraEntrega'}">📦 Contra Entrega</c:when>
                                        <c:otherwise>No especificado</c:otherwise>
                                    </c:choose>
                                </p>
                            </div>

                            <c:if test="${not compraFinalizada}">
                                <div class="detalle-item" style="grid-column: 1 / -1;">
                                    <label class="detalle-label">Resumen de productos</label>
                                    <c:choose>
                                        <c:when test="${not empty sessionScope.carrito}">
                                            <c:forEach var="it" items="${sessionScope.carrito}">
                                                <p class="detalle-valor" style="margin-bottom: 4px;">
                                                    ${it.producto.nombre} x ${it.cantidad}
                                                </p>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <p class="detalle-valor">Tu carrito está vacío.</p>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </c:if>
                        </div>

                        <c:choose>
                            <c:when test="${compraFinalizada}">
                                <a href="${pageContext.request.contextPath}/views/index.jsp" class="btn-volver">Volver al Inicio</a>
                            </c:when>
                            <c:otherwise>
                                <form action="${pageContext.request.contextPath}/PedidoServlet" method="POST" style="margin-top: 20px;">
                                    <input type="hidden" name="accion" value="confirmarPedido" />
                                    <button type="submit" class="btn-volver">Confirmar compra</button>
                                </form>
                                <a href="${pageContext.request.contextPath}/views/carritoCompras.jsp" class="btn-volver" style="margin-top: 12px; display:inline-block; background:#2f4c76;">Volver al carrito</a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </main>
        </div>
        </body>

</html>
