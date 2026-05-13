/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package BOs;

import BOs.interfaces.IUsuarioBO;
import modelo.Usuario;
import PersistenciaDAO.IUsuarioDAO;
import PersistenciaDAOImpl.UsuarioDAO;

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
}
