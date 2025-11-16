import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';
import 'package:seblak_sulthane_app/core/components/buttons.dart';
import 'package:seblak_sulthane_app/core/components/spaces.dart';
import 'package:seblak_sulthane_app/core/constants/colors.dart';
import 'package:seblak_sulthane_app/core/extensions/date_time_ext.dart';
import 'package:seblak_sulthane_app/core/extensions/int_ext.dart';
import 'package:seblak_sulthane_app/data/dataoutputs/print_dataoutputs.dart';
import 'package:seblak_sulthane_app/data/datasources/auth_local_datasource.dart';
import 'package:seblak_sulthane_app/data/datasources/order_remote_datasource.dart';
import 'package:seblak_sulthane_app/data/models/response/order_response_model.dart';
import 'package:seblak_sulthane_app/data/models/response/product_response_model.dart';
import 'package:seblak_sulthane_app/presentation/home/models/product_quantity.dart';
import 'package:seblak_sulthane_app/presentation/home/widgets/order_menu.dart';

class OrderDetailPage extends StatefulWidget {
  final ItemOrder order;

  const OrderDetailPage({
    super.key,
    required this.order,
  });

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  bool _isLoading = true;
  bool _isPrinting = false;
  String? _errorMessage;
  Map<String, dynamic>? _orderDetail;
  List<ProductQuantity> _orderItems = [];

  @override
  void initState() {
    super.initState();
    _loadOrderDetail();
  }

  Future<void> _loadOrderDetail() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final datasource = OrderRemoteDatasource();
    final result = await datasource.getOrderById(widget.order.id!);

