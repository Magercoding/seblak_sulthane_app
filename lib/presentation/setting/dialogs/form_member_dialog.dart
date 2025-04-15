import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seblak_sulthane_app/core/components/custom_text_field.dart';
import 'package:seblak_sulthane_app/data/models/response/member_response_model.dart';
import 'package:seblak_sulthane_app/presentation/setting/bloc/member/member_bloc.dart';

import '../../../core/components/buttons.dart';

class FormMemberDialog extends StatefulWidget {
  final Member? data;
  const FormMemberDialog({super.key, this.data});

  @override
  State<FormMemberDialog> createState() => _FormMemberDialogState();
}

class _FormMemberDialogState extends State<FormMemberDialog> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  bool isEdit = false;

  @override
  void initState() {
    super.initState();
    if (widget.data != null) {
      isEdit = true;
      nameController.text = widget.data!.name;
      phoneController.text = widget.data!.phone;
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close),
          ),
          Text(isEdit ? 'Edit Member' : 'Tambah Member'),
          const Spacer(),
        ],
      ),
      content: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width / 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextField(
                controller: nameController,
                label: 'Nama Member',
                onChanged: (value) {},
              ),
              const SizedBox(height: 24.0),
              CustomTextField(
                controller: phoneController,
                label: 'Nomor Telepon',
                keyboardType: TextInputType.phone,
                onChanged: (value) {},
              ),
              const SizedBox(height: 24.0),
              BlocConsumer<MemberBloc, MemberState>(
                listener: (context, state) {
                  state.maybeWhen(
                    orElse: () {},
                    success: (message) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(message),
                          backgroundColor: Colors.green,
                        ),
                      );
                      Navigator.pop(context);
                    },
                    error: (message) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(message),
                          backgroundColor: Colors.red,
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
                          if (nameController.text.isEmpty ||
                              phoneController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content:
                                    Text('Nama dan nomor telepon harus diisi'),
                                backgroundColor: Colors.red,
                              ),
                            );
                            return;
                          }

                          if (isEdit) {
                            context.read<MemberBloc>().add(
                                  MemberEvent.updateMember(
                                    id: widget.data!.id,
                                    name: nameController.text,
                                    phone: phoneController.text,
                                  ),
                                );
                          } else {
                            context.read<MemberBloc>().add(
                                  MemberEvent.addMember(
                                    name: nameController.text,
                                    phone: phoneController.text,
                                  ),
                                );
                          }
                        },
                        label: isEdit ? 'Update Member' : 'Simpan Member',
                      );
                    },
                    loading: () {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
