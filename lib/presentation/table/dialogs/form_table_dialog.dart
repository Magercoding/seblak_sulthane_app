import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seblak_sulthane_app/core/components/custom_text_field.dart';
import 'package:seblak_sulthane_app/core/extensions/build_context_ext.dart';
import 'package:seblak_sulthane_app/presentation/table/blocs/generate_table/generate_table_bloc.dart';
import 'package:seblak_sulthane_app/presentation/table/blocs/get_table/get_table_bloc.dart';

import '../../../core/components/buttons.dart';
import '../../../core/components/spaces.dart';

class FormTableDialog extends StatefulWidget {
  const FormTableDialog({
    super.key,
  });

  @override
  State<FormTableDialog> createState() => _FormTableDialogState();
}

class _FormTableDialogState extends State<FormTableDialog> {
  final generateController = TextEditingController();
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
          const Text('Tambah Table'),
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
                controller: generateController,
                label: 'Jumlah Table',
                onChanged: (value) {},
                keyboardType: TextInputType.number,
              ),
              const SpaceHeight(24.0),
              BlocConsumer<GenerateTableBloc, GenerateTableState>(
                listener: (context, state) {
                  state.maybeWhen(
                    orElse: () {},
                    success: (message) {
                      context
                          .read<GetTableBloc>()
                          .add(const GetTableEvent.getTables());
                      context.pop();
                    },
                  );
                },
                builder: (context, state) {
                  return state.maybeWhen(orElse: () {
                    return Button.filled(
                      onPressed: () {
                        context.read<GenerateTableBloc>().add(
                              GenerateTableEvent.generate(
                                int.parse(generateController.text),
                              ),
                            );
                      },
                      label: 'Generate',
                    );
                  }, loading: () {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
