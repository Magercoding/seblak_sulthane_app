import 'package:seblak_sulthane_app/data/models/response/member_response_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:developer';

class MemberLocalDatasource {
  MemberLocalDatasource._();

  static MemberLocalDatasource instance = MemberLocalDatasource._();

  static Database? _database;

  // Table name
  static const String _tableName = 'members';

  // Create members table
  static const String createTable = '''
    CREATE TABLE IF NOT EXISTS $_tableName (
      id INTEGER PRIMARY KEY,
      name TEXT,
      phone TEXT,
      created_at TEXT,
      updated_at TEXT
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
        // Ensure table exists when opening the database
        await db.execute(createTable);
      },
    );
  }

  // Insert a single member
  Future<int> insertMember(Member member) async {
    final db = await database;
    // Ensure table exists
    await db.execute(createTable);
    return await db.insert(
      _tableName,
      member.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Insert multiple members
  Future<void> insertMembers(List<Member> members) async {
    final db = await database;
    // Ensure table exists
    await db.execute(createTable);
    final batch = db.batch();

    for (var member in members) {
      batch.insert(
        _tableName,
        member.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    await batch.commit(noResult: true);
  }

  // Get all members
  Future<List<Member>> getAllMembers() async {
    final db = await database;
    // Ensure table exists
    await db.execute(createTable);
    final List<Map<String, dynamic>> maps = await db.query(_tableName);

    return List.generate(maps.length, (i) {
      return Member.fromJson(maps[i]);
    });
  }

  // Get member by id
  Future<Member?> getMemberById(int id) async {
    final db = await database;
    // Ensure table exists
    await db.execute(createTable);
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Member.fromJson(maps.first);
    }

    return null;
  }

  // Get member by phone
  Future<Member?> getMemberByPhone(String phone) async {
    final db = await database;
    // Ensure table exists
    await db.execute(createTable);
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: 'phone = ?',
      whereArgs: [phone],
    );

    if (maps.isNotEmpty) {
      return Member.fromJson(maps.first);
    }

    return null;
  }

  // Delete all members
  Future<int> deleteAllMembers() async {
    try {
      final db = await database;
      // Ensure table exists before deleting
      await db.execute(createTable);
      return await db.delete(_tableName);
    } catch (e) {
      log('Error deleting members: $e');
      // Create table if it doesn't exist and return 0 (no rows deleted)
      final db = await database;
      await db.execute(createTable);
      return 0;
    }
  }

  // Search members by name
  Future<List<Member>> searchMembersByName(String name) async {
    final db = await database;
    // Ensure table exists
    await db.execute(createTable);
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: 'name LIKE ?',
      whereArgs: ['%$name%'],
    );

    return List.generate(maps.length, (i) {
      return Member.fromJson(maps[i]);
    });
  }
}
