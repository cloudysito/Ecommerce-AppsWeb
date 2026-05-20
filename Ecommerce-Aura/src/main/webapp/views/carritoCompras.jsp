<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
            </div>
        </header>

        <div class="container"> <jsp:include page="menuLateralCliente.jsp" />

            <main class="contenido">
                <div class="carrito-wrapper">
                    <h1>Tu Carrito</h1>

                    <c:set var="totalAcumulado" value="${0.0}" />
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
                                            <c:set var="totalAcumulado" value="${totalAcumulado + (it.producto.precio * it.cantidad)}" />

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
                                                    <div class="cantidad-control" style="display: flex; align-items: center; justify-content: center; gap: 5px;">
                                                        <form action="${pageContext.request.contextPath}/CarritoServlet" method="POST" id="form-${it.producto.id}">
                                                            <input type="hidden" name="accion" value="update" />
                                                            <input type="hidden" name="id" value="${it.producto.id}" />

                                                            <button type="button" class="btn-cantidad-pequeno" onclick="modificarCantidad('${it.producto.id}', -1)">−</button>

                                                            <input type="number" 
                                                                   id="cant-${it.producto.id}" 
                                                                   name="cantidad" 
                                                                   value="${it.cantidad}" 
                                                                   class="cantidad-input" 
                                                                   style="width: 45px; text-align: center;" 
                                                                   min="1" 
                                                                   max="${it.producto.stock}" 
                                                                   readonly>

                                                            <button type="button" class="btn-cantidad-pequeno" onclick="modificarCantidad('${it.producto.id}', 1)">+</button>
                                                        </form>
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
                                            <td colspan="5" style="text-align: center; padding: 20px;">Tu carrito está vacío.</td>
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
                                    <span class="total-monto">$${totalAcumulado == 0 ? '0.00' : totalAcumulado}</span>
                                </div>
                                <button class="btn-pagar" onclick="window.location.href = '${pageContext.request.contextPath}/views/procesoCompra.jsp'" ${totalAcumulado == 0 ? 'disabled' : ''}>
                                    Pagar ahora
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>

        <footer class="pie-pagina">
            <p>Aplicaciones Web</p>
        </footer>
        <script>
            function modificarCantidad(id, cambio) {
                const input = document.getElementById('cant-' + id);
                const form = document.getElementById('form-' + id);
                let valor = parseInt(input.value);
                const maximo = parseInt(input.max);

                valor += cambio;

                if (valor >= 1 && valor <= maximo) {
                    input.value = valor;
                    form.submit();
                } else if (valor > maximo) {
                    alert("Stock máximo alcanzado (" + maximo + " unidades)");
                }
            }
        </script>
    </body>
</html>