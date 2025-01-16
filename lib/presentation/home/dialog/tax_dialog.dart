import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seblak_sulthane_app/core/extensions/build_context_ext.dart';
import 'package:seblak_sulthane_app/presentation/setting/bloc/tax/tax_bloc.dart';
import 'package:seblak_sulthane_app/presentation/setting/models/tax_model.dart';

import '../../../core/constants/colors.dart';
import '../../../data/datasources/settings_local_datasource.dart';
import '../bloc/checkout/checkout_bloc.dart';

class TaxDialog extends StatefulWidget {
  const TaxDialog({super.key});

  @override
  State<TaxDialog> createState() => _TaxDialogState();
}

class _TaxDialogState extends State<TaxDialog> {
  @override
  void initState() {
    super.initState();
    // Load tax data when dialog opens
    context.read<TaxBloc>().add(const TaxEvent.started());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaxBloc, TaxState>(
      builder: (context, taxState) {
        print('Current TaxBloc State: $taxState');

        return BlocBuilder<CheckoutBloc, CheckoutState>(
          builder: (context, checkoutState) {
            final taxValue = taxState.maybeWhen(
              loaded: (taxes) {
                final tax = taxes.firstWhere(
                  (tax) => tax.type.isPajak,
                  orElse: () => TaxModel(
                    name: 'Pajak PB1',
                    type: TaxType.pajak,
                    value: 15,
                  ),
                );
                print('Found tax value: ${tax.value}');
                return tax.value;
              },
              orElse: () {
                // Get tax value from SettingsLocalDatasource directly
                final localDatasource = SettingsLocalDatasource();
                print('Getting tax from local storage');
                return 15; // Default value while loading
              },
            );

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
                    subtitle: Text('tarif pajak ($taxValue%)'),
                    contentPadding: EdgeInsets.zero,
                    textColor: AppColors.primary,
                    trailing: checkoutState.maybeWhen(
                      initial: () => Checkbox(
                        value: false,
                        onChanged: (value) {},
                      ),
                      loading: () => const CircularProgressIndicator(),
                      loaded: (data, a, b, c, tax, d, e, f, g) => Checkbox(
                        value: tax > 0,
                        onChanged: (value) {
                          context.read<CheckoutBloc>().add(
                                CheckoutEvent.addTax(tax > 0 ? 0 : taxValue),
                              );
                          if (tax <= 0) {
                            // Trigger tax bloc update when enabling tax
                            context
                                .read<TaxBloc>()
                                .add(const TaxEvent.started());
                          }
                        },
                      ),
                      orElse: () => const SizedBox(),
                    ),
                    onTap: () {
                      context.pop();
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
