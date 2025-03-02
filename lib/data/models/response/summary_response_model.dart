import 'dart:convert';

class SummaryResponseModel {
  final String? status;
  final SummaryData? data;

  const SummaryResponseModel({
    this.status,
    this.data,
  });

  factory SummaryResponseModel.fromJson(Map<String, dynamic> json) {
    return SummaryResponseModel(
      status: json['status'],
      data: json['data'] != null ? SummaryData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'data': data?.toJson(),
      };
}

class SummaryData {
  final String totalRevenue;
  final String totalDiscount;
  final String totalTax;
  final String totalSubtotal;
  final num totalServiceCharge;
  final num total;
  final int outletId;

  const SummaryData({
    required this.totalRevenue,
    required this.totalDiscount,
    required this.totalTax,
    required this.totalSubtotal,
    required this.totalServiceCharge,
    required this.total,
    required this.outletId,
  });

  factory SummaryData.fromJson(Map<String, dynamic> json) {
    return SummaryData(
      totalRevenue: json['total_revenue'],
      totalDiscount: json['total_discount'],
      totalTax: json['total_tax'],
      totalSubtotal: json['total_subtotal'],
      totalServiceCharge: json['total_service_charge'],
      total: json['total'],
      outletId: json['outlet_id'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'total_revenue': totalRevenue,
        'total_discount': totalDiscount,
        'total_tax': totalTax,
        'total_subtotal': totalSubtotal,
        'total_service_charge': totalServiceCharge,
        'total': total,
        'outlet_id': outletId,
      };
}
