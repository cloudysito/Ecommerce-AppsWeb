<%@page import="modelo.Producto"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Crear Reseña</title>
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/cssCliente/common.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/cssCliente/header-footer.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/cssCliente/crearResena.css">
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
                <div class="resena-container">
                    <h1>Crear Reseña</h1>
                    <p class="subtitulo">Comparte tu experiencia con este producto para ayudar a otros.</p>

                    <form action="${pageContext.request.contextPath}/ResenaServlet" method="POST">
                        <input type="hidden" name="accion" value="crear">
                        <input type="hidden" name="productoId" value="${param.productoId}">

                        <section class="producto-resena">
                            <h2>Producto a Reseñar</h2>
                            <div class="producto-info">
                                <div class="producto-detalles">
                                    <h3>${param.nombreProducto}</h3>
                                </div>
                            </div>
                        </section>

                        <section class="calificacion-general">
                            <h2>Calificación General</h2>
                            <div class="puntuacion-container">
                                <label for="puntuacion">Puntuación Numérica (1-5)</label>
                                <div class="escala-puntuacion">
                                    <span class="label-escala">Deficiente</span>
                                    <input type="range" id="puntuacion" name="puntuacion" min="1" max="5" value="4" class="slider">
                                    <span class="label-escala">Excelente</span>
                                    <span class="valor-puntuacion" id="valor-puntuacion">4</span>
                                </div>
                            </div>
                        </section>

                        <section class="experiencia">
                            <h2>Tu Experiencia</h2>
                            <textarea id="experiencia" name="comentario"
                                      placeholder="¿Qué te gustó o disgustó? ¿Cómo utilizaste el producto?"
                                      rows="8" required></textarea>
                        </section>

                        <div class="botones-accion">
                            <button type="button" class="boton-cancelar" onclick="history.back()">Cancelar</button>
                            <button type="submit" class="boton-enviar">Enviar reseña</button>
                        </div>
                    </form>
                </div>
            </main>
        </div>

        <footer class="pie-pagina">
            <p>Aplicaciones Web</p>
        </footer>
        <script>
            const slider = document.getElementById('puntuacion');
            const valorPuntuacion = document.getElementById('valor-puntuacion');
            slider.addEventListener('input', function () {
                valorPuntuacion.textContent = this.value;
            });
        </script>
    </body>

</html>

