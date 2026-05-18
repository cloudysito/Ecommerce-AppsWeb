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
            <button id="theme-toggle" class="theme-toggle" title="Cambiar tema">🌙</button>
        </div>
    </header>

   <div class="container"> <jsp:include page="menuLateralCliente.jsp" />

        <main class="contenido">
            <div class="confirmacion-wrapper">
                <div class="confirmacion-container">
                    <div class="confirmacion-icono">
                        <img src="${pageContext.request.contextPath}/imgs/palomita.png" alt="Confirmación" class="icono-confirmacion">
                    </div>
                    
                    <h1>Orden Confirmada</h1>
                    <p class="confirmacion-mensaje">¡Gracias por tu compra! Hemos recibido tu pedido y lo estamos preparando para el envío.</p>
                    
                    <div class="confirmacion-detalles">
                        <div class="detalle-item">
                            <label class="detalle-label">Número de Pedido</label>
                            <p class="detalle-valor">#${sessionScope.ultimaCompraPedidoId != null ? sessionScope.ultimaCompraPedidoId : 'PENDIENTE'}</p>
                        </div>

                        <div class="detalle-item">
                            <label class="detalle-label">Fecha de Compra</label>
                            <p class="detalle-valor">${sessionScope.ultimaCompraFecha != null ? sessionScope.ultimaCompraFecha : 'No disponible'}</p>
                        </div>

                        <div class="detalle-item">
                            <label class="detalle-label">Dirección de Envío</label>
                            <p class="detalle-valor">
                                ${sessionScope.usuarioActivo != null ? sessionScope.usuarioActivo.nombreCompleto : 'Cliente'}<br>
                                ${sessionScope.ultimaCompraDireccion != null ? sessionScope.ultimaCompraDireccion : 'No disponible'}
                            </p>
                        </div>

                        <div class="detalle-item">
                            <label class="detalle-label">Costo Total</label>
                            <p class="detalle-valor total">$
                                <fmt:formatNumber value="${sessionScope.ultimaCompraTotal != null ? sessionScope.ultimaCompraTotal : 0.0}" type="number" minFractionDigits="2" maxFractionDigits="2"/>
                            </p>
                        </div>
                    </div>
                    
                    <a href="${pageContext.request.contextPath}/views/index.jsp" class="btn-volver">Volver al Inicio</a>
                </div>
            </div>
        </main>
    </div>
    <script src="${pageContext.request.contextPath}/assets/js/theme.js"></script>
</body>

</html>
