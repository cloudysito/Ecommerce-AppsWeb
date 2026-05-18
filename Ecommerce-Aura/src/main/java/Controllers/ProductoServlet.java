package controllers;

import BOs.ProductoBO;
import BOs.interfaces.IProductoBO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import modelo.Producto;
import org.bson.types.ObjectId;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@WebServlet(name = "ProductoServlet", urlPatterns = {"/ProductoServlet"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 1024 * 1024 * 5, maxRequestSize = 1024 * 1024 * 10)
public class ProductoServlet extends HttpServlet {

    private IProductoBO productoBO;
    private static final String UPLOAD_DIR = "uploads";

    @Override
    public void init() throws ServletException {
        this.productoBO = new ProductoBO();
        crearProductosDePrueba();
    }

    private void crearProductosDePrueba() {
        try {

            List<Producto> productosExistentes = productoBO.listarProductos();
            if (productosExistentes.isEmpty()) {
                // Producto 1: Electrónica
                Producto p1 = new Producto(
                        "Laptop Gaming Pro 15\"",
                        1299.99,
                        "Laptop de alto rendimiento con procesador Intel i7, 16GB RAM, RTX 3060, SSD 512GB. Ideal para gaming y diseño.",
                        "",
                        15,
                        "Electrónica",
                        Arrays.asList("Procesador Intel i7-12700H", "16GB RAM", "RTX 3060", "SSD 512GB")
                );
                productoBO.registrarProducto(p1);

                // Producto 2: Electrónica
                Producto p2 = new Producto(
                        "Auriculares Inalámbricos Noise Cancelling",
                        249.99,
                        "Auriculares premium con cancelación activa de ruido, 30 horas de batería, Bluetooth 5.0.",
                        "audifonos.png",
                        45,
                        "Electrónica",
                        Arrays.asList("Conectividad Bluetooth 5.0", "Cancelación activa de ruido (ANC)", "Micrófono integrado para llamadas", "Carga rápida vía USB-C")
                );
                productoBO.registrarProducto(p2);

                // Producto 3: Muebles
                Producto p3 = new Producto(
                        "Silla Ergonómica de Oficina",
                        189.50,
                        "Silla ergonómica con soporte lumbar, reposabrazas ajustables, respaldo reclinable hasta 135°.",
                        "",
                        22,
                        "Muebles",
                        Arrays.asList("Soporte lumbar ajustable", "Malla transpirable", "Reposabrazos 3D", "Respaldo reclinable 135°", "Base de acero reforzado")
                );
                productoBO.registrarProducto(p3);

                // Producto 4: Electrónica
                Producto p4 = new Producto(
                        "Smartwatch Pro Series",
                        1000.00,
                        "Reloj inteligente con sensores de salud avanzados.",
                        "reloj.png",
                        8,
                        "Electrónica",
                        Arrays.asList("Pantalla AMOLED 1.4\"", "GPS Integrado", "Sensor de oxígeno en sangre", "Resistente al agua 5ATM", "Batería de 10 días")
                );
                productoBO.registrarProducto(p4);

                // Producto 5: Ropa
                Producto p5 = new Producto(
                        "Zapatillas Deportivas Running Pro",
                        89.99,
                        "Zapatillas ligeras para running, suela con tecnología de amortiguación, material transpirable.",
                        "",
                        60,
                        "Ropa",
                        Arrays.asList("Suela con amortiguación React", "Tejido Flyknit transpirable", "Peso ligero (250g)", "Refuerzo en talón", "Tracción multisuperficie")
                );
                productoBO.registrarProducto(p5);

                // Producto 6: Electrónica
                Producto p6 = new Producto(
                        "Teclado Mecánico RGB Gaming",
                        129.99,
                        "Teclado mecánico con switches blue, retroiluminación RGB personalizable, reposamuñecas extraíble.",
                        "",
                        35,
                        "Electrónica",
                        Arrays.asList("Switches mecánicos Blue", "Iluminación RGB Chroma", "Layout en Español", "Anti-ghosting total", "Cable trenzado removible")
                );
                productoBO.registrarProducto(p6);

                // Producto 7: Hogar
                Producto p7 = new Producto(
                        "Escritorio Minimalista de Madera",
                        279.00,
                        "Escritorio moderno de madera maciza, 140x60cm, con organizador de cables integrado.",
                        "",
                        12,
                        "Muebles",
                        Arrays.asList("Madera de roble natural", "Estructura metálica industrial", "Medidas 140x60cm", "Organizador de cables", "Fácil montaje")
                );
                productoBO.registrarProducto(p7);

                // Producto 8: Electrónica
                Producto p8 = new Producto(
                        "Mouse Inalámbrico Ergonómico",
                        45.99,
                        "Mouse ergonómico inalámbrico, 6 botones programables, batería recargable, 3200 DPI.",
                        "",
                        80,
                        "Electrónica",
                        Arrays.asList("Resolución 3200 DPI ajustable", "Conexión 2.4GHz + Bluetooth", "6 botones programables", "Batería recargable", "Diseño vertical ergonómico")
                );
                productoBO.registrarProducto(p8);

                System.out.println(" Productos de prueba creados correctamente");
            } else {
                System.out.println("️ Ya existen productos en la base de datos");
            }
        } catch (Exception e) {
            System.err.println("Error al crear productos de prueba: " + e.getMessage());
        }
    }

    @Override
protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    String accion = request.getParameter("accion");

    if ("detalles".equals(accion)) {
        try {
            String idStr = request.getParameter("id");
            if (idStr != null && !idStr.isEmpty()) {
                org.bson.types.ObjectId id = new org.bson.types.ObjectId(idStr);
                
                Producto producto = productoBO.buscarProductoPorId(id);
                request.setAttribute("producto", producto);
                request.getRequestDispatcher("views/detallesProducto.jsp").forward(request, response);
            }
        } catch (Exception e) {
            response.sendRedirect("ProductoServlet"); 
        }
    } 

        else {
            String nombre = request.getParameter("nombreBusqueda");
            String categoria = request.getParameter("categoria");
            String tipoPrecio = request.getParameter("tipoPrecio");
            String precioStr = request.getParameter("precioFiltro");

            Double precio = (precioStr != null && !precioStr.isEmpty()) ? Double.parseDouble(precioStr) : null;

            List<Producto> lista = productoBO.listarProductosFiltrados(nombre, categoria, tipoPrecio, precio);

            request.setAttribute("productos", lista);
            String adminParam = request.getParameter("admin");
            if (adminParam != null && ("1".equals(adminParam) || "true".equalsIgnoreCase(adminParam))) {
                request.getRequestDispatcher("/views/gestionCatalogo.jsp").forward(request, response);
            } else {
                request.getRequestDispatcher("/views/catalogo.jsp").forward(request, response);
            }
        }
}

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String accion = request.getParameter("accion");

        if ("actualizar".equals(accion)) {
            // Actualizar producto existente
            String id = request.getParameter("id");
            String nombre = request.getParameter("nombre");
            String precioStr = request.getParameter("precio");
            String descripcion = request.getParameter("descripcion");
            String stockStr = request.getParameter("stock");
            String categoria = request.getParameter("categoria");
            String imagenActual = request.getParameter("imagenActual");
            List<String> caracteristicas = new ArrayList<>();

            double precio = (precioStr != null) ? Double.parseDouble(precioStr) : 0;
            int stock = (stockStr != null) ? Integer.parseInt(stockStr) : 0;

            Part filePart = request.getPart("imagenProducto");
            String fileName = filePart.getSubmittedFileName();
            String rutaFinalImagen = imagenActual; // Mantener imagen actual por defecto

            // Solo actualizar imagen si se seleccionó una nueva
            if (fileName != null && !fileName.isEmpty()) {
                String applicationPath = request.getServletContext().getRealPath("");
                String uploadFilePath = applicationPath + File.separator + UPLOAD_DIR;

                File uploadDir = new File(uploadFilePath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }

                filePart.write(uploadFilePath + File.separator + fileName);
                rutaFinalImagen = UPLOAD_DIR + "/" + fileName;
            }

            Producto producto = new Producto(nombre, precio, descripcion, rutaFinalImagen, stock, categoria, caracteristicas);
            producto.setId(new ObjectId(id));
            productoBO.actualizarProducto(producto);

            response.sendRedirect("ProductoServlet?accion=listar");
        } else {
            // Crear nuevo producto
            String nombre = request.getParameter("nombre");
            String precioStr = request.getParameter("precio");
            String descripcion = request.getParameter("descripcion");
            String stockStr = request.getParameter("stock");
            String categoria = request.getParameter("categoria");
            List<String> caracteristicas = new ArrayList<>();

            double precio = (precioStr != null) ? Double.parseDouble(precioStr) : 0;
            int stock = (stockStr != null) ? Integer.parseInt(stockStr) : 0;

            Part filePart = request.getPart("imagenProducto");
            String fileName = filePart.getSubmittedFileName();
            String rutaFinalImagen = "";

            if (fileName != null && !fileName.isEmpty()) {
                String applicationPath = request.getServletContext().getRealPath("");
                String uploadFilePath = applicationPath + File.separator + UPLOAD_DIR;

                File uploadDir = new File(uploadFilePath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }

                filePart.write(uploadFilePath + File.separator + fileName);
                rutaFinalImagen = UPLOAD_DIR + "/" + fileName;
            }
            Producto nuevo = new Producto(nombre, precio, descripcion, rutaFinalImagen, stock, categoria, caracteristicas);
            productoBO.registrarProducto(nuevo);
            response.sendRedirect("ProductoServlet?accion=listar");
        }
    }
}
