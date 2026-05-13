
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Confirmación de Compra</title>
    <link rel="stylesheet" type="text/css" href="../assets/cssCliente/common.css">
    <link rel="stylesheet" type="text/css" href="../assets/cssCliente/header-footer.css">
    <link rel="stylesheet" type="text/css" href="../assets/cssCliente/confirmacionCompra.css">
</head>

<body>
    <header class="barra-superior">
        <div class="header-left">
            <img src="../imgs/logo.png" alt="Logo" class="logo-img">
            <span class="logo-text">Ecommerce</span>
        </div>
        <div class="header-right">
            <a href="#perfil" class="icon" title="Perfil"><img src="../imgs/perfil.png" alt="Perfil"></a>
            <a href="#cerrar-sesion" class="icon" title="Cerrar sesión"><img src="../imgs/salir.png" alt="Cerrar sesión"></a>
        </div>
    </header>

   <div class="container"> <jsp:include page="menuLateralCliente.jsp" />

        <main class="contenido">
            <div class="confirmacion-wrapper">
                <div class="confirmacion-container">
                    <div class="confirmacion-icono">
                        <img src="../imgs/palomita.png" alt="Confirmación" class="icono-confirmacion">
                    </div>
                    
                    <h1>Orden Confirmada</h1>
                    <p class="confirmacion-mensaje">¡Gracias por tu compra! Hemos recibido tu pedido y lo estamos preparando para el envío.</p>
                    
                    <div class="confirmacion-detalles">
                        <div class="detalle-item">
                            <label class="detalle-label">Número de Pedido</label>
                            <p class="detalle-valor">#ORD-987654321</p>
                        </div>
                        
                        <div class="detalle-item">
                            <label class="detalle-label">Fecha de Compra</label>
                            <p class="detalle-valor">26 de Octubre, 2023</p>
                        </div>
                        
                        <div class="detalle-item">
                            <label class="detalle-label">Dirección de Envío</label>
                            <p class="detalle-valor">
                                Juan Pérez<br>
                                123 Avenida Universidad, Apt 4B<br>
                                Ciudad Universitaria, ST 12345
                            </p>
                        </div>
                        
                        <div class="detalle-item">
                            <label class="detalle-label">Costo Total</label>
                            <p class="detalle-valor total">$398.39</p>
                        </div>
                    </div>
                    
                    <a href="#inicio" class="btn-volver">Volver al Inicio</a>
                </div>
            </div>
        </main>
    </div>
</body>

</html>
