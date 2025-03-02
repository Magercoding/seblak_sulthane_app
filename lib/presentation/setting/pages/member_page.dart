import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seblak_sulthane_app/data/models/response/member_response_model.dart';
import 'package:seblak_sulthane_app/presentation/home/widgets/custom_tab_bar.dart';
import 'package:seblak_sulthane_app/presentation/setting/bloc/member/member_bloc.dart';
import 'package:seblak_sulthane_app/presentation/setting/dialogs/form_member_dialog.dart';
import 'package:seblak_sulthane_app/presentation/setting/widgets/add_data.dart';
import 'package:seblak_sulthane_app/presentation/setting/widgets/manage_member_card.dart';
import 'package:seblak_sulthane_app/presentation/setting/widgets/settings_title.dart';

class MemberPage extends StatefulWidget {
  const MemberPage({super.key});

  @override
  State<MemberPage> createState() => _MemberPageState();
}

class _MemberPageState extends State<MemberPage> {
  @override
  void initState() {
    super.initState();
    context.read<MemberBloc>().add(const MemberEvent.getMembers());
  }

  void onEditTap(Member item) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => FormMemberDialog(data: item),
    );
  }

  void onAddDataTap() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const FormMemberDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SettingsTitle('Kelola Member'),
          const SizedBox(height: 24),
          CustomTabBar(
            tabTitles: const ['Semua'],
            initialTabIndex: 0,
            tabViews: [
              BlocConsumer<MemberBloc, MemberState>(
                listener: (context, state) {
                  state.maybeWhen(
                    success: (message) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(message),
                          backgroundColor: Colors.green,
                        ),
                      );
                      context
                          .read<MemberBloc>()
                          .add(const MemberEvent.getMembers());
                    },
                    error: (message) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(message),
                          backgroundColor: Colors.red,
                        ),
                      );
                    },
                    orElse: () {},
                  );
                },
                builder: (context, state) {
                  return state.maybeWhen(
                    loaded: (members) {
                      if (members.isEmpty) {
                        return const Center(
                          child: Text('Belum ada data member'),
                        );
                      }
                      return GridView.builder(
                        shrinkWrap: true,
                        itemCount: members.length + 1,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 0.85,
                          crossAxisCount: 3,
                          crossAxisSpacing: 30.0,
                          mainAxisSpacing: 30.0,
                        ),
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return AddData(
                              title: 'Tambah Member Baru',
                              onPressed: onAddDataTap,
                            );
                          }
                          final item = members[index - 1];
                          return ManageMemberCard(
                            data: item,
                            onEditTap: () => onEditTap(item),
                            onDeleteTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Hapus Member'),
                                  content: const Text(
                                      'Apakah anda yakin ingin menghapus member ini?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('Batal'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        context.read<MemberBloc>().add(
                                            MemberEvent.deleteMember(item.id));
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Hapus'),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                    loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    error: (message) => Center(
                      child: Text(message),
                    ),
                    orElse: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
