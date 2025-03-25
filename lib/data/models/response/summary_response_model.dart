import 'dart:convert';
import 'dart:developer';

class SummaryResponseModel {
  final String? status;
  final EnhancedSummaryData? data;

  const SummaryResponseModel({
    this.status,
    this.data,
  });

  factory SummaryResponseModel.fromJson(Map<String, dynamic> json) {
    return SummaryResponseModel(
      status: json['status'],
      data: json['data'] != null
          ? EnhancedSummaryData.fromJson(json['data'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'data': data?.toJson(),
      };
}

class EnhancedSummaryData {
  final dynamic totalRevenue;
  final dynamic totalDiscount;
  final dynamic totalTax;
  final dynamic totalSubtotal;
  final dynamic totalServiceCharge;
  final double? openingBalance;
  final double? expenses;
  final dynamic cashSales;
  final dynamic qrisSales;
  final dynamic qrisFee;
  final dynamic beverageSales;
  final BeverageBreakdown? beverageBreakdown;
  final double? closingBalance;
  final dynamic finalCashClosing;
  final PaymentMethods? paymentMethods;
  final List<DailyBreakdown>? dailyBreakdown;
  final int outletId;

  const EnhancedSummaryData({
    required this.totalRevenue,
    required this.totalDiscount,
    required this.totalTax,
    required this.totalSubtotal,
    required this.totalServiceCharge,
    this.openingBalance,
    this.expenses,
    this.cashSales,
    this.qrisSales,
    this.qrisFee,
    this.beverageSales,
    this.beverageBreakdown,
    this.closingBalance,
    this.finalCashClosing,
    this.paymentMethods,
    this.dailyBreakdown,
    required this.outletId,
  });

  factory EnhancedSummaryData.fromJson(Map<String, dynamic> json) {
    // Handle payment_methods that could be an empty array or a map
    PaymentMethods? paymentMethodsObj;
    try {
      if (json['payment_methods'] != null) {
        if (json['payment_methods'] is Map) {
          paymentMethodsObj = PaymentMethods.fromJson(json['payment_methods']);
        } else if (json['payment_methods'] is List &&
            (json['payment_methods'] as List).isEmpty) {
          // Handle empty array case
          paymentMethodsObj = null;
        } else {
          log("Unexpected payment_methods format: ${json['payment_methods']}");
          paymentMethodsObj = null;
        }
      }
    } catch (e) {
      log("Error parsing payment_methods: $e");
      paymentMethodsObj = null;
    }

    // Parse beverage_breakdown
    BeverageBreakdown? beverageBreakdownObj;
    if (json['beverage_breakdown'] != null) {
      try {
        beverageBreakdownObj =
            BeverageBreakdown.fromJson(json['beverage_breakdown']);
      } catch (e) {
        log("Error parsing beverage_breakdown: $e");
        beverageBreakdownObj = null;
      }
    }

    return EnhancedSummaryData(
      totalRevenue: json['total_revenue'] ?? 0,
      totalDiscount: json['total_discount'] ?? 0,
      totalTax: json['total_tax'] ?? 0,
      totalSubtotal: json['total_subtotal'] ?? 0,
      totalServiceCharge: json['total_service_charge'] ?? 0,
      openingBalance: _parseToDouble(json['opening_balance']),
      expenses: _parseToDouble(json['expenses']),
      cashSales: json['cash_sales'] ?? 0,
      qrisSales: json['qris_sales'] ?? 0,
      qrisFee: json['qris_fee'] ?? '0.00',
      beverageSales: json['beverage_sales'] ?? 0,
      beverageBreakdown: beverageBreakdownObj,
      closingBalance: _parseToDouble(json['closing_balance']),
      finalCashClosing: json['final_cash_closing'] ?? 0,
      paymentMethods: paymentMethodsObj,
      dailyBreakdown: json['daily_breakdown'] != null
          ? (json['daily_breakdown'] as List)
              .map((i) => DailyBreakdown.fromJson(i))
              .toList()
          : null,
      outletId: json['outlet_id'] ?? 0,
    );
  }

  // Helper method to safely parse numeric values to double
  static double? _parseToDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) {
      try {
        return double.parse(value);
      } catch (_) {
        return null;
      }
    }
    return null;
  }

  Map<String, dynamic> toJson() => {
        'total_revenue': totalRevenue,
        'total_discount': totalDiscount,
        'total_tax': totalTax,
        'total_subtotal': totalSubtotal,
        'total_service_charge': totalServiceCharge,
        'opening_balance': openingBalance,
        'expenses': expenses,
        'cash_sales': cashSales,
        'qris_sales': qrisSales,
        'qris_fee': qrisFee,
        'beverage_sales': beverageSales,
        'beverage_breakdown': beverageBreakdown?.toJson(),
        'closing_balance': closingBalance,
        'final_cash_closing': finalCashClosing,
        'payment_methods': paymentMethods?.toJson(),
        'daily_breakdown': dailyBreakdown?.map((e) => e.toJson()).toList(),
        'outlet_id': outletId,
      };

  String getTotalRevenueAsString() {
    return totalRevenue?.toString() ?? '0';
  }

  String getTotalSubtotalAsString() {
    return totalSubtotal?.toString() ?? '0';
  }

  String getTotalDiscountAsString() {
    return totalDiscount?.toString() ?? '0';
  }

  String getTotalTaxAsString() {
    return totalTax?.toString() ?? '0';
  }

  int getTotalRevenueAsInt() {
    if (totalRevenue == null) return 0;
    if (totalRevenue is int) return totalRevenue as int;
    if (totalRevenue is String) {
      try {
        return int.parse(totalRevenue);
      } catch (e) {
        return 0;
      }
    }
    if (totalRevenue is double) {
      return totalRevenue.toInt();
    }
    return 0;
  }

  int getCashSalesAsInt() {
    if (cashSales == null) return 0;
    if (cashSales is int) return cashSales as int;
    if (cashSales is String) {
      if (cashSales.toString().isEmpty) return 0;
      try {
        return int.parse(cashSales as String);
      } catch (e) {
        try {
          return double.parse(cashSales as String).toInt();
        } catch (e) {
          return 0;
        }
      }
    }
    if (cashSales is double) {
      return cashSales.toInt();
    }
    if (cashSales is num) {
      return cashSales.toInt();
    }
    return 0;
  }

  int getQrisSalesAsInt() {
    if (qrisSales == null) return 0;
    if (qrisSales is int) return qrisSales as int;
    if (qrisSales is String) {
      if (qrisSales.toString().isEmpty) return 0;
      try {
        return int.parse(qrisSales as String);
      } catch (e) {
        try {
          return double.parse(qrisSales as String).toInt();
        } catch (e) {
          return 0;
        }
      }
    }
    if (qrisSales is double) {
      return qrisSales.toInt();
    }
    if (qrisSales is num) {
      return qrisSales.toInt();
    }
    return 0;
  }

  int getBeverageSalesAsInt() {
    if (beverageSales == null) return 0;
    if (beverageSales is int) return beverageSales as int;
    if (beverageSales is String) {
      if (beverageSales.toString().isEmpty) return 0;
      try {
        return int.parse(beverageSales as String);
      } catch (e) {
        try {
          return double.parse(beverageSales as String).toInt();
        } catch (e) {
          return 0;
        }
      }
    }
    if (beverageSales is double) {
      return beverageSales.toInt();
    }
    if (beverageSales is num) {
      return beverageSales.toInt();
    }
    return 0;
  }

  int getFinalCashClosingAsInt() {
    if (finalCashClosing == null) return 0;
    if (finalCashClosing is int) return finalCashClosing as int;
    if (finalCashClosing is String) {
      if (finalCashClosing.toString().isEmpty) return 0;
      try {
        return int.parse(finalCashClosing as String);
      } catch (e) {
        try {
          return double.parse(finalCashClosing as String).toInt();
        } catch (e) {
          return 0;
        }
      }
    }
    if (finalCashClosing is double) {
      return finalCashClosing.toInt();
    }
    if (finalCashClosing is num) {
      return finalCashClosing.toInt();
    }
    return 0;
  }

  // For backward compatibility with existing code
  double getTotal() {
    return closingBalance ?? 0.0;
  }
}

class BeverageBreakdown {
  final BeveragePayment? cash;
  final BeveragePayment? qris;
  final BeverageTotal? total;

