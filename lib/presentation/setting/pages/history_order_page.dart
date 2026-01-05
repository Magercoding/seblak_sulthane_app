import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:seblak_sulthane_app/core/components/spaces.dart';
import 'package:seblak_sulthane_app/core/constants/colors.dart';
import 'package:seblak_sulthane_app/core/extensions/int_ext.dart';
import 'package:seblak_sulthane_app/core/utils/timezone_helper.dart';
import 'package:seblak_sulthane_app/presentation/home/models/order_model.dart';
import 'package:seblak_sulthane_app/presentation/home/widgets/success_payment_dialog.dart';

import '../../home/bloc/order/order_bloc.dart';
import '../bloc/history_order/history_order_bloc.dart';

class HistoryOrderPage extends StatefulWidget {
  const HistoryOrderPage({super.key});

  @override
  State<HistoryOrderPage> createState() => _HistoryOrderPageState();
}

class _HistoryOrderPageState extends State<HistoryOrderPage> {
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _loadOrdersForSelectedDate();
  }

  void _loadOrdersForSelectedDate() {
    context.read<HistoryOrderBloc>().add(
      HistoryOrderEvent.getOrdersByDate(selectedDate),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
      _loadOrdersForSelectedDate();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Riwayat Pesanan',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        const SpaceHeight(16),
        // Date picker row
        Row(
          children: [
            TextButton.icon(
              onPressed: () => _selectDate(context),
              icon: const Icon(Icons.calendar_today),
              label: Text(
                'Tanggal: ${DateFormat('dd MMM yyyy').format(selectedDate)}',
                style: const TextStyle(fontSize: 16),
              ),
            ),
            const SpaceWidth(16),
            ElevatedButton(
              onPressed: _loadOrdersForSelectedDate,
              child: const Text('Refresh'),
            ),
          ],
        ),
        const SpaceHeight(16),
        // List of orders
        Expanded(
          child: BlocBuilder<HistoryOrderBloc, HistoryOrderState>(
            builder: (context, state) {
              return state.maybeWhen(
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
                loaded: (orders) {
                  if (orders.isEmpty) {
                    return const Center(
                      child: Text(
                        'Tidak ada pesanan pada tanggal ini',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount: orders.length,
                    itemBuilder: (context, index) {
                      final order = orders[index];
                      return _buildOrderCard(order);
                    },
                  );
                },
                error: (message) => Center(
                  child: Text(
                    'Error: $message',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.red,
                    ),
                  ),
                ),
                orElse: () => const Center(
                  child: Text(
                    'Pilih tanggal untuk melihat pesanan',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildOrderCard(OrderModel order) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order #${order.id}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                Text(
                  DateFormat('dd MMM yyyy, HH:mm').format(
                    TimezoneHelper.toWIB(DateTime.parse(order.transactionTime)),
                  ),
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
            const SpaceHeight(8),
            Row(
              children: [
                // Order type badge
                if (order.orderType.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: order.orderType == 'take_away'
                          ? AppColors.primary.withOpacity(0.2)
                          : Colors.green.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      order.orderType == 'take_away' ? 'Take Away' : 'Dine In',
                      style: TextStyle(
                        fontSize: 12,
                        color: order.orderType == 'take_away'
                            ? AppColors.primary
                            : Colors.green,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                const SpaceWidth(8),
                // Table number if applicable
                if (order.tableNumber > 0)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'Meja ${order.tableNumber}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.blue,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                const SpaceWidth(8),
                // Payment method badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: order.paymentMethod.toLowerCase() == 'cash'
                        ? Colors.amber.withOpacity(0.2)
                        : Colors.purple.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    order.paymentMethod.toUpperCase(),
                    style: TextStyle(
                      fontSize: 12,
                      color: order.paymentMethod.toLowerCase() == 'cash'
                          ? Colors.amber[800]
                          : Colors.purple,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SpaceHeight(12),
            // Customer name
            if (order.customerName.isNotEmpty)
              Row(
                children: [
                  const Text(
                    'Pelanggan:',
                    style: TextStyle(fontSize: 14),
                  ),
                  const SpaceWidth(4),
                  Text(
                    order.customerName,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            const SpaceHeight(12),
            // Order details
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Item: ${order.totalItem}',
                  style: const TextStyle(fontSize: 14),
                ),
                Text(
                  'Total: ${order.total.currencyFormatRp}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
            const SpaceHeight(16),
            // Action buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton.icon(
                  onPressed: () => _showOrderDetails(order),
                  icon: const Icon(Icons.visibility),
                  label: const Text('Detail'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showOrderDetails(OrderModel order) async {
    // First load the order items
    context.read<HistoryOrderBloc>().add(
      HistoryOrderEvent.getOrderItemsByOrderId(order.id!),
    );

    // Wait for the items to load
    await showDialog(
      context: context,
      builder: (context) => BlocBuilder<HistoryOrderBloc, HistoryOrderState>(
        builder: (context, state) {
          return state.maybeWhen(
            loadedWithItems: (orderItems) {
              // Log the loaded items to verify data
              for (var item in orderItems) {
                log("Loaded item: ${item.product.name ?? 'Unknown'} (ID=${item.product.id}), Qty=${item.quantity}");
              }

              // Create a complete order model with items
              final orderWithItems = order.copyWith(orderItems: orderItems);

              // Load this order into OrderBloc so SuccessPaymentDialog can access it
              context.read<OrderBloc>().add(
                OrderEvent.loadHistoricalOrder(orderWithItems),
              );

              // Show the payment dialog with explicit table number
              return SuccessPaymentDialog(
                data: orderItems,
                totalQty: order.totalItem,
                totalPrice: order.total,
                totalTax: order.tax,
                totalDiscount: order.discountAmount,
                subTotal: order.subTotal,
                normalPrice: order.subTotal,
                totalService: order.serviceCharge,
                draftName: order.customerName,
                orderType: order.orderType,
                tableNumber: order.tableNumber, // Pass table number explicitly
                notes: order.notes,
              );
            },
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            error: (message) => AlertDialog(
              title: const Text('Error'),
              content: Text('Failed to load order details: $message'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('OK'),
                ),
              ],
            ),
            orElse: () => const Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}
