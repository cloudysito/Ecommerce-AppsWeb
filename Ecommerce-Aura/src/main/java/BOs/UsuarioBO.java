/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package BOs;

import BOs.interfaces.IUsuarioBO;
import modelo.Usuario;
import PersistenciaDAOInterfaces.IUsuarioDAO;
import PersistenciaDAO.UsuarioDAO;
import java.util.List;
import org.bson.types.ObjectId;

/**
 *
 * @author USER
 */
public class UsuarioBO implements IUsuarioBO {

    private final IUsuarioDAO usuarioDAO = new UsuarioDAO();

    public UsuarioBO() {
    }
    
    public void crearAdmin(){
        try {
            Usuario admin = usuarioDAO.autentificar("admin@gmail.com", "mitens", "Admin");
            
            if(admin == null){
                Usuario adminViejo = usuarioDAO.autentificar("admin@gmail.com", "mitens", "admin");
                
                if(adminViejo != null){
                    adminViejo.setRol("Admin");
                    usuarioDAO.actualizar(adminViejo);
                    System.out.println("admin actualizado correctamente con el rol correcto");
                } else {
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
            throw new Exception("El correo es obligatorio.");
        }
        if (password == null || password.trim().isEmpty()) {
            throw new Exception("La contraseña es obligatoria.");
        }
        
        Usuario usuarioEncontrado = usuarioDAO.encontrarPorCorreo(correo);
        
        if (usuarioEncontrado == null || !usuarioEncontrado.getContrasenia().equals(password)) {
            throw new Exception("Credenciales incorrectas.");
        }

        if (!usuarioEncontrado.isActivo()) {
            throw new Exception("Tu cuenta ha sido desactivada. Contacta al administrador.");
        }

        return usuarioEncontrado;
    }
    
    @Override
    public Usuario registrarUsuario(Usuario usuario) throws Exception {
        if (usuario.getNombreCompleto() == null || usuario.getNombreCompleto().trim().isEmpty()) {
            throw new Exception("El nombre es obligatorio.");
        }
        if (usuario.getCorreo() == null || usuario.getCorreo().trim().isEmpty()) {
            throw new Exception("El correo es obligatorio.");
        }
        if (usuario.getContrasenia() == null || usuario.getContrasenia().trim().isEmpty()) {
            throw new Exception("Debes ingresar una contraseña.");
        }
        
        Usuario existente = usuarioDAO.encontrarPorCorreo(usuario.getCorreo());
        if (existente != null) {
            throw new Exception("Este correo ya está registrado.");
        }
        
        usuario.setRol("Cliente");
        return usuarioDAO.insertar(usuario);
    }
    
    @Override
    public Usuario actualizarPerfil(Usuario usuario) throws Exception {
        if (usuario.getNombreCompleto() == null || usuario.getNombreCompleto().trim().isEmpty()) {
            throw new Exception("El nombre es obligatorio y no puede estar vacio.");
        }
        
        boolean exito = usuarioDAO.actualizar(usuario);
        
        if (!exito) {
            throw new Exception("No se pudo actualizar el perfil.");
        }
        return usuario;
    }

    @Override
    public List<Usuario> consultarTodos() throws Exception {
        try {
            return usuarioDAO.encontrarTodos();
        } catch (Exception e){
            throw new Exception("No hay usuarios en la base de datos: " + e.getMessage());
        }
    }

    @Override
    public boolean cambiarEstadoUsuario(ObjectId userId, boolean activo) throws Exception {
        if (userId == null) {
            throw new Exception("El ID del usuario es obligatorio.");
        }
        try {
            return usuarioDAO.cambiarEstadoActivo(userId, activo);
        } catch (Exception e) {
            throw new Exception("No se pudo cambiar el estado del usuario: " + e.getMessage());
        }
    }
}
