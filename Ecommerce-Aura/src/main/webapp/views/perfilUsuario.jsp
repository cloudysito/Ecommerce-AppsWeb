<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Perfil de Usuario - Ecommerce</title>
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/cssCliente/common.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/cssCliente/header-footer.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/cssCliente/perfilUsuario.css">
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

            <main class="contenido pantalla-centrada">
                <div class="contenedor-perfil">
                    <div class="tarjeta-perfil">

                        <div class="cabecera-perfil">
                            <h2>Perfil de Usuario</h2>
                        </div>
                        
                        <form class="formulario-perfil" method="POST" action="${pageContext.request.contextPath}/UsuarioServlet">
                            <input type="hidden" name="accion" value="editarPerfil">

                            <div class="grupo-formulario">
                                <label for="nombre">Nombre completo</label>
                                <input type="text" id="nombre" name="nombre" value="${sessionScope.usuarioActivo.nombreCompleto}">
                            </div>

                            <div class="grupo-formulario">
                                <label for="correo">Correo electrónico</label>
                                <input type="email" id="correo" name="correo" value="${sessionScope.usuarioActivo.correo}" readonly>
                            </div>

                            <div class="grupo-formulario">
                                <label for="telefono">Teléfono</label>
                                <input type="text" id="telefono" name="telefono" value="${sessionScope.usuarioActivo.telefono}" >
                            </div>

                            <div class="grupo-formulario">
                                <label for="direccion">Dirección de envío</label>
                                <textarea id="direccion" name="direccion" rows="3" >${sessionScope.usuarioActivo.direccion}</textarea>
                            </div>

                            <div class="contenedor-boton-derecha">
                                <button type="submit" class="btn-guardar">Guardar Cambios</button>
                            </div>

                        </form>
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
