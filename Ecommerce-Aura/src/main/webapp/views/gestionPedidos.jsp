<%@page import="modelo.Pedido"%>
<%@ page import="java.util.List" %>
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
                                <%
                                    List<Pedido> misPedidos = (List<Pedido>) request.getAttribute("misPedidos");
                                    if (misPedidos != null && !misPedidos.isEmpty()) {
                                        for (Pedido pedido : misPedidos) {
                                            String estadoClass = "";
                                            String estadoTexto = pedido.getEstado();
                                            if ("Pendiente".equalsIgnoreCase(estadoTexto))
                                                estadoClass = "estado-pendiente";
                                            else if ("Enviado".equalsIgnoreCase(estadoTexto))
                                                estadoClass = "estado-enviado";
                                            else if ("Entregado".equalsIgnoreCase(estadoTexto))
                                                estadoClass = "estado-entregado";
                                            else if ("Cancelado".equalsIgnoreCase(estadoTexto))
                                                estadoClass = "estado-cancelado";
                                %>
                                <tr>
                                    <td>
                                        <div class="celda-pedido">
                                            <img src="${pageContext.request.contextPath}/imgs/ticket.png" alt="Pedido" class="icono-pedido">
                                            <span>#<%= pedido.getId().toString().substring(0, 14) %>...</span>
                                        </div>
                                    </td>
                                    <td><%= pedido.getFecha()%></td>
                                    <td>$<%= String.format("%.2f", pedido.getTotal())%></td>
                                    <td><span class="estado-pedido <%= estadoClass%>"><%= estadoTexto%></span></td>
                                </tr>
                                <%  }
                                    } else { %>
                                <tr>
                                    <td colspan="4" style="text-align: center; padding: 20px;">No tienes pedidos registrados</td>
                                </tr>
                                <% }%>
                            </tbody>
                        </table>
                    </div>
                </div>
            </main>
        </div>
        </body>

</html>
