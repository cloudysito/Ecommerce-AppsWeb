/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Config;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

/**
 *
 * @author USER
 */
@WebListener
public class MongoListener implements ServletContextListener{
    @Override
    public void contextInitialized(ServletContextEvent sce){
        try {
            System.out.println("iniciando conexion a mongo.... owo");
            MongoClientProvider.INSTANCE.init();
            System.out.println("se a conectado con exito");
        } catch (Exception e) {
            System.out.println("error al conectar con mongo");
        }
    }
    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        System.out.println("apagando server");
    }
}

