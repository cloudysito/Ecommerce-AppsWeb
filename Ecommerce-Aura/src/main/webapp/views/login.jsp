<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Proyecto ECommerce</title>
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/cssCliente/common.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/cssCliente/header-footer.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/cssCliente/login.css">
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

            <main class="contenido fondo-login">
                <div class="contenedor-login">
                    <div class="tarjeta-login">

                        <div class="icono-login">
                            <span>🔒</span> 
                        </div>

                        <div class="cabecera-login">
                            <h2>Bienvenido de nuevo</h2>
                            <p>Por favor, ingrese sus credenciales para acceder a su cuenta.</p>
                        </div>

                        <form class="formulario-login" action="${pageContext.request.contextPath}/UsuarioServlet" method="POST">

                            <input type="hidden" name="accion" value="login">

                            <div class="grupo-formulario">
                                <label for="email">Correo electrónico</label>
                                <div class="input-icono">
                                    <span class="icono">✉️</span>
                                    <input type="email" id="email" name="correo" placeholder="Ingrese su correo electrónico" required>
                                </div>
                            </div>

                            <div class="grupo-formulario">
                                <label for="password">Contraseña</label>
                                <div class="input-icono">
                                    <span class="icono">🔑</span>
                                    <input type="password" id="password" name="password" placeholder="Ingrese su contraseña" required>
                                </div>
                            </div>

                            <div class="enlace-olvido">
                                <a href="#">¿Olvidó su contraseña?</a>
                            </div>

                            <button type="submit" class="btn-iniciar">Iniciar sesión</button>

                            <c:if test="${param.registro == 'exito'}">
                                <p style="color:green; text-align: center; margin-top: 10px;">Registro exitoso. Por favor inicia sesión.</p>
                            </c:if>
                            <c:if test="${not empty requestScope.error}">
                                <p style="color:red; text-align: center; margin-top: 10px;">Contraseña o usuario incorrectos.</p>
                            </c:if>
                        </form>

                        <div class="pie-login">
                            <p>¿No tiene una cuenta? <a href="${pageContext.request.contextPath}/views/registro.jsp">Regístrese aquí</a></p>
                            <button class="btn-regresar" onclick="window.location.href = '${pageContext.request.contextPath}/views/index.jsp'">
                                &larr; Regresar a inicio
                            </button>
                        </div>

                    </div>
                </div>
            </main>
        </div>

        <footer class="pie-pagina">
            <p>Aplicaciones Web</p>
        </footer>
        </body>

</html>
