import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seblak_sulthane_app/core/extensions/build_context_ext.dart';
import 'package:seblak_sulthane_app/presentation/home/bloc/checkout/checkout_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../../../core/constants/colors.dart';
import '../../setting/bloc/discount/discount_bloc.dart';

class DiscountDialog extends StatefulWidget {
  const DiscountDialog({super.key});

  @override
  State<DiscountDialog> createState() => _DiscountDialogState();
}

class _DiscountDialogState extends State<DiscountDialog> {
  int? selectedMemberDiscountId;
  int? selectedEventDiscountId;
  bool isOffline = false;

  @override
  void initState() {
    super.initState();
    _checkConnectivity();
    context.read<DiscountBloc>().add(const DiscountEvent.getDiscounts());
  }

  Future<void> _checkConnectivity() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    setState(() {
      isOffline = connectivityResult == ConnectivityResult.none;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Stack(
        alignment: Alignment.center,
        children: [
          const Text(
            'DISKON',
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 28,
              fontWeight: FontWeight.w600,
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed: () => context.pop(),
              icon: const Icon(
                Icons.cancel,
                color: AppColors.primary,
                size: 30.0,
              ),
            ),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isOffline)
            Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.amber.shade100,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.amber.shade800),
              ),
              child: Row(
                children: [
                  Icon(Icons.wifi_off, color: Colors.amber.shade800),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Anda sedang dalam mode offline. Menggunakan data diskon yang tersimpan.',
                      style: TextStyle(color: Colors.amber.shade800),
                    ),
                  ),
                ],
              ),
            ),
          Flexible(
            child: BlocBuilder<DiscountBloc, DiscountState>(
              builder: (context, state) {
                return state.maybeWhen(
                  orElse: () => const SizedBox.shrink(),
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  error: (message) => Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.error_outline,
                          size: 48,
                          color: Colors.red.shade300,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          message,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.red.shade300),
                        ),
                        const SizedBox(height: 16),
                        if (isOffline)
                          ElevatedButton(
                            onPressed: () {
                              context.read<DiscountBloc>().add(
                                    const DiscountEvent.getDiscounts(),
                                  );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                            ),
                            child: const Text('Coba Lagi'),
                          ),
                      ],
                    ),
                  ),
                  loaded: (discounts) {
                    if (discounts.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.sentiment_dissatisfied,
                              size: 48,
                              color: Colors.grey.shade400,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              isOffline
                                  ? 'Tidak ada diskon tersimpan untuk digunakan offline'
                                  : 'Tidak ada diskon tersedia',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          ],
                        ),
                      );
                    }

                    final memberDiscounts =
                        discounts.where((d) => d.category == 'member').toList();
                    final eventDiscounts =
                        discounts.where((d) => d.category == 'event').toList();

                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (memberDiscounts.isNotEmpty) ...[
                            _buildDiscountSection(
                              title: 'Diskon Member',
                              discounts: memberDiscounts,
                              selectedDiscountId: selectedMemberDiscountId,
                              onSelect: (discount) {
                                setState(() {
                                  selectedMemberDiscountId = discount.id;
                                });
                                context.read<CheckoutBloc>().add(
                                      CheckoutEvent.addDiscount(discount),
                                    );
                              },
                              onDeselect: () {
                                setState(() {
                                  selectedMemberDiscountId = null;
                                });
                                context.read<CheckoutBloc>().add(
                                      CheckoutEvent.removeDiscount('member'),
                                    );
                              },
                            ),
                            const SizedBox(height: 16),
                          ],
                          if (eventDiscounts.isNotEmpty)
                            _buildDiscountSection(
                              title: 'Diskon Event',
                              discounts: eventDiscounts,
                              selectedDiscountId: selectedEventDiscountId,
                              onSelect: (discount) {
                                setState(() {
                                  selectedEventDiscountId = discount.id;
                                });
                                context.read<CheckoutBloc>().add(
                                      CheckoutEvent.addDiscount(discount),
                                    );
                              },
                              onDeselect: () {
                                setState(() {
                                  selectedEventDiscountId = null;
                                });
                                context.read<CheckoutBloc>().add(
                                      CheckoutEvent.removeDiscount('event'),
                                    );
                              },
                            ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDiscountSection({
    required String title,
    required List<dynamic> discounts,
    required int? selectedDiscountId,
    required void Function(dynamic discount) onSelect,
    required VoidCallback onDeselect,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: AppColors.primary,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        ...discounts.map(
          (discount) => ListTile(
            title: Text('Nama Diskon: ${discount.name}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Potongan harga (${discount.value}%)'),
                if (discount.description != null &&
                    discount.description!.isNotEmpty)
                  Text(
                    discount.description!,
                    style: const TextStyle(fontSize: 12),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
            contentPadding: EdgeInsets.zero,
            textColor: AppColors.primary,
            trailing: Checkbox(
              value: selectedDiscountId == discount.id,
              onChanged: (value) {
                if (value == true) {
                  onSelect(discount);
                } else {
                  onDeselect();
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