  BeverageBreakdown({
    this.cash,
    this.qris,
    this.total,
  });

  factory BeverageBreakdown.fromJson(Map<String, dynamic> json) {
    return BeverageBreakdown(
      cash:
          json['cash'] != null ? BeveragePayment.fromJson(json['cash']) : null,
      qris:
          json['qris'] != null ? BeveragePayment.fromJson(json['qris']) : null,
      total:
          json['total'] != null ? BeverageTotal.fromJson(json['total']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'cash': cash?.toJson(),
        'qris': qris?.toJson(),
        'total': total?.toJson(),
      };
}

class BeveragePayment {
  final dynamic quantity;
  final dynamic amount;

  BeveragePayment({
    required this.quantity,
    required this.amount,
  });

  factory BeveragePayment.fromJson(Map<String, dynamic> json) {
    return BeveragePayment(
      quantity: json['quantity'] ?? 0,
      amount: json['amount'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'quantity': quantity,
        'amount': amount,
      };

  int getQuantityAsInt() {
    if (quantity == null) return 0;
    if (quantity is int) return quantity as int;
    if (quantity is String) {
      try {
        return int.parse(quantity as String);
      } catch (e) {
        try {
          return double.parse(quantity as String).toInt();
        } catch (e) {
          return 0;
        }
      }
    }
    if (quantity is double) {
      return quantity.toInt();
    }
    return 0;
  }

  int getAmountAsInt() {
    if (amount == null) return 0;
    if (amount is int) return amount as int;
    if (amount is String) {
      try {
        return int.parse(amount as String);
      } catch (e) {
        try {
          return double.parse(amount as String).toInt();
        } catch (e) {
          return 0;
        }
      }
    }
    if (amount is double) {
      return amount.toInt();
    }
    return 0;
  }
}

class BeverageTotal {
  final int quantity;
  final int amount;

  BeverageTotal({
    required this.quantity,
    required this.amount,
  });

  factory BeverageTotal.fromJson(Map<String, dynamic> json) {
    return BeverageTotal(
      quantity: json['quantity'] ?? 0,
      amount: json['amount'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'quantity': quantity,
        'amount': amount,
      };
}

class PaymentMethods {
  final PaymentMethodDetail? cash;
  final PaymentMethodDetail? qris;

  PaymentMethods({
    this.cash,
    this.qris,
  });

  factory PaymentMethods.fromJson(Map<String, dynamic> json) {
    // Handle case insensitive keys
    final cashKey = json.containsKey('Cash') ? 'Cash' : 'cash';
    final qrisKey = json.containsKey('QRIS') ? 'QRIS' : 'qris';

    return PaymentMethods(
      cash: json.containsKey(cashKey) && json[cashKey] != null
          ? PaymentMethodDetail.fromJson(json[cashKey])
          : null,
      qris: json.containsKey(qrisKey) && json[qrisKey] != null
          ? PaymentMethodDetail.fromJson(json[qrisKey])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'cash': cash?.toJson(),
        'qris': qris?.toJson(),
      };
}

class PaymentMethodDetail {
  final int count;
  final dynamic total;
  final dynamic qrisFees;

  PaymentMethodDetail({
    required this.count,
    required this.total,
    this.qrisFees,
  });

  factory PaymentMethodDetail.fromJson(Map<String, dynamic> json) {
    return PaymentMethodDetail(
      count: json['count'] ?? 0,
      total: json['total'] ?? 0,
      qrisFees: json['qris_fees'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'count': count,
        'total': total,
        'qris_fees': qrisFees,
      };

  int getTotalAsInt() {
    if (total == null) return 0;
    if (total is int) return total as int;
    if (total is String) {
      if (total.toString().isEmpty) return 0;
      try {
        return int.parse(total as String);
      } catch (e) {
        try {
          return double.parse(total as String).toInt();
        } catch (e) {
          return 0;
        }
      }
    }
    if (total is double) {
      return total.toInt();
    }
    if (total is num) {
      return total.toInt();
    }
    return 0;
  }
}

class DailyBreakdown {
  final String date;
  final double? openingBalance;
  final double? expenses;
  final dynamic cashSales;
  final dynamic qrisSales;
  final dynamic qrisFee;
  final dynamic totalSales;
  final double? closingBalance;
  final dynamic finalCashClosing;
  final BeverageBreakdown? beverageBreakdown;

  DailyBreakdown({
    required this.date,
    this.openingBalance,
    this.expenses,
    this.cashSales,
    this.qrisSales,
    this.qrisFee,
    this.totalSales,
    this.closingBalance,
    this.finalCashClosing,
    this.beverageBreakdown,
  });

  factory DailyBreakdown.fromJson(Map<String, dynamic> json) {
    // Parse beverage_breakdown
    BeverageBreakdown? beverageBreakdownObj;
    if (json['beverage_breakdown'] != null) {
      try {
        beverageBreakdownObj =
            BeverageBreakdown.fromJson(json['beverage_breakdown']);
      } catch (e) {
        log("Error parsing daily beverage_breakdown: $e");
        beverageBreakdownObj = null;
      }
    }

    return DailyBreakdown(
      date: json['date'] ?? '',
      openingBalance: _parseToDouble(json['opening_balance']),
      expenses: _parseToDouble(json['expenses']),
      cashSales: json['cash_sales'] ?? 0,
      qrisSales: json['qris_sales'] ?? 0,
      qrisFee: json['qris_fee'] ?? '0.00',
      totalSales: json['total_sales'] ?? 0,
      closingBalance: _parseToDouble(json['closing_balance']),
      finalCashClosing: json['final_cash_closing'] ?? 0,
      beverageBreakdown: beverageBreakdownObj,
    );
  }

  // Helper method to safely parse numeric values to double
  static double? _parseToDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) {
      try {
        return double.parse(value);
      } catch (_) {
        return null;
      }
    }
    return null;
  }

  Map<String, dynamic> toJson() => {
        'date': date,
        'opening_balance': openingBalance,
        'expenses': expenses,
        'cash_sales': cashSales,
        'qris_sales': qrisSales,
        'qris_fee': qrisFee,
        'total_sales': totalSales,
        'closing_balance': closingBalance,
        'final_cash_closing': finalCashClosing,
        'beverage_breakdown': beverageBreakdown?.toJson(),
      };

  int getCashSalesAsInt() {
    if (cashSales == null) return 0;
    if (cashSales is int) return cashSales as int;
    if (cashSales is String) {
      try {
        return int.parse(cashSales as String);
      } catch (e) {
        try {
          return double.parse(cashSales as String).toInt();
        } catch (e) {
          return 0;
        }
      }
    }
    if (cashSales is double) {
      return cashSales.toInt();
    }
    return 0;
  }

  int getQrisSalesAsInt() {
    if (qrisSales == null) return 0;
    if (qrisSales is int) return qrisSales as int;
    if (qrisSales is String) {
      if (qrisSales.toString().isEmpty) return 0;
      try {
        return int.parse(qrisSales as String);
      } catch (e) {
        try {
          return double.parse(qrisSales as String).toInt();
        } catch (e) {
          return 0;
        }
      }
    }
    if (qrisSales is double) {
      return qrisSales.toInt();
    }
    if (qrisSales is num) {
      return qrisSales.toInt();
    }
    return 0;
  }

  int getTotalSalesAsInt() {
    if (totalSales == null) return 0;
    if (totalSales is int) return totalSales as int;
    if (totalSales is String) {
      if (totalSales.toString().isEmpty) return 0;
      try {
        return int.parse(totalSales as String);
      } catch (e) {
        try {
          return double.parse(totalSales as String).toInt();
        } catch (e) {
          return 0;
        }
      }
    }
    if (totalSales is double) {
      return totalSales.toInt();
    }
    if (totalSales is num) {
      return totalSales.toInt();
    }
    return 0;
  }

  int getFinalCashClosingAsInt() {
    if (finalCashClosing == null) return 0;
    if (finalCashClosing is int) return finalCashClosing as int;
    if (finalCashClosing is String) {
      if (finalCashClosing.toString().isEmpty) return 0;
      try {
        return int.parse(finalCashClosing as String);
      } catch (e) {
        try {
          return double.parse(finalCashClosing as String).toInt();
        } catch (e) {
          return 0;
        }
      }
    }
    if (finalCashClosing is double) {
      return finalCashClosing.toInt();
    }
    if (finalCashClosing is num) {
      return finalCashClosing.toInt();
    }
    return 0;
  }
}
