package PersistenciaDAOImpl;

import Config.MongoClientProvider;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import modelo.Producto;
import org.bson.types.ObjectId;
import PersistenciaDAO.IProductoDAO;
import static com.mongodb.client.model.Filters.eq;
import java.util.ArrayList;
import java.util.List;

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
}
