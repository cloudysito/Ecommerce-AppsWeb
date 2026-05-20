<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Gestión de Categorías - Admin</title>
        
        <base href="${pageContext.request.contextPath}/">

        <link rel="stylesheet" type="text/css" href="assets/cssAdmin/common.css">
        <link rel="stylesheet" type="text/css" href="assets/cssAdmin/header-footer.css">
        <link rel="stylesheet" type="text/css" href="assets/cssAdmin/gestionCatalogo.css">
        <link rel="stylesheet" type="text/css" href="assets/cssAdmin/gestionCategoriasAdmin.css">
        
        <style>
            .form-crear {
                padding: 20px; 
                border-radius: 8px; 
                margin-bottom: 25px; 
                border: 1px solid var(--border-color, #444);
                background-color: transparent; 
            }
            .form-crear input, .form-crear textarea {
                width: 100%; 
                padding: 10px; 
                margin-top: 5px; 
                border: 1px solid var(--border-color, #666); 
                border-radius: 4px;
                background-color: var(--bg-color, transparent);
                color: var(--text-color, inherit);
            }
            .btn-accion-form {
                color: white; 
                border: none; 
                padding: 10px 15px; 
                border-radius: 4px; 
                cursor: pointer; 
                font-weight: bold;
            }
            .btn-cancelar {
                color: var(--text-color, #ccc); 
                text-decoration: none; 
                border: 1px solid var(--border-color, #666); 
                padding: 9px 15px; 
                border-radius: 4px;
            }
        </style>
    </head>

    <body>
        <header class="barra-superior">
            <div class="header-left">
                <img src="imgs/logo.png" alt="Logo" class="logo-img">
                <span class="logo-text">Ecommerce</span>
            </div>
            <div class="header-right">
                <a href="views/perfilUsuario.jsp" class="icon" title="Perfil"><img src="imgs/perfil.png" alt="Perfil"></a>
                <a href="UsuarioServlet?accion=logout" class="icon" title="Cerrar sesión"><img src="imgs/salir.png" alt="Cerrar sesión"></a>
            </div>
        </header>

        <div class="container">
            <jsp:include page="menuLateralAdmin.jsp" />

            <main class="contenido">
                <div class="catalogo-wrapper">
                    <h1>Gestión de Categorías de Productos</h1>

                    <c:if test="${not empty error}">
                        <div class="alerta-categoria-error" style="color: white; background: #e74c3c; padding: 10px; margin-bottom: 15px; border-radius: 4px; text-align: center;">
                            ${error}
                        </div>
                    </c:if>

                    <div class="form-crear">
                        <c:choose>
                            <c:when test="${not empty categoriaEditar}">
                                <h3>Editar Categoría</h3>
                                <form action="CategoriaServlet" method="POST">
                                    <input type="hidden" name="accion" value="actualizar" />
                                    <input type="hidden" name="id" value="${categoriaEditar.id}" />

                                    <div class="form-group" style="margin-bottom: 15px;">
                                        <label for="nombre">Nombre de la Categoría:</label>
                                        <input type="text" id="nombre" name="nombre" required placeholder="Ej. Electrónica, Ropa, etc." value="${categoriaEditar.nombre}" />
                                    </div>

                                    <div class="form-group" style="margin-bottom: 15px;">
                                        <label for="descripcion">Descripción:</label>
                                        <textarea id="descripcion" name="descripcion" rows="3" placeholder="Breve descripción...">${categoriaEditar.descripcion}</textarea>
                                    </div>

                                    <div style="display: flex; gap: 10px; align-items: center;">
                                        <button type="submit" class="btn-accion-form" style="background-color: #f39c12;">Actualizar Categoría</button>
                                        <a href="CategoriaServlet?accion=listarAdmin" class="btn-cancelar">Cancelar edición</a>
                                    </div>
                                </form>
                            </c:when>
                            <c:otherwise>
                                <h3>➕ Agregar Nueva Categoría</h3>
                                <form action="CategoriaServlet" method="POST">
                                    <input type="hidden" name="accion" value="crear" />

                                    <div class="form-group" style="margin-bottom: 15px;">
                                        <label for="nombre">Nombre de la Categoría:</label>
                                        <input type="text" id="nombre" name="nombre" required placeholder="Ej. Electrónica, Ropa, etc." />
                                    </div>

                                    <div class="form-group" style="margin-bottom: 15px;">
                                        <label for="descripcion">Descripción:</label>
                                        <textarea id="descripcion" name="descripcion" rows="3" placeholder="Breve descripción del tipo de productos..."></textarea>
                                    </div>

                                    <button type="submit" class="btn-accion-form" style="background-color: #2ecc71;">Guardar Categoría</button>
                                </form>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <div class="tabla-container">
                        <table class="tabla-catalogo">
                            <thead>
                                <tr>
                                    <th>ID (MongoDB)</th>
                                    <th>Nombre</th>
                                    <th>Descripción</th>
                                    <th style="text-align: center;">Acciones</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:choose>
                                    <c:when test="${not empty categoriasRegistradas}">
                                        <c:forEach var="cat" items="${categoriasRegistradas}">
                                            <tr>
                                                <td style="font-family: monospace; font-size: 0.9em; opacity: 0.8;">${cat.id}</td>
                                                <td style="font-weight: bold;">${cat.nombre}</td>
                                                <td>${cat.descripcion}</td>
                                                <td>
                                                    <div style="display: flex; justify-content: center; align-items: center; gap: 15px;">
                                                        <c:if test="${not empty cat.id}">
                                                            <form action="CategoriaServlet" method="GET" style="margin: 0;">
                                                                <input type="hidden" name="accion" value="cargarEditar" />
                                                                <input type="hidden" name="id" value="${cat.id}" />
                                                                <button type="submit" title="Modificar Categoría" style="background: none; border: none; cursor: pointer; font-size: 1.3em;">
                                                                    ✏️
                                                                </button>
                                                            </form>
                                                            
                                                            <form action="CategoriaServlet" method="POST" style="margin: 0;" onsubmit="return confirm('¿Seguro que deseas eliminar la categoría: ${cat.nombre}?');">
                                                                <input type="hidden" name="accion" value="eliminar" />
                                                                <input type="hidden" name="id" value="${cat.id}" />
                                                                <button type="submit" title="Eliminar Categoría" style="background: none; border: none; cursor: pointer;">
                                                                    <img src="imgs/basura.png" alt="Eliminar" style="width: 22px; height: 22px;">
                                                                </button>
                                                            </form>
                                                        </c:if>
                                                    </div>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <tr>
                                            <td colspan="4" style="text-align: center; padding: 30px; opacity: 0.7;">No hay categorías registradas en la base de datos.</td>
                                        </tr>
                                    </c:otherwise>
                                </c:choose>
                            </tbody>
                        </table>
                    </div>
                </div>
            </main>
        </div>

        <footer class="pie-pagina">
            <p>Aplicaciones Web</p>
        </footer>
        </body>
</html>