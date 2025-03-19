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
  final double? closingBalance;
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
    this.closingBalance,
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
      closingBalance: _parseToDouble(json['closing_balance']),
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
        'closing_balance': closingBalance,
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

  // For backward compatibility with existing code
  double getTotal() {
    return closingBalance ?? 0.0;
  }
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
        'Cash': cash?.toJson(),
        'QRIS': qris?.toJson(),
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

  DailyBreakdown({
    required this.date,
    this.openingBalance,
    this.expenses,
    this.cashSales,
    this.qrisSales,
    this.qrisFee,
    this.totalSales,
    this.closingBalance,
  });

  factory DailyBreakdown.fromJson(Map<String, dynamic> json) {
    return DailyBreakdown(
      date: json['date'] ?? '',
      openingBalance: _parseToDouble(json['opening_balance']),
      expenses: _parseToDouble(json['expenses']),
      cashSales: json['cash_sales'] ?? 0,
      qrisSales: json['qris_sales'] ?? 0,
      qrisFee: json['qris_fee'] ?? '0.00',
      totalSales: json['total_sales'] ?? 0,
      closingBalance: _parseToDouble(json['closing_balance']),
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
}
