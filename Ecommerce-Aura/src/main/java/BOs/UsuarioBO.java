/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package BOS;

import BOS.interfaces.IUsuarioBO;
import modelo.Usuario;
import PersistenciaDAO.IUsuarioDAO;
import PersistenciaDAOImpl.UsuarioDAO;

/**
 *
 * @author USER
 */
public class UsuarioBO implements IUsuarioBO{

    private final IUsuarioDAO usuarioDAO;

    public UsuarioBO() {
        this.usuarioDAO = new UsuarioDAO();
    }
    public void crearAdmin(){
        try {
            // Primero intenta buscar con el rol correcto
            Usuario admin = usuarioDAO.autentificar("admin@gmail.com", "mitens", "Admin");
            
            if(admin == null){
                // Si no existe con "Admin", busca con el rol incorrecto "admin"
                Usuario adminViejo = usuarioDAO.autentificar("admin@gmail.com", "mitens", "admin");
                
                if(adminViejo != null){
                    // Actualizar el rol del admin existente
                    adminViejo.setRol("Admin");
                    usuarioDAO.actualizar(adminViejo);
                    System.out.println("admin actualizado correctamente con el rol correcto");
                } else {
                    // Si no existe, crear uno nuevo
                    Usuario nuevoAdmin = new Usuario();
                    nuevoAdmin.setNombreCompleto("admnistrador principal");
                    nuevoAdmin.setCorreo("admin@gmail.com");
                    nuevoAdmin.setContrasenia("mitens");
                    nuevoAdmin.setRol("Admin");
                    
                    usuarioDAO.registrarUsuario(nuevoAdmin, "Admin");
                    System.out.println("admin creado correctamente");
                }
            } else {
                System.out.println("admin ya existe con el rol correcto");
            }
        } catch (Exception e) {
            System.out.println("error al crear/actualizar al admin: " + e.getMessage());
        }
    }
    @Override
    public Usuario iniciarSesion(String correo, String password) throws Exception {
        if (correo == null || correo.trim().isEmpty()) {
            throw new Exception("el correo es obligatorio");
        }
        if (password == null || password.trim().isEmpty()) {
            throw new Exception("la contraseña es obligatoria");
        }
        Usuario usuarioEncontrado = usuarioDAO.autentificar(correo, password, "Admin");
        if (usuarioEncontrado == null) {
            throw new Exception("credenciales incorrectas o no tienes permisos de administrador");
        }
        return usuarioEncontrado;
    }
}
