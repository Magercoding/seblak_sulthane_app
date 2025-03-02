import 'package:seblak_sulthane_app/data/models/response/discount_response_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:developer';

class DiscountLocalDatasource {
  DiscountLocalDatasource._();

  static DiscountLocalDatasource instance = DiscountLocalDatasource._();

  static Database? _database;

  static const String _tableName = 'discounts';

  static const String createTable = '''
    CREATE TABLE IF NOT EXISTS $_tableName (
      id INTEGER PRIMARY KEY,
      name TEXT,
      description TEXT,
      type TEXT,
      value TEXT,
      status TEXT,
      expired_date TEXT,
      created_at TEXT,
      updated_at TEXT,
      category TEXT
    )
  ''';

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'seblak_sulthane.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(createTable);
      },
      onOpen: (Database db) async {
        await db.execute(createTable);
      },
    );
  }

  Future<int> insertDiscount(Discount discount) async {
    final db = await database;

    await db.execute(createTable);
    return await db.insert(
      _tableName,
      discount.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertDiscounts(List<Discount> discounts) async {
    final db = await database;

    await db.execute(createTable);
    final batch = db.batch();

    for (var discount in discounts) {
      batch.insert(
        _tableName,
        discount.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    await batch.commit(noResult: true);
  }

  Future<List<Discount>> getAllDiscounts() async {
    final db = await database;

    await db.execute(createTable);
    final List<Map<String, dynamic>> maps = await db.query(_tableName);

    return List.generate(maps.length, (i) {
      return Discount.fromJson(maps[i]);
    });
  }

  Future<Discount?> getDiscountById(int id) async {
    final db = await database;

    await db.execute(createTable);
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Discount.fromJson(maps.first);
    }

    return null;
  }

  Future<List<Discount>> getDiscountsByCategory(String category) async {
    final db = await database;

    await db.execute(createTable);
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: 'category = ?',
      whereArgs: [category],
    );

    return List.generate(maps.length, (i) {
      return Discount.fromJson(maps[i]);
    });
  }

  Future<int> deleteAllDiscounts() async {
    try {
      final db = await database;

      await db.execute(createTable);
      return await db.delete(_tableName);
    } catch (e) {
      log('Error deleting discounts: $e');

      final db = await database;
      await db.execute(createTable);
      return 0;
    }
  }

  Future<List<Discount>> searchDiscountsByName(String name) async {
    final db = await database;

    await db.execute(createTable);
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: 'name LIKE ?',
      whereArgs: ['%$name%'],
    );

    return List.generate(maps.length, (i) {
      return Discount.fromJson(maps[i]);
    });
  }
}
