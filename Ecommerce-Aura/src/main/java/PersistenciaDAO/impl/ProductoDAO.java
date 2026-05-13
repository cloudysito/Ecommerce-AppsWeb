package PersistenciaDAO.impl;

import Config.MongoClientProvider;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import modelo.Producto;
import org.bson.types.ObjectId;
import PersistenciaDAO.IProductoDAO;
import com.mongodb.client.model.Filters;
import static com.mongodb.client.model.Filters.eq;
import java.util.ArrayList;
import java.util.List;
import org.bson.Document;
import org.bson.conversions.Bson;

public class ProductoDAO implements IProductoDAO {

    private final MongoCollection<Producto> pr;

    public ProductoDAO() {
        MongoDatabase db = MongoClientProvider.INSTANCE.database();
        this.pr = db.getCollection("productos", Producto.class);
    }

    @Override
    public List<Producto> obtenerProductos() {
        return pr.find().into(new ArrayList<>());
    }

    @Override
    public Producto obtenerProductoPorId(ObjectId id) {
        return pr.find(eq("_id", id)).first();
    }

    @Override
    public void insertar(Producto producto) {
        pr.insertOne(producto);
    }

    @Override
    public void actualizar(Producto producto) {
        pr.replaceOne(eq("_id", producto.getId()), producto);
    }

    @Override
    public void eliminar(ObjectId id) {
        pr.deleteOne(eq("_id", id));
    }

    @Override
    public List<Producto> buscarProductos(String nombre, String categoria, Double minPrecio, Double maxPrecio) {
        List<Bson> filtros = new ArrayList<>();

        if (nombre != null && !nombre.isEmpty()) {
            filtros.add(Filters.regex("nombre", ".*" + nombre + ".*", "i"));
        }

        if (categoria != null && !categoria.isEmpty()) {
            filtros.add(Filters.eq("categoria", categoria));
        }

        if (minPrecio != null) {
            filtros.add(Filters.gte("precio", minPrecio));
        }
        if (maxPrecio != null) {
            filtros.add(Filters.lte("precio", maxPrecio));
        }

        Bson filtroFinal = filtros.isEmpty() ? new Document() : Filters.and(filtros);

        return pr.find(filtroFinal).into(new ArrayList<>());
    }

    @Override
    public List<Producto> obtenerProductosFiltrados(String nombre, String cat, String tipoPrecio, Double precio) {
        List<org.bson.conversions.Bson> filtros = new ArrayList<>();

        if (nombre != null && !nombre.isEmpty()) {
            filtros.add(com.mongodb.client.model.Filters.regex("nombre", ".*" + nombre + ".*", "i"));
        }
        if (cat != null && !cat.isEmpty()) {
            filtros.add(com.mongodb.client.model.Filters.eq("categoria", cat));
        }
        if (precio != null && tipoPrecio != null) {
            if ("menor".equals(tipoPrecio)) {
                filtros.add(com.mongodb.client.model.Filters.lte("precio", precio));
            } else {
                filtros.add(com.mongodb.client.model.Filters.gte("precio", precio));
            }
        }

        org.bson.conversions.Bson query = filtros.isEmpty() ? new org.bson.Document() : com.mongodb.client.model.Filters.and(filtros);
        return pr.find(query).into(new ArrayList<>());
    }

}
