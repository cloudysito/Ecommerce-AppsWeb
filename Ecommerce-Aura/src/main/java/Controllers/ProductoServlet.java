package controllers;

import BOS.ProductoBO;
import BOS.interfaces.IProductoBO;
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

@WebServlet(name = "ProductoServlet", urlPatterns = "/ProductoServlet")
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 1024 * 5, maxRequestSize = 1024 * 1024 * 10)
public class ProductoServlet extends HttpServlet {
    private IProductoBO productoBO;
    private static final String UPLOAD_DIR ="uploads";

    @Override
    public void init() throws ServletException {
        productoBO = new ProductoBO();
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
                    "Electrónica"
                );
                productoBO.registrarProducto(p1);
                
                // Producto 2: Electrónica
                Producto p2 = new Producto(
                    "Auriculares Inalámbricos Noise Cancelling",
                    249.99,
                    "Auriculares premium con cancelación activa de ruido, 30 horas de batería, Bluetooth 5.0.",
                    "",
                    45,
                    "Electrónica"
                );
                productoBO.registrarProducto(p2);
                
                // Producto 3: Muebles
                Producto p3 = new Producto(
                    "Silla Ergonómica de Oficina",
                    189.50,
                    "Silla ergonómica con soporte lumbar, reposabrazas ajustables, respaldo reclinable hasta 135°.",
                    "",
                    22,
                    "Muebles"
                );
                productoBO.registrarProducto(p3);
                
                // Producto 4: Electrónica
                Producto p4 = new Producto(
                    "Monitor UltraWide 34\" 4K",
                    599.00,
                    "Monitor curvo ultrawide con resolución 3440x1440, 144Hz, HDR10, tiempo de respuesta 1ms.",
                    "",
                    8,
                    "Electrónica"
                );
                productoBO.registrarProducto(p4);
                
                // Producto 5: Ropa
                Producto p5 = new Producto(
                    "Zapatillas Deportivas Running Pro",
                    89.99,
                    "Zapatillas ligeras para running, suela con tecnología de amortiguación, material transpirable.",
                    "",
                    60,
                    "Calzado"
                );
                productoBO.registrarProducto(p5);
                
                // Producto 6: Electrónica
                Producto p6 = new Producto(
                    "Teclado Mecánico RGB Gaming",
                    129.99,
                    "Teclado mecánico con switches blue, retroiluminación RGB personalizable, reposamuñecas extraíble.",
                    "",
                    35,
                    "Electrónica"
                );
                productoBO.registrarProducto(p6);
                
                // Producto 7: Hogar
                Producto p7 = new Producto(
                    "Escritorio Minimalista de Madera",
                    279.00,
                    "Escritorio moderno de madera maciza, 140x60cm, con organizador de cables integrado.",
                    "",
                    12,
                    "Muebles"
                );
                productoBO.registrarProducto(p7);
                
                // Producto 8: Electrónica
                Producto p8 = new Producto(
                    "Mouse Inalámbrico Ergonómico",
                    45.99,
                    "Mouse ergonómico inalámbrico, 6 botones programables, batería recargable, 3200 DPI.",
                    "",
                    80,
                    "Electrónica"
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
        if (accion == null || accion.equals("listar")) {
            List<Producto> productos = productoBO.listarProductos();
            request.setAttribute("productos", productos);
            request.getRequestDispatcher("views/gestionCatalogo.jsp").forward(request, response);
        } else if (accion.equals("eliminar")) {
            String id = request.getParameter("id");
            if (id != null) {
                productoBO.eliminarProducto(new ObjectId(id));
            }
            response.sendRedirect("ProductoServlet?accion=listar");
        } else if (accion.equals("editar")) {
            String id = request.getParameter("id");
            if (id != null) {
                Producto producto = productoBO.buscarProductoPorId(new ObjectId(id));
                request.setAttribute("producto", producto);
                request.getRequestDispatcher("views/editarProducto.jsp").forward(request, response);
            } else {
                response.sendRedirect("ProductoServlet?accion=listar");
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
                if (!uploadDir.exists()) uploadDir.mkdirs();

                filePart.write(uploadFilePath + File.separator + fileName);
                rutaFinalImagen = UPLOAD_DIR + "/" + fileName;
            }

            Producto producto = new Producto(nombre, precio, descripcion, rutaFinalImagen, stock, categoria);
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

            double precio = (precioStr != null) ? Double.parseDouble(precioStr) : 0;
            int stock = (stockStr != null) ? Integer.parseInt(stockStr) : 0;

            Part filePart = request.getPart("imagenProducto");
            String fileName = filePart.getSubmittedFileName();
            String rutaFinalImagen = "";

            if (fileName != null && !fileName.isEmpty()) {
                String applicationPath = request.getServletContext().getRealPath("");
                String uploadFilePath = applicationPath + File.separator + UPLOAD_DIR;

                File uploadDir = new File(uploadFilePath);
                if (!uploadDir.exists()) uploadDir.mkdirs();

                filePart.write(uploadFilePath + File.separator + fileName);
                rutaFinalImagen = UPLOAD_DIR + "/" + fileName;
            }
            Producto nuevo = new Producto(nombre, precio, descripcion, rutaFinalImagen, stock, categoria);
            productoBO.registrarProducto(nuevo);
            response.sendRedirect("ProductoServlet?accion=listar");
        }
    }
}
