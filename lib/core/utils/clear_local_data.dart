import 'dart:developer';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:seblak_sulthane_app/data/datasources/auth_local_datasource.dart';
import 'package:seblak_sulthane_app/data/datasources/outlet_datasource.dart';
import 'package:seblak_sulthane_app/data/datasources/product_local_datasource.dart';
import 'package:seblak_sulthane_app/data/datasources/member_local_datasource.dart';
import 'package:seblak_sulthane_app/data/datasources/discount_local_datasource.dart';

class ClearLocalData {
  /// Clear all local data including SharedPreferences and SQLite database
  static Future<bool> clearAllData() async {
    try {
      log('🗑️ Starting to clear all local data...');

      // 1. Clear SharedPreferences
      await _clearSharedPreferences();

      // 2. Clear SQLite Database
      await _clearSQLiteDatabase();

      log('✅ Successfully cleared all local data');
      return true;
    } catch (e) {
      log('❌ Error clearing local data: $e');
      return false;
    }
  }

  /// Clear all SharedPreferences data
  static Future<void> _clearSharedPreferences() async {
    try {
      log('📦 Clearing SharedPreferences...');
      final prefs = await SharedPreferences.getInstance();

      // Clear auth data
      final authDataSource = AuthLocalDataSource();
      await authDataSource.removeAuthData();
      log('  ✓ Cleared auth data');

      // Clear outlet data
      final outletDataSource = OutletLocalDataSource();
      await outletDataSource.clearOutlets();
      log('  ✓ Cleared outlet data');

      // Clear all other SharedPreferences keys
      await prefs.clear();
      log('  ✓ Cleared all SharedPreferences');
    } catch (e) {
      log('  ✗ Error clearing SharedPreferences: $e');
      rethrow;
    }
  }

  /// Clear all SQLite database tables
  static Future<void> _clearSQLiteDatabase() async {
    try {
      log('🗄️ Clearing SQLite database...');

      // Get database path
      final dbPath = join(await getDatabasesPath(), 'seblak_sulthane.db');

      // Open database
      final db = await openDatabase(dbPath);

      // Clear all tables
      await db.delete('products');
      log('  ✓ Cleared products table');

      await db.delete('orders');
      log('  ✓ Cleared orders table');

      await db.delete('order_items');
      log('  ✓ Cleared order_items table');

      await db.delete('table_management');
      log('  ✓ Cleared table_management table');

      await db.delete('draft_orders');
      log('  ✓ Cleared draft_orders table');

      await db.delete('draft_order_items');
      log('  ✓ Cleared draft_order_items table');

      // Categories are stored in SharedPreferences, not SQLite
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('cached_categories');
      log('  ✓ Cleared categories');

      await db.delete('members');
      log('  ✓ Cleared members table');

      await db.delete('discounts');
      log('  ✓ Cleared discounts table');

      // Close database
      await db.close();
      log('  ✓ Database cleared and closed');
    } catch (e) {
      log('  ✗ Error clearing SQLite database: $e');
      // If database doesn't exist or error, try to delete the file
      try {
        final dbPath = join(await getDatabasesPath(), 'seblak_sulthane.db');
        await deleteDatabase(dbPath);
        log('  ✓ Deleted database file');
      } catch (deleteError) {
        log('  ✗ Error deleting database file: $deleteError');
      }
    }
  }

  /// Alternative: Delete entire database file (more thorough)
  static Future<bool> deleteDatabaseFile() async {
    try {
      log('🗑️ Deleting database file...');
      final dbPath = join(await getDatabasesPath(), 'seblak_sulthane.db');
      await deleteDatabase(dbPath);
      log('✅ Database file deleted successfully');
      return true;
    } catch (e) {
      log('❌ Error deleting database file: $e');
      return false;
    }
  }

  /// Clear only specific data (for selective clearing)
  static Future<void> clearSpecificData({
    bool clearAuth = false,
    bool clearProducts = false,
    bool clearOrders = false,
    bool clearMembers = false,
    bool clearDiscounts = false,
    bool clearCategories = false,
    bool clearSettings = false,
  }) async {
    try {
      log('🎯 Clearing specific data...');

      if (clearAuth) {
        final authDataSource = AuthLocalDataSource();
        await authDataSource.removeAuthData();
        log('  ✓ Cleared auth data');
      }

      if (clearProducts) {
        final productDataSource = ProductLocalDatasource.instance;
        await productDataSource.deleteAllProducts();
        log('  ✓ Cleared products');
      }

      if (clearOrders) {
        final dbPath = join(await getDatabasesPath(), 'seblak_sulthane.db');
        final db = await openDatabase(dbPath);
        await db.delete('orders');
        await db.delete('order_items');
        await db.delete('draft_orders');
        await db.delete('draft_order_items');
        await db.close();
        log('  ✓ Cleared orders');
      }

      if (clearMembers) {
        final memberDataSource = MemberLocalDatasource.instance;
        final db = await memberDataSource.database;
        await db.delete('members');
        log('  ✓ Cleared members');
      }

      if (clearDiscounts) {
        final discountDataSource = DiscountLocalDatasource();
        final db = await discountDataSource.database;
        await db.delete('discounts');
        log('  ✓ Cleared discounts');
      }

      if (clearCategories) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove('cached_categories');
        log('  ✓ Cleared categories');
      }

      if (clearSettings) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove('tax');
        await prefs.remove('serviceCharge');
        await prefs.remove('sizeReceipt');
        log('  ✓ Cleared settings');
      }

      log('✅ Specific data cleared successfully');
    } catch (e) {
      log('❌ Error clearing specific data: $e');
      rethrow;
    }
  }
}
