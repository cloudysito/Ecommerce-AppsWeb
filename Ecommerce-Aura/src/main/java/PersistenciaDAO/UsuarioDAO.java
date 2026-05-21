/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package PersistenciaDAO;

import Config.MongoClientProvider;
import com.mongodb.MongoException;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.model.Filters;
import com.mongodb.client.model.Updates;
import com.mongodb.client.result.UpdateResult;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import modelo.Usuario;
import org.bson.types.ObjectId;
import PersistenciaDAOInterfaces.IUsuarioDAO;


/**
 *
 * @author USER
 */
public class UsuarioDAO implements IUsuarioDAO {
    
    private final MongoCollection<Usuario> col;

    public UsuarioDAO() {
        this.col = MongoClientProvider.INSTANCE.getcCollection("usuario", Usuario.class);
        migrarCampoActivo();
    }

    @Override
    public ObjectId registrarUsuario(Usuario entidad, String rol) {
        try {
            if(entidad.getId() == null){
                entidad.setId(new ObjectId());
            }
            entidad.setRol(rol);
            col.insertOne(entidad);
            return entidad.getId();
        } catch (MongoException e) {
            throw new MongoException("error al registrar al : " + rol + e);
        }
    }

    @Override
    public Usuario autentificar(String correo, String password, String rol) {
        try {
            return col.find(Filters.and(
                    Filters.eq("correo",correo),
                    Filters.eq("contrasenia",password),
                    Filters.eq("rol", rol)
            )).first();
        } catch (MongoException e) {
            throw new MongoException("error al autentificar al: " + rol + e);
        }
    }

    @Override
    public Optional<Usuario> encontrarPorId(Object _id) {
        try {
            return Optional.ofNullable(col.find(Filters.eq("_id",_id)).first());
        } catch (MongoException e) {
            throw new MongoException("error al encontrar al usuario" + e);
        }
    }

    @Override
    public List<Usuario> encontrarTodos() {
        try {
            return col.find().into(new ArrayList<>());
        } catch (MongoException e) {
            throw new MongoException("error al encontrar a todos los usuarios");
        }
    }

    @Override
    public Usuario insertar(Usuario usuario){
        try {
            if(usuario.getId() == null){
                usuario.setId(new ObjectId());
            }
            col.insertOne(usuario);
            return usuario;
        } catch (MongoException e) {
            throw new MongoException("error al insertar al usuario" + e);
        }
    }

    @Override
    public Usuario encontrarPorCorreo(String correo){
        try {
            return col.find(com.mongodb.client.model.Filters.eq("correo", correo)).first();
        } catch (MongoException e) {
            System.err.println("Error al buscar al usuario por su correo: " + e.getMessage());
            return null;
        }
    }
    
    @Override
    public boolean actualizar(Usuario entidad) {
        try {
            UpdateResult resultado = col.replaceOne(
                    Filters.eq("_id", entidad.getId()),
                    entidad
            );
            return resultado.getModifiedCount() > 0;
        } catch (MongoException e) {
            throw new MongoException("error al actualizar al usuario" + e);
        }
    }

    @Override
    public boolean eliminarPorId(ObjectId _id) {
        try {
            var resultado = col.deleteOne(Filters.eq("_id", _id));
            if(resultado.getDeletedCount() == 0){
                throw new MongoException("usuario no existe" + _id);
            }
            return true;
        } catch (Exception e) {
            throw new MongoException("error al eliminar al usuario");
        }
    }

    @Override
    public Optional<Usuario> encontrarPorNombre(String nombre) {
        try {
            return Optional.ofNullable(col.find(Filters.eq("nombre", nombre)).first());
            
        } catch (MongoException e) {
            throw new MongoException("error al buscar por nombre" + e);
        }
    }

    @Override
    public boolean cambiarEstadoActivo(ObjectId userId, boolean activo) {
        try {
            UpdateResult resultado = col.updateOne(
                    Filters.eq("_id", userId),
                    Updates.set("activo", activo)
            );
            return resultado.getModifiedCount() > 0;
        } catch (MongoException e) {
            throw new MongoException("error al cambiar estado del usuario: " + e);
        }
    }

    private void migrarCampoActivo() {
        try {
            UpdateResult resultado = col.updateMany(
                    Filters.exists("activo", false),
                    Updates.set("activo", true)
            );
            if (resultado.getModifiedCount() > 0) {
                System.out.println("Migración completada: " + resultado.getModifiedCount() + " usuario(s) actualizado(s) con campo 'activo'");
            }
        } catch (Exception e) {
            System.err.println("Error durante la migración del campo 'activo': " + e.getMessage());
        }
    }

}
