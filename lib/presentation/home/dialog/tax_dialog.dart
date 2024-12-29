import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seblak_sulthane_app/core/extensions/build_context_ext.dart';

import '../../../core/constants/colors.dart';
import '../bloc/checkout/checkout_bloc.dart';

class TaxDialog extends StatelessWidget {
  const TaxDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Stack(
        alignment: Alignment.center,
        children: [
          const Text(
            'PAJAK PB1',
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
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: const Text('PB1'),
            subtitle: const Text('tarif pajak (10%)'),
            contentPadding: EdgeInsets.zero,
            textColor: AppColors.primary,
            trailing: BlocBuilder<CheckoutBloc, CheckoutState>(
              builder: (context, state) {
                return state.maybeWhen(
                  initial: () => Checkbox(
                    value: false,
                    onChanged: (value) {},
                  ),
                  loading: () => const CircularProgressIndicator(),
                  loaded: (data, a, b, c, tax, d, e, f, g) => Checkbox(
                    value: tax > 0,
                    onChanged: (value) {
                      context.read<CheckoutBloc>().add(
                            CheckoutEvent.addTax(tax > 0 ? 0 : 10),
                          );
                    },
                  ),
                  orElse: () => const SizedBox(),
                );
                // return Checkbox(
                //   value: true,
                //   onChanged: (value) {},
                // );
              },
            ),
            onTap: () {
              context.pop();
            },
          ),
        ],
      ),
    );
  }
}
