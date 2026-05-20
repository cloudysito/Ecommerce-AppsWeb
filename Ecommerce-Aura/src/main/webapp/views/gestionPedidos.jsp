
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Gestión de Pedidos</title>
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/cssCliente/common.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/cssCliente/header-footer.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/cssCliente/gestionPedidos.css">
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
                <div class="pedidos-wrapper">
                    <h1>Gestión de Pedidos</h1>

                    <div class="tabla-pedidos-container">
                        <table class="tabla-pedidos">
                            <thead>
                                <tr>
                                    <th>N° DE PEDIDO</th>
                                    <th>FECHA</th>
                                    <th>TOTAL PAGADO</th>
                                    <th>ESTADO</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>
                                        <div class="celda-pedido">
                                            <img src="${pageContext.request.contextPath}/imgs/ticket.png" alt="Pedido" class="icono-pedido">
                                            <span>#ORD-1001</span>
                                        </div>
                                    </td>
                                    <td>26 Oct, 2023</td>
                                    <td>$125.00</td>
                                    <td><span class="estado-pedido estado-pendiente">Pendiente</span></td>
                                </tr>
                                <tr>
                                    <td>
                                        <div class="celda-pedido">
                                            <img src="${pageContext.request.contextPath}/imgs/ticket.png" alt="Pedido" class="icono-pedido">
                                            <span>#ORD-1002</span>
                                        </div>
                                    </td>
                                    <td>25 Oct, 2023</td>
                                    <td>$45.50</td>
                                    <td><span class="estado-pedido estado-enviado">Enviado</span></td>
                                </tr>
                                <tr>
                                    <td>
                                        <div class="celda-pedido">
                                            <img src="${pageContext.request.contextPath}/imgs/ticket.png" alt="Pedido" class="icono-pedido">
                                            <span>#ORD-1003</span>
                                        </div>
                                    </td>
                                    <td>20 Oct, 2023</td>
                                    <td>$320.00</td>
                                    <td><span class="estado-pedido estado-entregado">Entregado</span></td>
                                </tr>
                                <tr>
                                    <td>
                                        <div class="celda-pedido">
                                            <img src="${pageContext.request.contextPath}/imgs/ticket.png" alt="Pedido" class="icono-pedido">
                                            <span>#ORD-1004</span>
                                        </div>
                                    </td>
                                    <td>19 Oct, 2023</td>
                                    <td>$89.99</td>
                                    <td><span class="estado-pedido estado-entregado">Entregado</span></td>
                                </tr>
                                <tr>
                                    <td>
                                        <div class="celda-pedido">
                                            <img src="${pageContext.request.contextPath}/imgs/ticket.png" alt="Pedido" class="icono-pedido">
                                            <span>#ORD-1005</span>
                                        </div>
                                    </td>
                                    <td>18 Oct, 2023</td>
                                    <td>$210.50</td>
                                    <td><span class="estado-pedido estado-pendiente">Pendiente</span></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </main>
        </div>
        </body>

</html>
