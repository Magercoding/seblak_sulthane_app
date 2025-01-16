import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seblak_sulthane_app/core/extensions/build_context_ext.dart';
import 'package:seblak_sulthane_app/presentation/home/bloc/checkout/checkout_bloc.dart';

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

  @override
  void initState() {
    super.initState();
    context.read<DiscountBloc>().add(const DiscountEvent.getDiscounts());
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
      content: BlocBuilder<DiscountBloc, DiscountState>(
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () => const SizedBox.shrink(),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            loaded: (discounts) {
              final memberDiscounts =
                  discounts.where((d) => d.category == 'member').toList();
              final eventDiscounts =
                  discounts.where((d) => d.category == 'event').toList();

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
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
            subtitle: Text('Potongan harga (${discount.value}%)'),
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
