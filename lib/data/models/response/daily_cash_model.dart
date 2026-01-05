// Updated DailyCashModel that correctly handles all fields including createdAt
import 'dart:convert';

class DailyCashModel {
  final int? id;
  final int? outletId;
  final int? userId;
  final String? date;
  final String? shiftName;
  final String? openedAt;
  final String? closedAt;
  final int? closedBy;
  final bool? isClosed;
  final int? openingBalance;
  final int? expenses;
  final String? expensesNote;
  final dynamic cashSales;
  final dynamic qrisSales;
  final int? qrisFee;
  final int? effectiveExpenses;
  final int? closingBalance;
  final dynamic finalCashClosing;
  final String? createdAt;
  final String? updatedAt;

  DailyCashModel({
    this.id,
    this.outletId,
    this.userId,
    this.date,
    this.shiftName,
    this.openedAt,
    this.closedAt,
    this.closedBy,
    this.isClosed,
    this.openingBalance,
    this.expenses,
    this.expensesNote,
    this.cashSales,
    this.qrisSales,
    this.qrisFee,
    this.effectiveExpenses,
    this.closingBalance,
    this.finalCashClosing,
    this.createdAt,
    this.updatedAt,
  });

  factory DailyCashModel.fromMap(Map<String, dynamic> map) {
    // Handle date field - bisa string atau object
    String? dateValue;
    if (map['date'] != null) {
      if (map['date'] is String) {
        dateValue = map['date'];
      } else {
        // Jika object (Carbon instance dari Laravel), ambil value-nya
        dateValue = map['date'].toString();
      }
    }

    return DailyCashModel(
      id: map['id'] is int ? map['id'] : (map['id'] != null ? int.tryParse(map['id'].toString()) : null),
      outletId: map['outlet_id'] is int ? map['outlet_id'] : (map['outlet_id'] != null ? int.tryParse(map['outlet_id'].toString()) : null),
      userId: map['user_id'] is int ? map['user_id'] : (map['user_id'] != null ? int.tryParse(map['user_id'].toString()) : null),
      date: dateValue,
      shiftName: map['shift_name']?.toString(),
      openedAt: map['opened_at']?.toString(),
      closedAt: map['closed_at']?.toString(),
      closedBy: map['closed_by'] is int ? map['closed_by'] : (map['closed_by'] != null ? int.tryParse(map['closed_by'].toString()) : null),
      isClosed: map['is_closed'] ?? (map['closed_at'] != null),
      openingBalance: map['opening_balance'] is int ? map['opening_balance'] : (map['opening_balance'] != null ? int.tryParse(map['opening_balance'].toString()) : null),
      expenses: map['expenses'] is int ? map['expenses'] : (map['expenses'] != null ? int.tryParse(map['expenses'].toString()) : null),
      expensesNote: map['expenses_note']?.toString(),
      cashSales: map['cash_sales'],
      qrisSales: map['qris_sales'],
      qrisFee: map['qris_fee'] is int ? map['qris_fee'] : (map['qris_fee'] != null ? int.tryParse(map['qris_fee'].toString()) : null),
      effectiveExpenses: map['effective_expenses'] is int ? map['effective_expenses'] : (map['effective_expenses'] != null ? int.tryParse(map['effective_expenses'].toString()) : null),
      closingBalance: map['closing_balance'] is int ? map['closing_balance'] : (map['closing_balance'] != null ? int.tryParse(map['closing_balance'].toString()) : null),
      finalCashClosing: map['final_cash_closing'],
      createdAt: map['created_at']?.toString(),
      updatedAt: map['updated_at']?.toString(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'outlet_id': outletId,
      'user_id': userId,
      'date': date,
      'shift_name': shiftName,
      'opened_at': openedAt,
      'closed_at': closedAt,
      'closed_by': closedBy,
      'is_closed': isClosed,
      'opening_balance': openingBalance,
      'expenses': expenses,
      'expenses_note': expensesNote,
      'cash_sales': cashSales,
      'qris_sales': qrisSales,
      'qris_fee': qrisFee,
      'effective_expenses': effectiveExpenses,
      'closing_balance': closingBalance,
      'final_cash_closing': finalCashClosing,
      'created_at': createdAt,
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

  int? getQrisSalesAsInt() {
    if (qrisSales == null) {
      return null;
    }

    if (qrisSales is int) {
      return qrisSales as int;
    }

    if (qrisSales is String) {
      return int.tryParse(qrisSales as String) ?? 0;
    }

    if (qrisSales is double) {
      return qrisSales.toInt();
    }

    return 0;
  }

  int? getFinalCashClosingAsInt() {
    if (finalCashClosing == null) {
      return null;
    }

    if (finalCashClosing is int) {
      return finalCashClosing as int;
    }

    if (finalCashClosing is String) {
      return int.tryParse(finalCashClosing as String) ?? 0;
    }

    if (finalCashClosing is double) {
      return finalCashClosing.toInt();
    }

    return 0;
  }
}

class DailyCashResponse {
  final String status;
  final String? message;
  final dynamic data; // Bisa DailyCashModel atau List<DailyCashModel>
  final int? activeShift; // ID shift aktif (jika ada)

  DailyCashResponse({
    required this.status,
    this.message,
    required this.data,
    this.activeShift,
  });

  factory DailyCashResponse.fromMap(Map<String, dynamic> map) {
    dynamic dataValue;
    
    // Handle jika data adalah array (multiple shifts)
    if (map['data'] is List) {
      dataValue = (map['data'] as List)
          .map((item) {
            if (item is Map<String, dynamic>) {
              return DailyCashModel.fromMap(item);
            } else {
              // Handle jika item bukan Map (shouldn't happen, but safe)
              return DailyCashModel.fromMap({});
            }
          })
          .toList();
    } else if (map['data'] is Map) {
      // Handle jika data adalah single object
      dataValue = DailyCashModel.fromMap(map['data'] as Map<String, dynamic>);
    } else {
      // Jika data null atau format tidak dikenal
      dataValue = null;
    }

    return DailyCashResponse(
      status: map['status'] ?? '',
      message: map['message'],
      data: dataValue,
      activeShift: map['active_shift'] is int 
          ? map['active_shift'] 
          : (map['active_shift'] != null ? int.tryParse(map['active_shift'].toString()) : null),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'message': message,
      'data': data is List
          ? (data as List).map((item) => (item as DailyCashModel).toMap()).toList()
          : (data as DailyCashModel).toMap(),
      'active_shift': activeShift,
    };
  }

  String toJson() => json.encode(toMap());

  factory DailyCashResponse.fromJson(String source) =>
      DailyCashResponse.fromMap(json.decode(source));

  // Helper method untuk mendapatkan single data
  DailyCashModel? getSingleData() {
    if (data is DailyCashModel) {
      return data as DailyCashModel;
    }
    return null;
  }

  // Helper method untuk mendapatkan list data
  List<DailyCashModel>? getListData() {
    if (data is List) {
      return data as List<DailyCashModel>;
    }
    return null;
  }
}
