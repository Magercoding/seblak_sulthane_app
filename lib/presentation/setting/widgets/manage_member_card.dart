import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seblak_sulthane_app/data/models/response/member_response_model.dart';
import 'package:seblak_sulthane_app/presentation/setting/bloc/member/member_bloc.dart';

import '../../../core/assets/assets.gen.dart';
import '../../../core/constants/colors.dart';

class ManageMemberCard extends StatelessWidget {
  final Member data;
  final VoidCallback onEditTap;
  final VoidCallback onDeleteTap;

  const ManageMemberCard({
    super.key,
    required this.data,
    required this.onEditTap,
    required this.onDeleteTap,
  });

  @override
  Widget build(BuildContext context) {
    // Use a more responsive approach with LayoutBuilder
    return LayoutBuilder(
      builder: (context, constraints) {
        // Define a reasonable height constraint
        final height = constraints.maxHeight.isFinite
            ? constraints.maxHeight
            : 220.0; // Default height if unconstrained

        return Container(
          height: height,
          padding: const EdgeInsets.all(12.0),
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 1, color: AppColors.card),
              borderRadius: BorderRadius.circular(19),
            ),
          ),
          child: Stack(
            children: [
              // Main content in a scrollable container to handle overflow
              Padding(
                padding: const EdgeInsets.only(
                    top: 36.0), // Space for action buttons
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(16.0),
                        margin: const EdgeInsets.only(bottom: 12.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.disabled.withOpacity(0.4),
                        ),
                        child: const Icon(
                          Icons.person,
                          size: 36,
                          color: AppColors.primary,
                        ),
                      ),
                      Text.rich(
                        TextSpan(
                          text: 'Nama : ',
                          children: [
                            TextSpan(
                              text: data.name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppColors.black,
                          ),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text.rich(
                        TextSpan(
                          text: 'Telepon : ',
                          children: [
                            TextSpan(
                              text: data.phone,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppColors.black,
                          ),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              // Action buttons
              Align(
                alignment: Alignment.topRight,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: onEditTap,
                      child: Container(
                        padding: const EdgeInsets.all(6.0),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50.0)),
                          color: AppColors.primary,
                        ),
                        child: Assets.icons.edit.svg(width: 18, height: 18),
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Hapus Member'),
                            content: const Text(
                                'Apakah Anda yakin ingin menghapus member ini?'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Batal'),
                              ),
                              TextButton(
                                onPressed: () {
                                  context.read<MemberBloc>().add(
                                        MemberEvent.deleteMember(data.id),
                                      );
                                  Navigator.pop(context);
                                },
                                child: const Text('Hapus'),
                              ),
                            ],
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(6.0),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50.0)),
                          color: Colors.red,
                        ),
                        child: const Icon(
                          Icons.delete,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
