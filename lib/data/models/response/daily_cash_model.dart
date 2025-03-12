// Updated DailyCashModel that correctly handles all fields including createdAt
import 'dart:convert';

class DailyCashModel {
  final int? id;
  final int? outletId;
  final int? userId;
  final String? date;
  final int? openingBalance;
  final int? expenses;
  final String? expensesNote;
  final dynamic cashSales;
  final int? closingBalance;
  final String? createdAt; // Ensure this field is properly defined
  final String? updatedAt;

  DailyCashModel({
    this.id,
    this.outletId,
    this.userId,
    this.date,
    this.openingBalance,
    this.expenses,
    this.expensesNote,
    this.cashSales,
    this.closingBalance,
    this.createdAt, // Include in constructor
    this.updatedAt,
  });

  factory DailyCashModel.fromMap(Map<String, dynamic> map) {
    // Debug print to check for createdAt
    if (map.containsKey('created_at')) {
      print("DEBUG: Found created_at in map: ${map['created_at']}");
    } else {
      print("DEBUG: No created_at in map. Keys: ${map.keys.toList()}");
    }

    return DailyCashModel(
      id: map['id'],
      outletId: map['outlet_id'],
      userId: map['user_id'],
      date: map['date'],
      openingBalance: map['opening_balance'],
      expenses: map['expenses'],
      expensesNote: map['expenses_note'],
      cashSales: map['cash_sales'],
      closingBalance: map['closing_balance'],
      createdAt: map['created_at'], // Extract from map
      updatedAt: map['updated_at'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'outlet_id': outletId,
      'user_id': userId,
      'date': date,
      'opening_balance': openingBalance,
      'expenses': expenses,
      'expenses_note': expensesNote,
      'cash_sales': cashSales,
      'closing_balance': closingBalance,
      'created_at': createdAt, // Include in map
      'updated_at': updatedAt,
    };
  }

  String toJson() => json.encode(toMap());

  factory DailyCashModel.fromJson(String source) =>
      DailyCashModel.fromMap(json.decode(source));

  int? getCashSalesAsInt() {
    if (cashSales == null) {
      return null;
    }

    if (cashSales is int) {
      return cashSales as int;
    }

    if (cashSales is String) {
      return int.tryParse(cashSales as String) ?? 0;
    }

    return 0;
  }
}

class DailyCashResponse {
  final String status;
  final String? message;
  final DailyCashModel data;

  DailyCashResponse({
    required this.status,
    this.message,
    required this.data,
  });

  factory DailyCashResponse.fromMap(Map<String, dynamic> map) {
    return DailyCashResponse(
      status: map['status'] ?? '',
      message: map['message'],
      data: DailyCashModel.fromMap(map['data'] ?? {}),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'message': message,
      'data': data.toMap(),
    };
  }

  String toJson() => json.encode(toMap());

  factory DailyCashResponse.fromJson(String source) =>
      DailyCashResponse.fromMap(json.decode(source));
}
