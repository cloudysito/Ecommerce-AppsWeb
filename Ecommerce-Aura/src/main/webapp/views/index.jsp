

<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Proyecto ECommerce</title>
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/cssCliente/common.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/cssCliente/header-footer.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/cssCliente/home.css">
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@700;800&display=swap" rel="stylesheet">
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
                <section class="productos-destacados">
                    <div class="productos-grid">

                        <div class="producto">
                            <h3 class="titulo-principal">Proyecto ECommerce</h3>

                            <div class="texto-desarrollo">
                                <h3> Equipo de Desarrollo</h3>
                            </div>

                            <div class="equipo-desarrollo">

                                <div class="tarjeta-desarrollador">
                                    <div class="icono-dev">
                                        <span>&lt;&gt;</span>
                                    </div>
                                    <div class="info-dev">
                                        <p class="nombre-dev">Maria Jose Enriquez Lara</p>
                                        <p class="id-dev">ID: 00000252337</p>
                                    </div>
                                </div>

                                <div class="tarjeta-desarrollador">
                                    <div class="icono-dev">
                                        <span>&lt;&gt;</span>
                                    </div>
                                    <div class="info-dev">
                                        <p class="nombre-dev">Emiliano Marquez Esquer</p>
                                        <p class="id-dev">ID: 00000252714</p>
                                    </div>
                                </div>

                                <div class="info-proyecto">
                                    <h3>&#8505; Sobre este proyecto</h3>
                                    <p>Esta aplicación web implementa la estructura básica solicitada, incluyendo navegación consistente, manejo de modos claro/oscuro y diseño responsivo utilizando HTML Y CSS.</p>
                                </div>

                            </div> 
                        </div>
                    </div>
                </section>
            </main>
        </div>

        <footer class="pie-pagina">
            <p>Aplicaciones Web</p>
        </footer>
        <body>

</html>

