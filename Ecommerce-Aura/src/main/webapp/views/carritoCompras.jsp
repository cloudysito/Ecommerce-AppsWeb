<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tu Carrito</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/cssCliente/common.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/cssCliente/header-footer.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/cssCliente/carrito.css">
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
                            <c:choose>
                                <c:when test="${not empty carritoItems}">
                                    <c:forEach var="it" items="${carritoItems}">
                                        <tr>
                                            <td>
                                                <div class="producto-celda">
                                                    <c:choose>
                                                        <c:when test="${not empty it.producto.imagenProducto}">
                                                            <img src="${pageContext.request.contextPath}/imgs/${it.producto.imagenProducto}" alt="${it.producto.nombre}" class="producto-miniatura">
                                                        </c:when>
                                                        <c:otherwise>
                                                            <div class="img-placeholder">📦</div>
                                                        </c:otherwise>
                                                    </c:choose>
                                                    <div>
                                                        <p class="producto-nombre">${it.producto.nombre}</p>
                                                    </div>
                                                </div>
                                            </td>
                                            <td>$${it.producto.precio}</td>
                                            <td>
                                                <div class="cantidad-control">
                                                    <input type="number" value="${it.cantidad}" class="cantidad-input" readonly>
                                                </div>
                                            </td>
                                            <td>$${it.producto.precio * it.cantidad}</td>
                                            <td>
                                                <form action="${pageContext.request.contextPath}/CarritoServlet" method="POST" style="display:inline">
                                                    <input type="hidden" name="accion" value="remove" />
                                                    <input type="hidden" name="id" value="${it.producto.id}" />
                                                    <button class="btn-eliminar" title="Eliminar" type="submit"><img src="${pageContext.request.contextPath}/imgs/basura.png" alt="Eliminar"></button>
                                                </form>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="5">Tu carrito está vacío.</td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>

                    <div class="carrito-footer">
                        <a href="${pageContext.request.contextPath}/ProductoServlet" class="btn-continuar">← Continuar comprando</a>

                        <div class="totales-pago">
                            <div class="total-section">
                                <span class="total-label">Total a pagar:</span>
                                <span class="total-monto">$378.99</span>
                            </div>
                            <button class="btn-pagar" onclick="window.location.href='${pageContext.request.contextPath}/views/procesoCompra.jsp'">Pagar
                                ahora</button>
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
