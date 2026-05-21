package PersistenciaDAO;

import PersistenciaDAOInterfaces.ICarritoDAO;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.model.Filters;
import com.mongodb.client.model.ReplaceOptions;
import java.util.ArrayList;
import java.util.List;
import modelo.CarritoItem;
import modelo.Producto;
import org.bson.Document;
import org.bson.types.ObjectId;

public class CarritoDAO implements ICarritoDAO {

    private final MongoCollection<Document> coleccion;

    public CarritoDAO() {
        this.coleccion = Config.MongoClientProvider.INSTANCE.database().getCollection("carritos");
    }

    @Override
    public void guardarCarrito(String usuarioId, List<CarritoItem> items) {
        List<Document> itemsDoc = new ArrayList<>();
        for (CarritoItem item : items) {
            Document prodDoc = new Document("_id", item.getProducto().getId())
                    .append("nombre", item.getProducto().getNombre())
                    .append("precio", item.getProducto().getPrecio());
            itemsDoc.add(new Document("producto", prodDoc).append("cantidad", item.getCantidad()));
        }
        Document doc = new Document("usuarioID", usuarioId).append("items", itemsDoc);
        coleccion.replaceOne(Filters.eq("usuarioID", usuarioId), doc, new ReplaceOptions().upsert(true));
    }

    @Override
    public List<CarritoItem> obtenerCarrito(String usuarioId) {
        Document doc = coleccion.find(Filters.eq("usuarioID", usuarioId)).first();
        List<CarritoItem> carrito = new ArrayList<>();

        if (doc != null) {
            List<Document> itemsDoc = doc.getList("items", Document.class);
            if (itemsDoc != null) {
                for (Document d : itemsDoc) {
                    Document prodDoc = (Document) d.get("producto");
                    if (prodDoc != null) {
                        Producto p = new Producto();
                        p.setId((ObjectId) prodDoc.get("_id"));
                        p.setNombre(prodDoc.getString("nombre"));
                        p.setPrecio(prodDoc.getDouble("precio") != null ? prodDoc.getDouble("precio") : 0.0);

                        carrito.add(new CarritoItem(p, d.getInteger("cantidad")));
                    }
                }
            }
        }
        return carrito;
    }

    @Override
    public void eliminarCarrito(String usuarioId) {
        if (usuarioId != null) {
            coleccion.deleteOne(Filters.eq("usuarioID", usuarioId));
        }
    }
}
