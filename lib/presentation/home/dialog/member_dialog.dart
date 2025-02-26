import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seblak_sulthane_app/data/models/response/member_response_model.dart';
import 'package:seblak_sulthane_app/presentation/setting/bloc/member/member_bloc.dart';
import '../../../core/constants/colors.dart';

class MemberDialog extends StatefulWidget {
  const MemberDialog({super.key});

  @override
  State<MemberDialog> createState() => _MemberDialogState();
}

class _MemberDialogState extends State<MemberDialog> {
  final searchController = TextEditingController();
  List<Member> filteredMembers = [];
  List<Member> allMembers = [];

  @override
  void initState() {
    super.initState();
    // Request member data when the dialog is opened
    context.read<MemberBloc>().add(const MemberEvent.getMembers());
    searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    String query = searchController.text.toLowerCase();
    setState(() {
      filteredMembers = allMembers.where((member) {
        return member.name.toLowerCase().contains(query) ||
            member.phone.contains(query);
      }).toList();
    });
  }

  Widget _buildMembersList() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.white, width: 0.5),
              ),
            ),
            child: const Row(
              children: [
                Text(
                  'Members List',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            constraints: const BoxConstraints(maxHeight: 300),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: BlocConsumer<MemberBloc, MemberState>(
              listener: (context, state) {
                state.maybeWhen(
                  loaded: (membersData) {
                    // Convert data if it's a List<Map<String, dynamic>> and not already List<Member>
                    List<Member> members;
                    if (membersData is List<Member>) {
                      members = membersData;
                    } else {
                      // Assuming membersData is List<Map<String, dynamic>>
                      members = (membersData as List).map((item) {
                        if (item is Member) return item;
                        return Member.fromJson(item as Map<String, dynamic>);
                      }).toList();
                    }

                    setState(() {
                      allMembers = members;
                      filteredMembers = members;
                    });
                  },
                  orElse: () {},
                );
              },
              builder: (context, state) {
                return state.maybeWhen(
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  loaded: (_) {
                    if (filteredMembers.isEmpty) {
                      return const Center(
                        child: Text(
                          'No members found',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      );
                    }

                    return SingleChildScrollView(
                      child: Column(
                        children: filteredMembers.map((member) {
                          return GestureDetector(
                            onTap: () {
                              // Return the selected member when tapped
                              Navigator.pop(context, member);
                            },
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 8),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColors.primary),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        member.name,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.primary,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        member.phone,
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    );
                  },
                  error: (message) => Center(
                    child: Text(
                      'Error: $message',
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                  orElse: () => const Center(
                    child: Text('No members available'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.8,
          maxWidth: 400,
        ),
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Expanded(
                      child: Center(
                        child: Text(
                          'MEMBER',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 28,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.close,
                        color: AppColors.primary,
                        size: 28,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.primary),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: 'Search Member',
                      hintStyle: TextStyle(
                        color: Colors.grey[400],
                      ),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: AppColors.primary,
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                _buildMembersList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
