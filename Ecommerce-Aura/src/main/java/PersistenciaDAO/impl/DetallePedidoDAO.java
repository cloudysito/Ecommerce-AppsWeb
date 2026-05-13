package PersistenciaDAOImpl;

import Config.MongoClientProvider;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import modelo.DetallePedido;
import org.bson.types.ObjectId;
import PersistenciaDAO.IDetallePedidoDAO;
import static com.mongodb.client.model.Filters.eq;

import java.util.ArrayList;
import java.util.List;

public class DetallePedidoDAO implements IDetallePedidoDAO {
    private final MongoCollection<DetallePedido> dp;

    public DetallePedidoDAO() {
        MongoDatabase db = MongoClientProvider.INSTANCE.database();
        this.dp = db.getCollection("detalles_pedido: ", DetallePedido.class);
    }

    @Override
    public void insertarDetalles(List<DetallePedido> detallesPedido) {
        if (detallesPedido != null && !detallesPedido.isEmpty()) {
            dp.insertMany(detallesPedido);
        }
    }

    @Override
    public List<DetallePedido> obtenerPorPedido(ObjectId pedidoId){
        return dp.find(eq("pedidoId", pedidoId)).into(new ArrayList<>());
    }
    
}
