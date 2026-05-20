/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package PersistenciaDAO;

import PersistenciaDAOInterfaces.ICarritoDAO;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.model.Filters;
import com.mongodb.client.model.ReplaceOptions;
import java.util.ArrayList;
import java.util.List;
import modelo.CarritoItem;
import org.bson.Document;

/**
 *
 * @author emiim
 */
public class CarritoDAO implements ICarritoDAO {
    private final MongoCollection<Document> coleccion;
    
    public CarritoDAO() {
        this.coleccion = Config.MongoClientProvider.INSTANCE.database().getCollection("carritos");
    }
    
    @Override
    public void guardarCarrito(String usuarioId, List<CarritoItem> items) {
        Document doc = new Document("usuarioID", usuarioId).append("items", items);
        coleccion.replaceOne(Filters.eq("usuarioId", usuarioId), doc, new ReplaceOptions().upsert(true));
    }

    @Override
    public List<CarritoItem> obtenerCarrito(String usuarioId) {
        Document doc = coleccion.find(Filters.eq("usuarioID", usuarioId)).first();
        if (doc != null) {
            return (List<CarritoItem>) doc.get("items");
        }
        return new ArrayList<>();
    }
    
}
