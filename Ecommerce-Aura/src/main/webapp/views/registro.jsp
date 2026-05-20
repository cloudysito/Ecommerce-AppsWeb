<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ecommerce - Registro</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/cssCliente/common.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/cssCliente/header-footer.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/cssCliente/registro.css">
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
        <div class="contenedor-registro">
            <div class="tarjeta-registro">
                <div class="cabecera-registro">
                    <h2>Crear Cuenta</h2>
                    <p>Regístrate para comenzar a comprar lo que necesitas para la universidad.</p>
                </div>

                <c:if test="${not empty requestScope.error}">
                    <div class="error-message">
                            ${requestScope.error}
                    </div>
                </c:if>

                <form class="formulario-registro" action="${pageContext.request.contextPath}/UsuarioServlet" method="POST">
                    <input type="hidden" name="accion" value="registrar">

                    <div class="grid-formularios">
                        <div class="grupo-formulario">
                            <label for="nombre">Nombre completo</label>
                            <input type="text" id="nombre" name="nombre" placeholder="Juan Pérez" required>
                        </div>

                        <div class="grupo-formulario">
                            <label for="correo">Correo electrónico</label>
                            <input type="email" id="correo" name="correo" placeholder="juan.perez@universidad.edu" required>
                        </div>

                        <div class="grupo-formulario">
                            <label for="contrasenia">Contraseña</label>
                            <input type="password" id="contrasenia" name="contrasenia" placeholder="••••••••" required>
                        </div>

                        <div class="grupo-formulario">
                            <label for="confirmar_contrasenia">Confirmación de contraseña</label>
                            <input type="password" id="confirmar_contrasenia" name="confirmar_contrasenia" placeholder="••••••••" required>
                        </div>

                        <div class="grupo-formulario">
                            <label for="telefono">Teléfono</label>
                            <input type="text" id="telefono" name="telefono" placeholder="+1 (555) 000-0000">
                        </div>
                    </div>

                    <div class="grupo-formulario">
                        <label for="direccion">Dirección de envío</label>
                        <textarea id="direccion" rows="4" name="direccion" placeholder="Av. Universidad 123, Depto 4B, Ciudad, Estado, CP" required></textarea>
                    </div>

                    <div class="grupo-checkbox">
                        <input type="checkbox" id="terminos" required>
                        <label for="terminos">Acepto los <a href="#">Términos de Servicio</a></label>
                    </div>

                    <div class="contenedor-boton">
                        <button type="submit" class="btn-crear">Crear cuenta</button>
                    </div>
                </form>

                <div class="pie-login">
                    <p>¿Ya tienes una cuenta? <a href="${pageContext.request.contextPath}/views/login.jsp">Inicia sesión aquí</a></p>
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