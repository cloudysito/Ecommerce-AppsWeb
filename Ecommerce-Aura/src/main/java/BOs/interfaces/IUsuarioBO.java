/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package BOs.interfaces;

import java.util.List;
import modelo.Usuario;

/**
 *
 * @author USER
 */
public interface IUsuarioBO {
    Usuario iniciarSesion(String correo, String password) throws Exception;
    Usuario registrarUsuario(Usuario usuario) throws Exception;
    Usuario actualizarPerfil(Usuario usuario) throws Exception;
    List<Usuario> consultarTodos() throws Exception; 
}
