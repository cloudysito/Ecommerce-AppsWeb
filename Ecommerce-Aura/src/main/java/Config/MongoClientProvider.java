/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Config;

import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;

public enum MongoClientProvider {
    INSTANCE;
    private MongoClient client;
    private String dbName = "Ecommerse";
    private String uri = "mongodb://localhost:27017/";

    public synchronized void init() {
        if (client == null) {
            client = MongoClients.create(MongoConfig.buildSettings(this.uri));
            Runtime.getRuntime().addShutdownHook(new Thread(() -> {
                try { client.close(); } catch (Exception ignored) {}
            }));
        }
    }
    public MongoClient client(){
        if(client == null)throw new IllegalStateException("mongo client provider no inicializado, llama a init uir antes");
        return client;
    }
    public MongoDatabase database(){
        return client.getDatabase(this.dbName);
    }
    public<T> MongoCollection<T>getcCollection(String collectionName, Class<T>clazz){
        if(client == null)
            throw new IllegalStateException("mongo client provider no inicializado, llama a init uir antes");

            MongoDatabase db = client.getDatabase(this.dbName);
            return db.getCollection(collectionName,clazz);
        }
    }
