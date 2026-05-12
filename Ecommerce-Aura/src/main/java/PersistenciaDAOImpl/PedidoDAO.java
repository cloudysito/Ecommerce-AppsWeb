/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package PersistenciaDAOImpl;

import Config.MongoClientProvider;
import com.mongodb.MongoException;
import static com.mongodb.client.model.Filters.eq;
import static com.mongodb.client.model.Updates.set;
import java.util.ArrayList;
import java.util.List;
import com.mongodb.client.MongoCollection;
import modelo.Pedido;
import org.bson.types.ObjectId;
import PersistenciaDAO.IPedidoDAO;

import static com.mongodb.client.model.Filters.eq;

/**
 *
 * @author USER
 */
public class PedidoDAO implements IPedidoDAO {

    private final MongoCollection<Pedido> col;

    public PedidoDAO() {
        this.col = MongoClientProvider.INSTANCE.getcCollection("pedidos", Pedido.class);
    }

    @Override
    public List<Pedido> listarTodos() {
        return col.find().into(new ArrayList<>());
    }

    @Override
    public Pedido obtenerPedidoPorId(ObjectId id) {
        return col.find(eq("id", id)).first();
    }

    @Override
    public void insertar(Pedido pedido) {
        col.insertOne(pedido);
    }

    @Override
    public void actualizarEstado(ObjectId id, String nuevoEstado) {
        col.updateOne(eq("_id", id), set("estado", nuevoEstado));
    }

    @Override
    public void eliminar(ObjectId id) {
        col.deleteOne(eq("_id", id));
    }

}
