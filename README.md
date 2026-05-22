# Ecommerce Aura - Proyecto de Aplicaciones Web

Plataforma de comercio electrónico desarrollada como proyecto final para la asignatura de Aplicaciones Web. Este sistema permite a los usuarios gestionar sus cuentas, navegar por un catálogo de productos, realizar compras seguras con métodos de pago simulados y gestionar pedidos.

## 👥 Integrantes del Equipo
* **Nombre:** Emiliano Márquez Esquer 
* **Nombre:** Maria José Enriquez Lara

**Temática de la tienda:** Ecommerce 

---

## 🚀 Características Principales (Requerimientos Funcionales)

### 1. Gestión de Usuarios
* Registro, Inicio y Cierre de sesión.
* Autenticación basada en **JWT** (Stateless).
* Edición de perfil y roles diferenciados (Cliente / Administrador).
* Gestión de usuarios (activar/desactivar) desde panel admin.

### 2. Catálogo de Productos
* Visualización, búsqueda y filtrado por categoría, nombre y precio.
* Ficha técnica detallada con reseñas.
* Panel de administración para CRUD completo de productos y categorías.

### 3. Carrito de Compras
* Persistencia en base de datos (MongoDB).
* Actualización dinámica de totales y cantidades.
* Carrito asociado a la sesión del usuario.

### 4. Proceso de Compra y Pagos
* Checkout con dirección de envío y métodos de pago simulados (Tarjeta, Transferencia, Contra entrega).
* Generación de **folio único** de pedido.
* Notificación automática por correo electrónico.

### 5. Gestión de Pedidos y Reseñas
* Historial de pedidos con estados (Pendiente, Enviado, Entregado).
* Sistema de reseñas y calificaciones.

---

## 🛠️ Tecnologías Utilizadas

### Frontend
* **HTML5:** Estructura semántica.
* **CSS3:** Diseño responsivo (Flexbox y CSS Grid).
* **JavaScript:** Manejo del DOM, Fetch API y funciones asíncronas (async/await).

### Backend
* **Java (Jakarta EE):** Servlets, JSP, Filtros.
* **Autenticación:** JSON Web Tokens (JWT).
* **Base de Datos:** MongoDB.
* **Gestión de Dependencias:** Maven (`pom.xml`).

---

## ⚙️ Instrucciones de Ejecución

1. **Requisitos previos:**
   - JDK 17+ (o superior).
   - Apache Tomcat 10.1+.
   - MongoDB instalado y corriendo.

2. **Configuración:**
   - Importa el proyecto como un proyecto Maven en tu IDE (NetBeans/IntelliJ).
   - Asegúrate de tener configurada tu conexión a MongoDB en `MongoConfig.java`.
   - [Opcional] Configura las variables de entorno para el servicio de correo (SMTP).

3. **Ejecución:**
   - Realiza un `Clean and Build` del proyecto.
   - Despliega en tu servidor Tomcat.
   - Accede a `http://localhost:8080/Ecommerce-Aura/views/index.jsp`.

---

## 📝 Documentación
Este proyecto ha sido versionado utilizando **Git**.

---
*Desarrollado para la materia de Aplicaciones Web - Plan 2023.*
