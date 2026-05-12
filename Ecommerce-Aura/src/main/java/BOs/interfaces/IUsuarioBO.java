/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package BOS.interfaces;

import modelo.Usuario;

/**
 *
 * @author USER
 */
public interface IUsuarioBO {
    Usuario iniciarSesion(String correo, String password) throws Exception;
}
