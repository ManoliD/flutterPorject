import 'dart:io' as io;
import 'package:dan_flutter_app/models/product.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class FavoriteDataBaseSingleton {

  static Database _database;

  static final FavoriteDataBaseSingleton _singleton =
      FavoriteDataBaseSingleton._internal();

  factory FavoriteDataBaseSingleton() {
    return _singleton;
  }

  FavoriteDataBaseSingleton._internal();

  List<FavouriteEvents> _events = [];

  addListener(FavouriteEvents event) {
    _events.add(event);
  }

  removeListener(FavouriteEvents event) {
    _events.remove(event);
  }

  addToFavourite(Product product) {
    addProdus(product);
    _events.forEach((element) {
      element.addToFavourites(product);
    });
  }

  removeFromFavourite(Product product) {
    removeProdus(product.id);
    _events.forEach((element) {
      element.removeFromFavourites(product);
    });
  }

  Future<Database> get database async {
    if (_database != null)
      return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "favorite_products2.db");
    return await openDatabase(path, version: 1, onOpen: (db) {
    }, onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE produsefavorite ("
          "id INTEGER PRIMARY KEY,"
          "title TEXT,"
          "short_description TEXT,"
          "image TEXT,"
          "price INTEGER,"
          "sale_precent INTEGER,"
          "details TEXT"
          ")");
    });
  }

  Future<void> addProdus(Product product) async {
    final Database db = await database;
    await db.insert(
      'produsefavorite',
      product.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> removeProdus(int id) async {
    final db = await database;
    await db.delete(
      'produsefavorite',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  // ignore: non_constant_identifier_names
  Future<List<Product>> all_products() async {
    final db = await database;
    var res = await db.query("produsefavorite");
    List<Product> list =
    res.isNotEmpty ? res.map((c) => Product.fromMap(c)).toList() : [];
    return list;

  }

  // ignore: non_constant_identifier_names
  Future<List<Product>> map_favourites(List<Product> products) async {
    final db = await database;
    var res = await db.query("produsefavorite");
    List<Product> listDb =
    res.isNotEmpty ? res.map((c) => Product.fromMap(c)).toList() : [];

    for (int i = 0; i < products.length; i++) {
      for (int j = 0; j < listDb.length; j++) {
        if (products[i].id == listDb[j].id) {
          products[i].favourite = true;
        }
      }
    }

    return products;
  }
  
}

abstract class FavouriteEvents {
  void addToFavourites(Product product);
  void removeFromFavourites(Product product);
}
