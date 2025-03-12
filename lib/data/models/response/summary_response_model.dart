import 'dart:convert';

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
  final String totalRevenue;
  final String totalDiscount;
  final String totalTax;
  final String totalSubtotal;
  final dynamic totalServiceCharge;
  final int? openingBalance;
  final int? expenses;
  final dynamic cashSales;
  final dynamic qrisSales;
  final dynamic beverageSales;
  final int? closingBalance;
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
    this.beverageSales,
    this.closingBalance,
    this.paymentMethods,
    this.dailyBreakdown,
    required this.outletId,
  });

  factory EnhancedSummaryData.fromJson(Map<String, dynamic> json) {
    return EnhancedSummaryData(
      totalRevenue: json['total_revenue'] ?? '0',
      totalDiscount: json['total_discount'] ?? '0.00',
      totalTax: json['total_tax'] ?? '0',
      totalSubtotal: json['total_subtotal'] ?? '0',
      totalServiceCharge: json['total_service_charge'] ?? 0,
      openingBalance: json['opening_balance'],
      expenses: json['expenses'],
      cashSales: json['cash_sales'],
      qrisSales: json['qris_sales'],
      beverageSales: json['beverage_sales'],
      closingBalance: json['closing_balance'],
      paymentMethods: json['payment_methods'] != null
          ? PaymentMethods.fromJson(json['payment_methods'])
          : null,
      dailyBreakdown: json['daily_breakdown'] != null
          ? (json['daily_breakdown'] as List)
              .map((i) => DailyBreakdown.fromJson(i))
              .toList()
          : null,
      outletId: json['outlet_id'] ?? 0,
    );
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
        'beverage_sales': beverageSales,
        'closing_balance': closingBalance,
        'payment_methods': paymentMethods?.toJson(),
        'daily_breakdown': dailyBreakdown?.map((e) => e.toJson()).toList(),
        'outlet_id': outletId,
      };

  // Helper methods to safely parse values
  int getTotalRevenueAsInt() {
    try {
      return int.parse(totalRevenue);
    } catch (e) {
      return 0;
    }
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
  int getTotal() {
    return closingBalance ?? 0;
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
    return PaymentMethods(
      cash: json['cash'] != null
          ? PaymentMethodDetail.fromJson(json['cash'])
          : null,
      qris: json['qris'] != null
          ? PaymentMethodDetail.fromJson(json['qris'])
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

  PaymentMethodDetail({
    required this.count,
    required this.total,
  });

  factory PaymentMethodDetail.fromJson(Map<String, dynamic> json) {
    return PaymentMethodDetail(
      count: json['count'] ?? 0,
      total: json['total'],
    );
  }

  Map<String, dynamic> toJson() => {
        'count': count,
        'total': total,
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
  final int? openingBalance;
  final int? expenses;
  final dynamic cashSales;
  final dynamic qrisSales;
  final int? totalSales;
  final int? closingBalance;

  DailyBreakdown({
    required this.date,
    this.openingBalance,
    this.expenses,
    this.cashSales,
    this.qrisSales,
    this.totalSales,
    this.closingBalance,
  });

  factory DailyBreakdown.fromJson(Map<String, dynamic> json) {
    return DailyBreakdown(
      date: json['date'] ?? '',
      openingBalance: json['opening_balance'],
      expenses: json['expenses'],
      cashSales: json['cash_sales'],
      qrisSales: json['qris_sales'],
      totalSales: json['total_sales'],
      closingBalance: json['closing_balance'],
    );
  }

  Map<String, dynamic> toJson() => {
        'date': date,
        'opening_balance': openingBalance,
        'expenses': expenses,
        'cash_sales': cashSales,
        'qris_sales': qrisSales,
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
