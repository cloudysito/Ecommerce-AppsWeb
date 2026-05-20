package Config;

import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import java.util.Properties;
import modelo.Pedido;
import modelo.Usuario;

public class EmailUtil {

    public static void enviarConfirmacionPedido(Usuario usuario, Pedido pedido) throws MessagingException {
        String host = System.getenv("EMAIL_HOST");
        String port = System.getenv("EMAIL_PORT");
        final String user = System.getenv("EMAIL_USER");
        final String pass = System.getenv("EMAIL_PASS");
        String from = System.getenv("EMAIL_FROM");

        if (host == null || port == null || user == null || pass == null) {
            throw new MessagingException("Configuración SMTP incompleta. Revise variables de entorno EMAIL_HOST/EMAIL_PORT/EMAIL_USER/EMAIL_PASS.");
        }

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", host);
        props.put("mail.smtp.port", port);

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(user, pass);
            }
        });

        Message message = new MimeMessage(session);
        try {
            if (from == null || from.isEmpty()) {
                from = user;
            }
            message.setFrom(new InternetAddress(from));
            message.setRecipient(Message.RecipientType.TO, new InternetAddress(usuario.getCorreo()));
            message.setSubject("Confirmación de pedido - " + pedido.getId());

            StringBuilder sb = new StringBuilder();
            sb.append("Hola ").append(usuario.getNombreCompleto()).append(",\n\n");
            sb.append("Gracias por tu compra. Tu pedido ha sido recibido y confirmado.\n\n");
            sb.append("Detalles del pedido:\n");
            if (pedido.getProductos() != null) {
                pedido.getProductos().forEach(d -> sb.append("- ").append(d.getNombreProducto()).append(" x").append(d.getCantidad()).append(" = $").append(d.getSubtotal()).append("\n"));
            }
            sb.append("\nTotal: $").append(pedido.getTotal()).append("\n\n");
            sb.append("ID del pedido: ").append(pedido.getId()).append("\n");
            sb.append("Fecha: ").append(pedido.getFecha()).append("\n\n");
            sb.append("Si tienes preguntas, responde este correo o contáctanos.\n\n");
            sb.append("Saludos,\nEl equipo de Ecommerce");

            message.setText(sb.toString());

            Transport.send(message);
        } catch (MessagingException ex) {
            throw ex;
        }
    }
}

