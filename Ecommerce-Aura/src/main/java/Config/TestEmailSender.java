package Config;

import modelo.Pedido;
import modelo.Usuario;
import modelo.DetallePedido;
import org.bson.types.ObjectId;
import java.util.ArrayList;
import java.util.List;

public class TestEmailSender {
    public static void main(String[] args) {
        Usuario u = new Usuario();
        u.setNombreCompleto("Cliente Prueba");
        u.setCorreo(System.getenv("TEST_DEST_EMAIL") != null ? System.getenv("TEST_DEST_EMAIL") : System.getenv("EMAIL_USER"));

        List<DetallePedido> detalles = new ArrayList<>();
        detalles.add(new DetallePedido("Producto A", 2, 10.0));
        detalles.add(new DetallePedido("Producto B", 1, 25.5));

        Pedido p = new Pedido(u.getNombreCompleto(), 45.5, detalles);
        p.setId(new ObjectId());

        try {
            System.out.println("Enviando correo de prueba a: " + u.getCorreo());
            EmailUtil.enviarConfirmacionPedido(u, p);
            System.out.println("Correo enviado (si no hubo excepción).");
        } catch (Exception ex) {
            System.err.println("Fallo al enviar correo: " + ex.getMessage());
            ex.printStackTrace();
        }
    }
}

