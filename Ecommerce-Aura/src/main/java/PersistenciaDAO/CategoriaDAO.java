/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package PersistenciaDAO;

import Config.MongoClientProvider;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Filters;
import java.util.ArrayList;
import java.util.List;
import modelo.Categoria;
import modelo.Producto;
import PersistenciaDAOInterfaces.ICategoriaDAO;
import org.bson.types.ObjectId;

/**
 *
 * @author emiim
 */
public class CategoriaDAO implements ICategoriaDAO {
    private final MongoCollection<Categoria> coleccion;

    public CategoriaDAO(){
        com.mongodb.client.MongoDatabase db = Config.MongoClientProvider.INSTANCE.database();
        this.coleccion = db.getCollection("categorias", Categoria.class);
    }
    
    @Override
    public void insertar(Categoria categoria) throws Exception {
        coleccion.insertOne(categoria);
    }

    @Override
    public List<Categoria> consultarTodas() throws Exception {
        List<Categoria> categorias = coleccion.find().into(new ArrayList<>());

        if (categorias.isEmpty()) {
            MongoDatabase db = MongoClientProvider.INSTANCE.database();
            MongoCollection<Producto> productos = db.getCollection("productos", Producto.class);
            List<String> categoriasDeProductos = productos.distinct("categoria", String.class)
                    .into(new ArrayList<>());

            for (String nombreCategoria : categoriasDeProductos) {
                if (nombreCategoria != null && !nombreCategoria.trim().isEmpty()) {
                    categorias.add(new Categoria(null, nombreCategoria.trim(), ""));
                }
            }
        }

        return categorias;
    }

    @Override
    public void eliminar(ObjectId id) throws Exception {
        coleccion.deleteOne(Filters.eq("_id", id));
    }
}