    result.fold(
      (error) {
        setState(() {
          _errorMessage = error;
          _isLoading = false;
        });
      },
      (orderData) {
        // Convert order items to ProductQuantity list
        final List<ProductQuantity> items = [];
        if (orderData['order_items'] != null) {
          for (var item in orderData['order_items']) {
            final product = item['product'];
            if (product != null) {
              // Use item price if product price is not available
              final price = product['price'] != null
                  ? product['price'].toString()
                  : (item['price'] ?? 0).toString();

              items.add(ProductQuantity(
                product: Product(
                  id: product['id'],
                  productId: product['id'],
                  name: product['name'] ?? '',
                  price: price.replaceAll('.00', ''),
                  categoryId: product['category_id'],
                  image: product['image'],
                  description: product['description'],
                  stock: product['stock'],
                  status: product['status'],
                  isFavorite: product['is_favorite'],
                ),
                quantity: item['quantity'] ?? 0,
              ));
            }
          }
        }

        setState(() {
          _orderDetail = orderData;
          _orderItems = items;
          _isLoading = false;
        });
      },
    );
  }

  void _showPrintStatusDialog(bool isSuccess, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: isSuccess
                  ? const Icon(Icons.check_circle,
                      color: Colors.green, size: 60)
                  : const Icon(Icons.error_outline,
                      color: Colors.red, size: 60),
            ),
            const SpaceHeight(16.0),
            Text(
              isSuccess ? 'Print Berhasil' : 'Print Gagal',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SpaceHeight(8.0),
            Text(
              message,
              textAlign: TextAlign.center,
            ),
            const SpaceHeight(20.0),
            Button.filled(
              onPressed: () {
                Navigator.pop(context);
              },
              label: 'OK',
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _printReceipt() async {
    if (_orderItems.isEmpty || _orderDetail == null) {
      _showPrintStatusDialog(false, 'Data order tidak lengkap');
      return;
    }

    setState(() {
      _isPrinting = true;
    });

    try {
      // Get receipt size
      final sizeReceipt = await AuthLocalDataSource().getSizeReceipt();
      int receiptSize;
      try {
        receiptSize = int.parse(sizeReceipt);
      } catch (e) {
        log('Error parsing receipt size: $sizeReceipt');
        receiptSize = 80; // Default value
      }

      // Get cashier name
      String namaKasir = widget.order.namaKasir ?? '';
      try {
        final authLocalDataSource = AuthLocalDataSource();
        final userData = await authLocalDataSource.getUserData();
        if (userData.name.isNotEmpty) {
          namaKasir = userData.name;
        }
      } catch (e) {
        log('Error getting cashier name: $e');
      }

      // Calculate values
      final totalQty = _orderItems.fold(
        0,
        (previousValue, element) => previousValue + element.quantity,
      );

      final paymentAmount = widget.order.paymentAmount ?? 0;
      final totalPrice = widget.order.total ?? 0;
      final kembalian = paymentAmount - totalPrice;

      // Generate receipt print bytes
      final receiptBytes = await PrintDataoutputs.instance.printOrderV3(
        _orderItems,
        totalQty,
        totalPrice,
        widget.order.paymentMethod ?? 'cash',
        paymentAmount,
        kembalian,
        widget.order.tax ?? 0,
        widget.order.discount ?? 0,
        widget.order.subTotal ?? 0,
        widget.order.serviceCharge ?? 0,
        namaKasir,
        '', // customer name - not available in ItemOrder
        receiptSize,
        orderType: _orderDetail!['order_type'] ?? 'dine_in',
        notes: _orderDetail!['notes'] ?? widget.order.notes ?? '',
      );

      // Print the receipt
      log('Printing receipt...');
      final receiptResult =
          await PrintBluetoothThermal.writeBytes(receiptBytes);

      setState(() {
        _isPrinting = false;
      });

      if (receiptResult) {
        _showPrintStatusDialog(true, 'Struk berhasil dicetak.');
      } else {
        _showPrintStatusDialog(
            false, 'Gagal mencetak struk. Silakan coba lagi.');
      }
    } catch (e) {
      setState(() {
        _isPrinting = false;
      });
      _showPrintStatusDialog(false, 'Error: ${e.toString()}');
      log('Print error: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Order #${widget.order.id}'),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _errorMessage!,
                        style: const TextStyle(color: Colors.red),
                      ),
                      const SpaceHeight(16.0),
                      Button.filled(
                        onPressed: _loadOrderDetail,
                        label: 'Coba Lagi',
                      ),
                    ],
                  ),
                )
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Order Info Header
                      Card(
                        color: AppColors.primary.withOpacity(0.1),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Order #${widget.order.id}',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0,
                                      vertical: 6.0,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.primary,
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    child: Text(
                                      widget.order.paymentMethod
                                              ?.toUpperCase() ??
                                          'CASH',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SpaceHeight(12.0),
                              Row(
                                children: [
                                  const Icon(Icons.access_time, size: 16),
                                  const SpaceWidth(8.0),
                                  Text(
                                    widget.order.transactionTime != null
                                        ? widget.order.transactionTime!
                                            .toFormattedDate()
                                        : '-',
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                              const SpaceHeight(8.0),
                              Row(
                                children: [
                                  const Icon(Icons.person, size: 16),
                                  const SpaceWidth(8.0),
                                  Text(
                                    'Kasir: ${widget.order.namaKasir ?? '-'}',
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SpaceHeight(24.0),

                      // Order Items
                      const Text(
                        'Item Pesanan',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      const SpaceHeight(12.0),
                      const Divider(),
                      const SpaceHeight(8.0),
                      if (_orderItems.isEmpty)
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.all(32.0),
                            child: Text('Tidak ada item pesanan'),
                          ),
                        )
                      else
                        ..._orderItems.map(
                          (item) => Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: OrderMenu(data: item),
                          ),
                        ),
                      const SpaceHeight(16.0),
                      const Divider(),

                      // Order Summary
                      const SpaceHeight(16.0),
                      const Text(
                        'Ringkasan Pembayaran',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      const SpaceHeight(12.0),
                      _buildSummaryRow('Sub Total', widget.order.subTotal),
                      _buildSummaryRow(
                          'Diskon',
                          widget.order.discountAmount != null
                              ? int.parse(widget.order.discountAmount!
                                  .replaceAll('.00', ''))
                              : 0),
                      _buildSummaryRow('Pajak', widget.order.tax),
                      _buildSummaryRow(
                          'Biaya Layanan', widget.order.serviceCharge),
                      const SpaceHeight(8.0),
                      const Divider(),
                      const SpaceHeight(8.0),
                      _buildSummaryRow(
                        'Total',
                        widget.order.total,
                        isTotal: true,
                      ),
                      _buildSummaryRow(
                        'Bayar',
                        widget.order.paymentAmount,
                      ),
                      _buildSummaryRow(
                        'Kembalian',
                        (widget.order.paymentAmount ?? 0) -
                            (widget.order.total ?? 0),
                      ),
                      const SpaceHeight(24.0),

                      // Print Button
                      Button.filled(
                        onPressed: _isPrinting ? () {} : _printReceipt,
                        label: _isPrinting ? 'Mencetak...' : 'Cetak Struk',
                        width: double.infinity,
                      ),
                      const SpaceHeight(16.0),
                    ],
                  ),
                ),
    );
  }

  Widget _buildSummaryRow(String label, int? value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? AppColors.primary : Colors.black87,
            ),
          ),
          Text(
            (value ?? 0).currencyFormatRpV2,
            style: TextStyle(
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? AppColors.primary : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
