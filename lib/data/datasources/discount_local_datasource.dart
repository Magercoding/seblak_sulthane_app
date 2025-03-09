import 'package:seblak_sulthane_app/data/models/response/discount_response_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:developer';

class DiscountLocalDatasource {
  // Make this a regular class instead of a singleton for better testability
  // and dependency injection

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
      category TEXT,
      is_synced INTEGER DEFAULT 1
    )
  ''';

  late Future<Database> _database;

  DiscountLocalDatasource() {
    _database = _initDatabase();
  }

  Future<Database> get database async => await _database;

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'seblak_sulthane.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(createTable);
      },
      onUpgrade: (Database db, int oldVersion, int newVersion) async {
        // Handle database migrations if needed
        if (oldVersion < 1) {
          await db.execute(createTable);
        }
      },
      onOpen: (Database db) async {
        await db.execute(createTable);
      },
    );
  }

  Future<int> insertDiscount(Discount discount) async {
    try {
      final db = await database;

      // Convert the Discount object to a map and ensure all fields are present
      final Map<String, dynamic> discountMap = discount.toJson();

      // Add the is_synced field (1 = synced, 0 = not synced)
      discountMap['is_synced'] = 1;

      return await db.insert(
        _tableName,
        discountMap,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      log('Error inserting discount: $e');
      return -1;
    }
  }

  Future<void> insertDiscounts(List<Discount> discounts) async {
    try {
      final db = await database;
      final batch = db.batch();

      for (var discount in discounts) {
        // Convert the Discount object to a map
        final Map<String, dynamic> discountMap = discount.toJson();

        // Add the is_synced field
        discountMap['is_synced'] = 1;

        batch.insert(
          _tableName,
          discountMap,
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }

      await batch.commit(noResult: true);
    } catch (e) {
      log('Error inserting discounts: $e');
    }
  }

  Future<List<Discount>> getAllDiscounts() async {
    try {
      final db = await database;
      final List<Map<String, dynamic>> maps = await db.query(_tableName);

      return List.generate(maps.length, (i) {
        return Discount.fromJson(maps[i]);
      });
    } catch (e) {
      log('Error getting all discounts: $e');
      return [];
    }
  }

  Future<List<Discount>> getUnsyncedDiscounts() async {
    try {
      final db = await database;
      final List<Map<String, dynamic>> maps = await db.query(
        _tableName,
        where: 'is_synced = ?',
        whereArgs: [0],
      );

      return List.generate(maps.length, (i) {
        return Discount.fromJson(maps[i]);
      });
    } catch (e) {
      log('Error getting unsynced discounts: $e');
      return [];
    }
  }

  Future<Discount?> getDiscountById(int id) async {
    try {
      final db = await database;
      final List<Map<String, dynamic>> maps = await db.query(
        _tableName,
        where: 'id = ?',
        whereArgs: [id],
      );

      if (maps.isNotEmpty) {
        return Discount.fromJson(maps.first);
      }
      return null;
    } catch (e) {
      log('Error getting discount by id: $e');
      return null;
    }
  }

  Future<List<Discount>> getDiscountsByCategory(String category) async {
    try {
      final db = await database;
      final List<Map<String, dynamic>> maps = await db.query(
        _tableName,
        where: 'category = ?',
        whereArgs: [category],
      );

      return List.generate(maps.length, (i) {
        return Discount.fromJson(maps[i]);
      });
    } catch (e) {
      log('Error getting discounts by category: $e');
      return [];
    }
  }

  Future<int> updateDiscount(Discount discount) async {
    try {
      final db = await database;

      // Convert the Discount object to a map
      final Map<String, dynamic> discountMap = discount.toJson();

      // Add the is_synced field (0 = not synced if we're updating locally)
      discountMap['is_synced'] = 0;

      return await db.update(
        _tableName,
        discountMap,
        where: 'id = ?',
        whereArgs: [discount.id],
      );
    } catch (e) {
      log('Error updating discount: $e');
      return -1;
    }
  }

  Future<int> deleteDiscount(int id) async {
    try {
      final db = await database;
      return await db.delete(
        _tableName,
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      log('Error deleting discount: $e');
      return -1;
    }
  }

  Future<int> deleteAllDiscounts() async {
    try {
      final db = await database;
      return await db.delete(_tableName);
    } catch (e) {
      log('Error deleting all discounts: $e');
      return 0;
    }
  }

  Future<List<Discount>> searchDiscountsByName(String name) async {
    try {
      final db = await database;
      final List<Map<String, dynamic>> maps = await db.query(
        _tableName,
        where: 'name LIKE ?',
        whereArgs: ['%$name%'],
      );

      return List.generate(maps.length, (i) {
        return Discount.fromJson(maps[i]);
      });
    } catch (e) {
      log('Error searching discounts by name: $e');
      return [];
    }
  }

  // Mark a discount as synced
  Future<int> markDiscountAsSynced(int id) async {
    try {
      final db = await database;
      return await db.update(
        _tableName,
        {'is_synced': 1},
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      log('Error marking discount as synced: $e');
      return -1;
    }
  }
}
