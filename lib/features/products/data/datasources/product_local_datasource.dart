import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import '../models/product_model.dart';

abstract class ProductLocalDataSource {
  Future<List<ProductModel>> getCachedProducts();
  Future<void> cacheProducts(List<ProductModel> products);
  Future<void> insertProduct(ProductModel product);
  Future<void> deleteProduct(int productId);
}

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  static const String _tableName = 'products';
  static const String _dbName = 'online_store.db';

  Database? _database;

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dir = await getApplicationDocumentsDirectory();
    final path = join(dir.path, _dbName);
    return openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tableName (
        id      INTEGER PRIMARY KEY,
        title   TEXT    NOT NULL,
        price   REAL    NOT NULL,
        description  TEXT NOT NULL,
        category     TEXT NOT NULL,
        image        TEXT NOT NULL,
        rating_rate  REAL DEFAULT 0.0,
        rating_count INTEGER DEFAULT 0,
        is_local     INTEGER DEFAULT 0
      )
    ''');
  }

  @override
  Future<List<ProductModel>> getCachedProducts() async {
    final db = await database;
    final maps = await db.query(_tableName, orderBy: 'is_local DESC, id ASC');
    return maps.map(ProductModel.fromMap).toList();
  }

  @override
  Future<void> cacheProducts(List<ProductModel> products) async {
    final db = await database;
    final batch = db.batch();
    // Remove only remote-sourced products before re-caching
    batch.delete(_tableName, where: 'is_local = ?', whereArgs: [0]);
    for (final p in products) {
      batch.insert(_tableName, p.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
    await batch.commit(noResult: true);
  }

  @override
  Future<void> insertProduct(ProductModel product) async {
    final db = await database;
    await db.insert(_tableName, product.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  Future<void> deleteProduct(int productId) async {
    final db = await database;
    await db.delete(_tableName, where: 'id = ?', whereArgs: [productId]);
  }
}
