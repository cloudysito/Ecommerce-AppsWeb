<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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

                    <a href="${pageContext.request.contextPath}/ProductoServlet" class="btn-regresar-enlace">← Volver al catálogo</a>

                    <div class="producto-principal-card">
                        <div class="producto-galeria">
                            <div class="imagen-destacada">
                                <img src="${pageContext.request.contextPath}/imgs/${not empty producto.imagenProducto ? producto.imagenProducto : 'logo.png'}" alt="${producto.nombre}">
                            </div>
                        </div>

                        <div class="producto-info-detalle">
                            <span class="categoria-badge">${producto.categoria}</span>

                            <h1>${producto.nombre}</h1>

                            <div class="calificacion-estrellas">
                                <span>(Consultar reseñas abajo)</span>
                            </div>

                            <div class="precio-detalle">$${producto.precio}</div>

                            <p class="descripcion-corta">
                                ${producto.descripcion}
                            </p>

                            <div class="stock-status">
                                <span class="${producto.stock > 0 ? 'punto-verde' : 'punto-rojo'}"></span> 
                                ${producto.stock > 0 ? 'En stock (' : 'Agotado ('}${producto.stock} disponibles)
                            </div>

                            <div class="acciones-compra">
                                <c:choose>
                                    <c:when test="${not empty sessionScope.usuarioActivo}">
                                        <form id="form-agregar-carrito" style="display:inline">
                                            <input type="hidden" id="prod-id" name="id" value="${producto.id}" />

                                            <div class="grupo-cantidad">
                                                <label>Cantidad</label>
                                                <div class="cantidad-control">
                                                    <button type="button" class="btn-cantidad" onclick="cambiarCantidad(-1)">−</button>
                                                    <input type="number" id="cantidad-input" name="cantidad" value="1" min="1" max="${producto.stock}" readonly>
                                                    <button type="button" class="btn-cantidad" onclick="cambiarCantidad(1)">+</button>
                                                </div>
                                            </div>

                                            <button class="btn-agregar-grande" type="button" id="btn-add-carrito" ${producto.stock <= 0 ? 'disabled' : ''}>
                                                Agregar al carrito
                                            </button>
                                        </form>
                                    </c:when>

                                    <c:otherwise>
                                        <div class="aviso-login-detalles" style="padding: 20px; border: 2px dashed var(--color-primario); border-radius: 8px; text-align: center;">
                                            <p style="margin-bottom: 15px; font-weight: bold;">¿Quieres comprar este artículo?</p>
                                            <a href="${pageContext.request.contextPath}/views/login.jsp" class="btn-agregar-grande" style="text-decoration: none; display: block;">
                                                Inicia sesión para comprar
                                            </a>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>

                            <div class="detalles-tecnicos">
                                <h3>Características principales:</h3>
                                <ul>
                                    <c:forEach var="caracteristica" items="${producto.caracteristicas}">
                                        <li>${caracteristica}</li>
                                    </c:forEach>
                                </ul>
                            </div>
                        </div>
                    </div>

                    <div class="seccion-resenas" style="margin-top: 30px; padding: 20px; background: white; border-radius: 8px;">
                        <h3>Reseñas de clientes</h3>
                        <c:choose>
                            <c:when test="${not empty resenas}">
                                <c:forEach var="r" items="${resenas}">
                                    <div class="resena-item" style="border-bottom: 1px solid #eee; padding: 10px 0;">
                                        <strong>Calificación: ${r.calificacion}/5</strong>
                                        <p>${r.comentario}</p>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <p>Aún no hay reseñas para este producto.</p>
                            </c:otherwise>
                        </c:choose>
                    </div>

                </div>
            </main>
        </div>

        <header style="display:none;"></header>
        <footer class="pie-pagina">
            <p>Aplicaciones Web</p>
        </footer>
        
        <script src="${pageContext.request.contextPath}/assets/js/theme.js"></script>
        
        <script>
        function cambiarCantidad(valor) {
            const input = document.getElementById('cantidad-input');
            let actual = parseInt(input.value);
            const stockMaximo = parseInt(input.getAttribute('max'));

            actual += valor;
            if (actual < 1) actual = 1;

            if (actual > stockMaximo) {
                actual = stockMaximo;
                alert("Lo sentimos, solo hay " + stockMaximo + " unidades disponibles.");  
            }
            
            input.value = actual;
        }

        document.addEventListener("DOMContentLoaded", () => {
            const btnCarrito = document.getElementById("btn-add-carrito");
            
            if (btnCarrito) {
                btnCarrito.addEventListener("click", async () => {
                    const idProducto = document.getElementById("prod-id").value;
                    const cantidad = document.getElementById("cantidad-input").value;
                    const contextPath = "${pageContext.request.contextPath}";

                    const url = contextPath + "/CarritoServlet?accion=agregar&id=" + idProducto + "&cantidad=" + cantidad;

                    try {
                        const response = await fetch(url, { method: "POST" });
                        
                        if (response.ok) {
                            alert("Producto agregado al carrito exitosamente.");
                        } else {
                            alert("No se pudo añadir el artículo. Verifica los datos.");
                        }
                    } catch (error) {
                        console.error("Error en la ejecución de la promesa asíncrona: ", error);
                        alert("Error de comunicación de red al intentar añadir el artículo.");
                    }
                });
            }
        });
        </script>
    </body>

</html>