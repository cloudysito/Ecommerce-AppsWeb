/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package BOS.interfaces;

import java.util.List;
import modelo.Resena;

/**
 *
 * @author USER
 */
public interface IResenaBO {
    List<Resena> obtenerTodasLasResenas() throws Exception;
    void eliminarResena(String idResenaTexto) throws Exception ;
}
