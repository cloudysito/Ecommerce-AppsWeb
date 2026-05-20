package Config;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.TimeUnit;

@WebListener
public class EmailListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        // No-op
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        ExecutorService ex = EmailService.getExecutor();
        ex.shutdown();
        try {
            if (!ex.awaitTermination(10, TimeUnit.SECONDS)) {
                ex.shutdownNow();
            }
        } catch (InterruptedException e) {
            ex.shutdownNow();
            Thread.currentThread().interrupt();
        }
    }
}

