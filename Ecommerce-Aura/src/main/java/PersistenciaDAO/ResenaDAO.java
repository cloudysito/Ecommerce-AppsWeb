/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package PersistenciaDAO;

import Config.MongoClientProvider;
import com.mongodb.MongoException;
import com.mongodb.client.MongoCollection;
import static com.mongodb.client.model.Filters.eq;
import java.util.ArrayList;
import java.util.List;
import modelo.Resena;
import org.bson.types.ObjectId;
import PersistenciaDAOInterfaces.IResenaDAO;

/**
 *
 * @author garfi
 */
public class ResenaDAO implements IResenaDAO {

    private final MongoCollection<Resena> coleccion;

    public ResenaDAO() {
        this.coleccion = MongoClientProvider.INSTANCE.getcCollection("resenas", Resena.class);
    }

    @Override
    public ObjectId agregarResena(Resena resena) {
        try {
            coleccion.insertOne(resena);
            return resena.getId();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public boolean eliminarResena(ObjectId id) {
        return coleccion.deleteOne(eq("_id", id)).getDeletedCount() > 0;
    }

    @Override
    public List<Resena> obtenerTodasLasResenas() {
        try {
            return coleccion.find().into(new ArrayList<>());
        } catch (MongoException e) {
            throw new MongoException("error al obtener todas las resenas" + e);
        }
    }

    @Override
    public void crearResena(Resena resena) {
        coleccion.insertOne(resena);
    }

    @Override
    public List<Resena> obtenerResenasPorProducto(ObjectId productoId) {
        return coleccion.find(eq("productoId", productoId)).into(new ArrayList<>());
    }

}
