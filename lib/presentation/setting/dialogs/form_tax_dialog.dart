import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seblak_sulthane_app/core/extensions/build_context_ext.dart';
import 'package:seblak_sulthane_app/presentation/setting/bloc/tax/tax_bloc.dart';

import '../../../core/components/buttons.dart';
import '../../../core/components/custom_text_field.dart';
import '../../../core/components/spaces.dart';
import '../models/tax_model.dart';

class FormTaxDialog extends StatefulWidget {
  final TaxModel? data;
  const FormTaxDialog({super.key, this.data});

  @override
  State<FormTaxDialog> createState() => _FormTaxDialogState();
}

class _FormTaxDialogState extends State<FormTaxDialog> {
  late final TextEditingController serviceFeeController;
  late final TextEditingController taxFeeController;

  @override
  void initState() {
    super.initState();

    serviceFeeController = TextEditingController(
      text: widget.data?.type.isLayanan == true
          ? widget.data?.value.toString()
          : '',
    );
    taxFeeController = TextEditingController(
      text: widget.data?.type.isPajak == true
          ? widget.data?.value.toString()
          : '',
    );
  }

  @override
  void dispose() {
    serviceFeeController.dispose();
    taxFeeController.dispose();
    super.dispose();
  }

  void _handleSubmit(BuildContext context) {
    final serviceValue = int.tryParse(serviceFeeController.text) ?? 0;
    final taxValue = int.tryParse(taxFeeController.text) ?? 0;

    // Process service fee regardless of value (including zero)
    final serviceTax = TaxModel(
      name: 'Biaya Layanan',
      type: TaxType.layanan,
      value: serviceValue,
    );

    if (widget.data == null) {
      context.read<TaxBloc>().add(TaxEvent.add(serviceTax));
    } else if (widget.data?.type.isLayanan == true) {
      context.read<TaxBloc>().add(TaxEvent.update(serviceTax));
    }

    // Process tax fee regardless of value (including zero)
    final taxFee = TaxModel(
      name: 'Pajak',
      type: TaxType.pajak,
      value: taxValue,
    );

    if (widget.data == null) {
      context.read<TaxBloc>().add(TaxEvent.add(taxFee));
    } else if (widget.data?.type.isPajak == true) {
      context.read<TaxBloc>().add(TaxEvent.update(taxFee));
    }

    context.read<TaxBloc>().add(const TaxEvent.started());

    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TaxBloc, TaxState>(
      listener: (context, state) {
        state.whenOrNull(
          error: (message) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: $message')),
            );
          },
          loaded: (taxes) {},
        );
      },
      child: AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () => context.pop(),
              icon: const Icon(Icons.close),
            ),
            Text(widget.data == null
                ? 'Tambah Perhitungan Biaya'
                : 'Edit Perhitungan Biaya'),
            const Spacer(),
          ],
        ),
        content: SingleChildScrollView(
          child: SizedBox(
            width: context.deviceWidth / 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                  controller: serviceFeeController,
                  label: 'Biaya Layanan',
                  onChanged: (value) => print('Service fee changed: $value'),
                  keyboardType: TextInputType.number,
                  suffixIcon: const Icon(Icons.percent),
                ),
                const SpaceHeight(24.0),
                CustomTextField(
                  controller: taxFeeController,
                  label: 'Pajak',
                  onChanged: (value) => print('Tax fee changed: $value'),
                  keyboardType: TextInputType.number,
                  suffixIcon: const Icon(Icons.percent),
                ),
                const SpaceHeight(24.0),
                Button.filled(
                  onPressed: () => _handleSubmit(context),
                  label: widget.data == null ? 'Simpan' : 'Perbarui',
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
