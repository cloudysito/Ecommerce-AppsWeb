<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Catálogo de Productos</title>
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/cssCliente/common.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/cssCliente/header-footer.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/cssCliente/catalogo.css">
    </head>

    <body>
        <header class="barra-superior">
            <div class="header-left">
                <img src="${pageContext.request.contextPath}/imgs/logo.png" alt="Logo" class="logo-img">
                <span class="logo-text">Ecommerce</span>
            </div>
            <div class="header-right">
                <a href="${pageContext.request.contextPath}/views/perfilUsuario.jsp" class="icon">
                    <img src="${pageContext.request.contextPath}/imgs/perfil.png" alt="Perfil">
                </a>

                <button id="theme-toggle" class="theme-toggle" title="Cambiar tema" aria-label="Cambiar tema">🌙</button>

                <a href="${pageContext.request.contextPath}/UsuarioServlet?accion=logout" class="icon" title="Cerrar sesión">
                    <img src="${pageContext.request.contextPath}/imgs/salir.png" alt="Cerrar sesión">
                </a>
            </div>
        </header>

        <div class="container"> <jsp:include page="menuLateralCliente.jsp" />

            <main class="contenido">
                <div class="catalogo-wrapper">
                    <h1 class="titulo-izq">Catálogo</h1>

                    <div class="filtros-container">
                        <h2>Filtrar Productos</h2>

                        <form action="${pageContext.request.contextPath}/ProductoServlet" method="GET">
                            <div class="filtros-grid">
                                <div class="grupo-filtro">
                                    <label>Nombre del producto</label>
                                    <div class="input-con-icono">
                                        <span>🔍</span>
                                        <input type="text" name="nombreBusqueda" placeholder="Buscar..." value="${param.nombreBusqueda}">
                                    </div>
                                </div>

                                <div class="grupo-filtro">
                                    <label for="categoria">Categoría:</label>
                                    <select name="categoria" id="categoria" class="form-control">
                                        <option value="" ${empty param.categoria ? 'selected' : ''}>Todas</option>
                                        <option value="Electrónica" ${param.categoria == 'Electrónica' ? 'selected' : ''}>Electrónica</option>
                                        <option value="Ropa" ${param.categoria == 'Ropa' ? 'selected' : ''}>Ropa</option>
                                        <option value="Hogar" ${param.categoria == 'Hogar' ? 'selected' : ''}>Hogar</option>
                                        <option value="Accesorios" ${param.categoria == 'Accesorios' ? 'selected' : ''}>Accesorios</option>
                                    </select>

                                    <label>Rango de precio</label>
                                    <div class="controles-precio">
                                        <label class="radio-label">
                                            <input type="radio" name="tipoPrecio" value="menor" ${param.tipoPrecio == 'menor' ? 'checked' : ''}> Menor que
                                        </label>
                                        <label class="radio-label">
                                            <input type="radio" name="tipoPrecio" value="mayor" ${param.tipoPrecio == 'mayor' ? 'checked' : ''}> Mayor que
                                        </label>
                                        <div class="input-con-icono-izq">
                                            <span>$</span>
                                            <input type="text" name="precioFiltro" placeholder="00.00" class="input-corto" value="${param.precioFiltro}">
                                        </div>
                                        <button type="submit" class="btn-aplicar">Aplicar Filtro</button>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>

                    <div class="tabla-pedidos-container"> 
                        <table class="tabla-pedidos tabla-catalogo">
                            <thead>
                                <tr>
                                    <th>IMAGEN</th>
                                    <th>NOMBRE</th>
                                    <th>PRECIO</th>
                                    <th>DISPONIBILIDAD</th>
                                    <th>DETALLES</th>
                                    <th>ACCIONES</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="p" items="${productos}">
                                    <tr>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty p.imagenProducto}">
                                                    <img src="${pageContext.request.contextPath}/imgs/${p.imagenProducto}" alt="Producto" class="img-catalogo">
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="img-placeholder" style="background-color: #4a5568;">📦</div>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td><span class="fw-bold">${p.nombre}</span></td>
                                        <td>$${p.precio}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${p.stock > 0}">
                                                    <span style="background-color: #10b981; color: white; padding: 4px 10px; border-radius: 20px; font-size: 0.85em; font-weight: bold;">En stock (${p.stock})</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span style="background-color: #ef4444; color: white; padding: 4px 10px; border-radius: 20px; font-size: 0.85em; font-weight: bold;">Agotado</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td><a href="${pageContext.request.contextPath}/ProductoServlet?accion=detalles&id=${p.id}" class="link-detalles">👁 Detalles</a></td>
                                        <td>
                                            <div class="acciones-catalogo">
                                                <c:choose>
                                                    <c:when test="${not empty sessionScope.usuarioActivo}">
                                                        <form action="${pageContext.request.contextPath}/CarritoServlet" method="POST" style="display:inline">
                                                            <input type="hidden" name="accion" value="agregar">
                                                            <input type="hidden" name="id" value="${p.id}">
                                                            <button class="btn-agregar" type="submit">Agregar al carrito</button>
                                                        </form>
                                                            <button class="btn-resenas" onclick="window.location.href = '${pageContext.request.contextPath}/views/crearReseña.jsp?id=${p.id}'">Dejar reseña</button>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <a href="${pageContext.request.contextPath}/views/login.jsp" class="btn-bloqueado" style="text-decoration: none; text-align: center; display: inline-block;"> 
                                                            Inicia sesion para comprar
                                                        </a>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
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