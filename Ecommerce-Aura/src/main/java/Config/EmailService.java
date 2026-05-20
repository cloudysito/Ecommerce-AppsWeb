package Config;

import jakarta.mail.MessagingException;
import jakarta.servlet.http.HttpSession;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import modelo.Pedido;
import modelo.Usuario;

public class EmailService {
    private static final ExecutorService executor = Executors.newCachedThreadPool();

    public static void enviarConfirmacionAsync(Usuario usuario, Pedido pedido, HttpSession session) {
        // Copiar referencias necesarias para la tarea
        executor.submit(() -> {
            try {
                EmailUtil.enviarConfirmacionPedido(usuario, pedido);
                try {
                    synchronized (session) {
                        session.setAttribute("emailEnviado", Boolean.TRUE);
                        session.removeAttribute("emailError");
                    }
                } catch (Exception e) {
                    // No hacer fallar el envío por problemas de sesión
                    System.err.println("Aviso: no se pudo setear atributo de sesión tras enviar correo: " + e.getMessage());
                }
            } catch (MessagingException mex) {
                try {
                    synchronized (session) {
                        session.setAttribute("emailEnviado", Boolean.FALSE);
                        session.setAttribute("emailError", mex.getMessage());
                    }
                } catch (Exception e) {
                    System.err.println("Error guardando estado de envío en sesión: " + e.getMessage());
                }
                System.err.println("Error enviando correo en background: " + mex.getMessage());
                mex.printStackTrace();
            } catch (Exception ex) {
                try {
                    synchronized (session) {
                        session.setAttribute("emailEnviado", Boolean.FALSE);
                        session.setAttribute("emailError", ex.getMessage());
                    }
                } catch (Exception e) {
                    System.err.println("Error guardando estado de envío en sesión: " + e.getMessage());
                }
                System.err.println("Error inesperado enviando correo en background: " + ex.getMessage());
                ex.printStackTrace();
            }
        });
    }

    public static ExecutorService getExecutor() {
        return executor;
    }
}

