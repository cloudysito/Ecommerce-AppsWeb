
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Detalles del Producto</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/cssCliente/common.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/cssCliente/header-footer.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/cssCliente/detalleProducto.css">
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

        <main class="contenido fondo-claro">
            <div class="detalles-wrapper">
                
                <a href="${pageContext.request.contextPath}/views/catalogo.jsp" class="btn-regresar-enlace">← Volver al catálogo</a>

                <div class="producto-principal-card">
                    <div class="producto-galeria">
                        <div class="imagen-destacada">
                            <img src="${pageContext.request.contextPath}/imgs/audifonos.png" alt="Auriculares Inalámbricos">
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
                            
                            <button class="btn-agregar-grande" onclick="window.location.href='${pageContext.request.contextPath}/views/carritoCompras.jsp'">
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
            <p>Aplicaciones Web</p>
    </footer>
    <script src="${pageContext.request.contextPath}/assets/js/theme.js"></script>
</body>

</html>

