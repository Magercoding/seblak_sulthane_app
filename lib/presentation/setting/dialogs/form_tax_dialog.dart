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
  late final TextEditingController valueController;

  bool get isLayanan => widget.data?.type.isLayanan == true;
  bool get isPajak => widget.data?.type.isPajak == true;

  @override
  void initState() {
    super.initState();
    valueController = TextEditingController(
      text: widget.data?.value.toString() ?? '',
    );
  }

  @override
  void dispose() {
    valueController.dispose();
    super.dispose();
  }

  void _handleSubmit(BuildContext context) {
    final value = int.tryParse(valueController.text) ?? 0;

    if (isLayanan) {
      final serviceTax = TaxModel(
        name: 'Biaya Layanan',
        type: TaxType.layanan,
        value: value,
      );
      context.read<TaxBloc>().add(
            widget.data == null
                ? TaxEvent.add(serviceTax)
                : TaxEvent.update(serviceTax),
          );
    } else if (isPajak) {
      final taxFee = TaxModel(
        name: 'Pajak',
        type: TaxType.pajak,
        value: value,
      );
      context.read<TaxBloc>().add(
            widget.data == null
                ? TaxEvent.add(taxFee)
                : TaxEvent.update(taxFee),
          );
    }

    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final label = isLayanan ? 'Biaya Layanan' : 'Pajak';

    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () => context.pop(),
            icon: const Icon(Icons.close),
          ),
          Text(widget.data == null
              ? 'Tambah Perhitungan Biaya'
              : 'Edit $label'),
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
                controller: valueController,
                label: label,
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
    );
  }
}
