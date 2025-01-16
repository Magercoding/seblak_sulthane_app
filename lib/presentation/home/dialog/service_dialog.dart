import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seblak_sulthane_app/core/extensions/build_context_ext.dart';
import 'package:seblak_sulthane_app/presentation/home/bloc/checkout/checkout_bloc.dart';
import 'package:seblak_sulthane_app/presentation/setting/bloc/tax/tax_bloc.dart';
import 'package:seblak_sulthane_app/presentation/setting/models/tax_model.dart';

import '../../../core/constants/colors.dart';

class ServiceDialog extends StatefulWidget {
  const ServiceDialog({super.key});

  @override
  State<ServiceDialog> createState() => _ServiceDialogState();
}

class _ServiceDialogState extends State<ServiceDialog> {
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
        return BlocBuilder<CheckoutBloc, CheckoutState>(
          builder: (context, checkoutState) {
            final serviceValue = taxState.maybeWhen(
              loaded: (taxes) {
                final service = taxes.firstWhere(
                  (tax) => tax.type.isLayanan,
                  orElse: () => TaxModel(
                    name: 'Biaya Layanan',
                    type: TaxType.layanan,
                    value: 5,
                  ),
                );
                print('Service charge value: ${service.value}');
                return service.value;
              },
              orElse: () {
                print('Getting service charge from local storage');
                return 5; // Default value while loading
              },
            );

            return AlertDialog(
              title: Stack(
                alignment: Alignment.center,
                children: [
                  const Text(
                    'LAYANAN',
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
                                        title: const Text('Biaya layanan'),

                    subtitle: Text('Presentase ($serviceValue%)'),
                    contentPadding: EdgeInsets.zero,
                    textColor: AppColors.primary,
                    trailing: checkoutState.maybeWhen(
                      orElse: () => Checkbox(
                        value: false,
                        onChanged: (value) {},
                      ),
                      loading: () => const CircularProgressIndicator(),
                      loaded: (data, a, b, c, d, service, e, f, g) => Checkbox(
                        value: service > 0,
                        onChanged: (value) {
                          context.read<CheckoutBloc>().add(
                                CheckoutEvent.addServiceCharge(
                                  service > 0 ? 0 : serviceValue,
                                ),
                              );
                          if (service <= 0) {
                            // Trigger tax bloc update when enabling service
                            context
                                .read<TaxBloc>()
                                .add(const TaxEvent.started());
                          }
                        },
                      ),
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
