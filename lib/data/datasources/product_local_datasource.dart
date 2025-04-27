import 'dart:developer';

import 'package:seblak_sulthane_app/data/models/response/product_response_model.dart';
import 'package:seblak_sulthane_app/data/models/response/table_model.dart';
import 'package:seblak_sulthane_app/presentation/home/models/order_model.dart';
import 'package:seblak_sulthane_app/presentation/table/models/draft_order_item.dart';
import 'package:seblak_sulthane_app/presentation/table/models/draft_order_model.dart';
import 'package:sqflite/sqflite.dart';

import '../../presentation/home/models/product_quantity.dart';

class ProductLocalDatasource {
  ProductLocalDatasource._init();

  static final ProductLocalDatasource instance = ProductLocalDatasource._init();

  final String tableProduct = 'products';
  final String tableOrder = 'orders';
  final String tableOrderItem = 'order_items';
  final String tableManagement = 'table_management';

  static Database? _database;

  // Increase database version to trigger migration
  final int _databaseVersion = 2;

  Future<void> _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableProduct (
        id INTEGER PRIMARY KEY,
        product_id INTEGER,
        name TEXT,
        categoryId INTEGER,
        categoryName TEXT,
        description TEXT,
        image TEXT,
        price TEXT,
        stock INTEGER,
        status INTEGER,
        isFavorite INTEGER,
        createdAt TEXT,
        updatedAt TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE $tableOrder (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        payment_amount INTEGER,
        sub_total INTEGER,
        tax INTEGER,
        discount INTEGER,
        discount_amount INTEGER,
        service_charge INTEGER,
        total INTEGER,
        payment_method TEXT,
        total_item INTEGER,
        id_kasir INTEGER,
        nama_kasir TEXT,
        transaction_time TEXT,
        table_number INTEGER,
        customer_name TEXT,
        status TEXT,
        payment_status TEXT,
        is_sync INTEGER DEFAULT 0,
        order_type TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE $tableOrderItem (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        id_order INTEGER,
        id_product INTEGER,
        quantity INTEGER,
        price INTEGER
      )
    ''');

    await db.execute('''
        CREATE TABLE $tableManagement (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        table_number INTEGER,
        start_time Text,
        order_id INTEGER,
        payment_amount INTEGER,
        status TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE draft_orders (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        total_item INTEGER,
        subtotal INTEGER,
        tax INTEGER,
        discount INTEGER,
        discount_amount INTEGER,
        service_charge INTEGER,
        total INTEGER,
        transaction_time TEXT,
        table_number INTEGER,
        draft_name TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE draft_order_items (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        id_draft_order INTEGER,
        id_product INTEGER,
        quantity INTEGER,
        price INTEGER
      )
    ''');
  }

  // Add database migration function
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    log('Database upgrade from $oldVersion to $newVersion');

    if (oldVersion < 2) {
      // Adding order_type column to orders table for version 2
      try {
        await db.execute('ALTER TABLE $tableOrder ADD COLUMN order_type TEXT');
        log('Added order_type column to $tableOrder table');
      } catch (e) {
        log('Error adding order_type column: ${e.toString()}');
      }
    }
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = dbPath + filePath;
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _createDb,
      onUpgrade: _onUpgrade,
    );
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('dbresto30.db');
    return _database!;
  }

  Future<int> saveOrder(OrderModel order) async {
    log("OrderModel:  ${order.toMap()}");

    final db = await instance.database;

    try {
      // Try saving the full order first
      int id = await db.insert(tableOrder, order.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);

      for (var item in order.orderItems) {
        await db.insert(tableOrderItem, item.toLocalMap(id),
            conflictAlgorithm: ConflictAlgorithm.replace);
      }

      log("Success Order: ${order.toMap()}");
      return id;
    } catch (e) {
      log("Error saving order with order_type: ${e.toString()}");

      // If the error is about order_type, try again without it
      if (e.toString().contains("order_type")) {
        Map<String, dynamic> orderMap = Map.from(order.toMap());
        orderMap.remove('order_type');

        log("Retrying without order_type field: $orderMap");

        int id = await db.insert(tableOrder, orderMap,
            conflictAlgorithm: ConflictAlgorithm.replace);

        for (var item in order.orderItems) {
          await db.insert(tableOrderItem, item.toLocalMap(id),
              conflictAlgorithm: ConflictAlgorithm.replace);
        }

        log("Success Order without order_type: $orderMap");
        return id;
      } else {
        // If it's not an order_type error, rethrow
        rethrow;
      }
    }
  }

  Future<List<OrderModel>> getOrderByIsNotSync() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps =
        await db.query(tableOrder, where: 'is_sync = ?', whereArgs: [0]);
    return List.generate(maps.length, (i) {
      return OrderModel.fromMap(maps[i]);
    });
  }

  Future<List<OrderModel>> getAllOrder(
    DateTime date,
  ) async {
    final db = await instance.database;

    final dateIso = date.toIso8601String();

    final dateYYYYMMDD = dateIso.substring(0, 10);

    final List<Map<String, dynamic>> maps = await db.query(
      tableOrder,
      where: 'transaction_time like ?',
      whereArgs: ['$dateYYYYMMDD%'],
    );
    return List.generate(maps.length, (i) {
      log("OrderModel: ${OrderModel.fromMap(maps[i])}");
      return OrderModel.fromMap(maps[i]);
    });
  }

  Future<List<ProductQuantity>> getOrderItemByOrderId(int orderId) async {
    final db = await instance.database;
    final List<Map<String, dynamic>> orderItems = await db
        .query(tableOrderItem, where: 'id_order = ?', whereArgs: [orderId]);

    List<ProductQuantity> result = [];

    for (var item in orderItems) {
      final int productId = item['id_product'];

      // Get full product information from products table
      List<Map<String, dynamic>> productData = await db.query(
        tableProduct,
        where: 'product_id = ?',
        whereArgs: [productId],
      );

      // If not found by product_id, try with id
      if (productData.isEmpty) {
        productData = await db.query(
          tableProduct,
          where: 'id = ?',
          whereArgs: [productId],
        );
      }

      if (productData.isNotEmpty) {
        // Create a product with complete information
        final product = Product.fromLocalMap(productData.first);

        result.add(ProductQuantity(
          product: product,
          quantity: item['quantity'],
        ));

        log("Complete product loaded: ID=${product.id}, Name=${product.name}, Price=${product.price}");
      } else {
        // Fallback to basic product information
        log("Product not found in database, using basic info for ID: $productId");
        result.add(ProductQuantity.fromLocalMap(item));
      }
    }

    return result;
  }

  Future<void> updatePaymentStatus(
      int orderId, String paymentStatus, String status) async {
    final db = await instance.database;
    await db.update(
        tableOrder, {'payment_status': paymentStatus, 'status': status},
        where: 'id = ?', whereArgs: [orderId]);
    log('update payment status success | order id: $orderId | payment status: $paymentStatus | status: $status');
  }

  Future<void> updateOrderIsSync(int orderId) async {
    final db = await instance.database;
    await db.update(tableOrder, {'is_sync': 1},
        where: 'id = ?', whereArgs: [orderId]);
  }

  Future<void> insertProduct(Product product) async {
    log("Product: ${product.toMap()}");
    final db = await instance.database;
    await db.insert(tableProduct, product.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> insertProducts(List<Product> products) async {
    final db = await instance.database;
    for (var product in products) {
      await db.insert(tableProduct, product.toLocalMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
      print(
          'inserted success id: ${product.productId} | name: ${product.name} | price: ${product.price}');
    }
  }

  Future<List<Product>> getProducts() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(tableProduct);
    return List.generate(maps.length, (i) {
      return Product.fromLocalMap(maps[i]);
    });
  }

  Future<Product?> getProductById(int id) async {
    final db = await instance.database;
    final result =
        await db.query(tableProduct, where: 'product_id = ?', whereArgs: [id]);

    if (result.isEmpty) {
      return null;
    }

    return Product.fromMap(result.first);
  }

  Future<TableModel?> getLastTableManagement() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps =
        await db.query(tableManagement, orderBy: 'id DESC', limit: 1);
    if (maps.isEmpty) {
      return null;
    }
    return TableModel.fromMap(maps[0]);
  }

  Future<void> generateTableManagement(int count) async {
    final db = await instance.database;
    TableModel? lastTable = await getLastTableManagement();
    int lastTableNumber = lastTable?.tableNumber ?? 0;
    for (int i = 1; i <= count; i++) {
      lastTableNumber++;
      TableModel newTable = TableModel(
        tableNumber: lastTableNumber,
        status: 'available',
        orderId: 0,
        paymentAmount: 0,
        startTime: DateTime.now().toIso8601String(),
      );
      await db.insert(
        tableManagement,
        newTable.toMap(),
      );
    }
  }

  Future<List<TableModel>> getAllTable() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(tableManagement);
    log("Table Management: $maps");
    return List.generate(maps.length, (i) {
      return TableModel.fromMap(maps[i]);
    });
  }

  Future<OrderModel?> getLastOrderTable(int tableNumber) async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      tableOrder,
      where: 'table_number = ?',
      whereArgs: [tableNumber],
      orderBy: 'id DESC',
      limit: 1,
    );

    if (maps.isEmpty) {
      return null;
    }

    return OrderModel.fromMap(maps[0]);
  }

  Future<List<TableModel>> getTableByStatus(String status) async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      tableManagement,
      where: 'status = ?',
      whereArgs: [status],
    );

    return List.generate(maps.length, (i) {
      return TableModel.fromMap(maps[i]);
    });
  }

  Future<void> updateStatusTable(TableModel table) async {
    log("Table: ${table.toMap()}");
    final db = await instance.database;
    await db.update(tableManagement, table.toMap(),
        where: 'id = ?', whereArgs: [table.id]);
    log("Success Update Status Table: ${table.toMap()}");
  }

  Future<void> deleteAllProducts() async {
    final db = await instance.database;
    await db.delete(tableProduct);
  }

  Future<int> saveDraftOrder(DraftOrderModel order) async {
    log("save draft order: ${order.toMapForLocal()}");
    final db = await instance.database;
    int id = await db.insert('draft_orders', order.toMapForLocal());
    log("draft order id: $id | ${order.discountAmount}");
    for (var orderItem in order.orders) {
      await db.insert('draft_order_items', orderItem.toMapForLocal(id));
      log("draft order item  ${orderItem.toMapForLocal(id)}");
    }

    return id;
  }

  Future<List<DraftOrderModel>> getAllDraftOrder() async {
    final db = await instance.database;
    final result = await db.query('draft_orders', orderBy: 'id ASC');

    List<DraftOrderModel> results = await Future.wait(result.map((item) async {
      final draftOrderItem =
          await getDraftOrderItemByOrderId(item['id'] as int);
      return DraftOrderModel.newFromLocalMap(item, draftOrderItem);
    }));
    return results;
  }

  Future<DraftOrderModel?> getDraftOrderById(int id) async {
    final db = await instance.database;
    final result =
        await db.query('draft_orders', where: 'id = ?', whereArgs: [id]);
    if (result.isEmpty) {
      return null;
    }
    final draftOrderItem =
        await getDraftOrderItemByOrderId(result.first['id'] as int);
    log("draft order item: $draftOrderItem | ${result.first.toString()}");
    return DraftOrderModel.newFromLocalMap(result.first, draftOrderItem);
  }

  Future<List<DraftOrderItem>> getDraftOrderItemByOrderId(int idOrder) async {
    final db = await instance.database;
    final result =
        await db.query('draft_order_items', where: 'id_draft_order = $idOrder');

    List<DraftOrderItem> results = await Future.wait(result.map((item) async {
      final product = await getProductById(item['id_product'] as int);
      return DraftOrderItem(
          product: product!, quantity: item['quantity'] as int);
    }));
    return results;
  }

  Future<void> removeDraftOrderById(int id) async {
    final db = await instance.database;
    await db.delete('draft_orders', where: 'id = ?', whereArgs: [id]);
    await db.delete('draft_order_items',
        where: 'id_draft_order = ?', whereArgs: [id]);
  }
}
