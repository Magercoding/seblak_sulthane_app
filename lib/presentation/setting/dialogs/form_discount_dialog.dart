import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seblak_sulthane_app/core/components/custom_text_field.dart';
import 'package:seblak_sulthane_app/core/extensions/build_context_ext.dart';
import 'package:seblak_sulthane_app/presentation/setting/bloc/add_discount/add_discount_bloc.dart';
import 'package:seblak_sulthane_app/presentation/setting/bloc/discount/discount_bloc.dart';

import '../../../core/components/buttons.dart';
import '../../../core/components/spaces.dart';
import '../models/discount_model.dart';

class FormDiscountDialog extends StatefulWidget {
  final DiscountModel? data;
  const FormDiscountDialog({super.key, this.data});

  @override
  State<FormDiscountDialog> createState() => _FormDiscountDialogState();
}

class _FormDiscountDialogState extends State<FormDiscountDialog> {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final discountController = TextEditingController();
  String selectedCategory = 'member';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () => context.pop(),
            icon: const Icon(Icons.close),
          ),
          const Text('Tambah Diskon'),
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
                controller: nameController,
                label: 'Nama Diskon',
                onChanged: (value) {},
              ),
              const SpaceHeight(24.0),
              CustomTextField(
                controller: descriptionController,
                label: 'Deskripsi (Opsional)',
                onChanged: (value) {},
              ),
              const SpaceHeight(24.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Flexible(
                    child: CustomTextField(
                      controller: TextEditingController(text: 'Presentase'),
                      label: 'Nilai',
                      suffixIcon: const Icon(Icons.chevron_right),
                      onChanged: (value) {},
                      readOnly: true,
                    ),
                  ),
                  const SpaceWidth(14.0),
                  Flexible(
                    child: CustomTextField(
                      showLabel: false,
                      controller: discountController,
                      label: 'Percent',
                      prefixIcon: const Icon(Icons.percent),
                      onChanged: (value) {},
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              const SpaceHeight(24.0),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Kategori',
                  border: OutlineInputBorder(),
                ),
                value: selectedCategory,
                items: const [
                  DropdownMenuItem(value: 'member', child: Text('Member')),
                  DropdownMenuItem(value: 'event', child: Text('Event')),
                ],
                onChanged: (value) {
                  setState(() {
                    selectedCategory = value!;
                  });
                },
              ),
              const SpaceHeight(24.0),
              BlocConsumer<AddDiscountBloc, AddDiscountState>(
                listener: (context, state) {
                  state.maybeWhen(
                    orElse: () {},
                    success: () {
                      // Show success message
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Diskon berhasil ditambahkan!'),
                          backgroundColor: Colors.green,
                          duration: Duration(seconds: 2),
                        ),
                      );
                      // Refresh discount list
                      context
                          .read<DiscountBloc>()
                          .add(const DiscountEvent.getDiscounts());
                      // Close dialog
                      context.pop();
                    },
                    error: (message) {
                      // Show error message
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(message),
                          backgroundColor: Colors.red,
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    },
                  );
                },
                builder: (context, state) {
                  return state.maybeWhen(
                    orElse: () {
                      return Button.filled(
                        onPressed: () {
                          // Validate inputs
                          if (nameController.text.isEmpty ||
                              discountController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content:
                                    Text('Nama dan nilai diskon harus diisi'),
                                backgroundColor: Colors.red,
                              ),
                            );
                            return;
                          }

                          try {
                            final value = int.parse(discountController.text);
                            if (value < 0 || value > 100) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text('Nilai diskon harus antara 0-100'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                              return;
                            }

                            context.read<AddDiscountBloc>().add(
                                  AddDiscountEvent.addDiscount(
                                    name: nameController.text,
                                    description: descriptionController.text,
                                    value: value,
                                    category: selectedCategory,
                                  ),
                                );
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content:
                                    Text('Nilai diskon harus berupa angka'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                        label: 'Simpan Diskon',
                      );
                    },
                    loading: () {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
