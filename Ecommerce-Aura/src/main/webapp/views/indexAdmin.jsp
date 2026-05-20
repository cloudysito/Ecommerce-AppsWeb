<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Panel de Administrador</title>
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/cssAdmin/common.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/cssAdmin/header-footer.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/cssAdmin/indexAdmin.css">
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
            <jsp:include page="menuLateralAdmin.jsp" />

            <main class="contenido">
                <h1>Panel de Administrador</h1>
                <p class="subtitulo">Gestión centralizada de la plataforma</p>

                <section class="admin-description">
                    <h2>¿Qué puede hacer el administrador?</h2>
                    <p>
                        Desde este panel puedes gestionar usuarios, productos, pedidos y reseñas.
                        También puedes consultar información, actualizar datos, eliminar registros y
                        mantener controlada la actividad general de la tienda.
                    </p>
                    <ul>
                        <li>Administrar cuentas de usuario.</li>
                        <li>Crear, editar y eliminar productos.</li>
                        <li>Revisar y actualizar pedidos.</li>
                        <li>Moderar reseñas y valoraciones.</li>
                    </ul>
                </section>
            </main>
        </div>
        <footer class="pie-pagina">
            <p>Aplicaciones Web</p>
        </footer>
        </body>
</html>