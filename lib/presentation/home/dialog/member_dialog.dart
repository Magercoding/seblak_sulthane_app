import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';

class MemberDialog extends StatefulWidget {
  const MemberDialog({super.key});

  @override
  State<MemberDialog> createState() => _MemberDialogState();
}

class _MemberDialogState extends State<MemberDialog> {
  final phoneController = TextEditingController();
  final nameController = TextEditingController();
  final searchController = TextEditingController();
  bool showNewMemberForm = false;

  // Contoh data member
  final List<Map<String, String>> members = [
    {"name": "John Doe", "phone": "081234567890"},
    {"name": "Jane Smith", "phone": "081234567891"},
    {"name": "Bob Johnson", "phone": "081234567892"},
    {"name": "Alice Brown", "phone": "081234567893"},
  ];

  List<Map<String, String>> filteredMembers = [];

  @override
  void initState() {
    super.initState();
    filteredMembers = members;
    searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    phoneController.dispose();
    nameController.dispose();
    searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    String query = searchController.text.toLowerCase();
    setState(() {
      filteredMembers = members.where((member) {
        return member["name"]!.toLowerCase().contains(query) ||
            member["phone"]!.contains(query);
      }).toList();
    });
  }

  Widget _buildNewMemberForm() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.white, width: 0.5),
              ),
            ),
            child: Row(
              children: [
                const Text(
                  'New Member',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    setState(() {
                      showNewMemberForm = false;
                    });
                  },
                  icon: const Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Nomor HP',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.primary),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    controller: phoneController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Nama',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.primary),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      // Add member functionality here when backend is ready
                      setState(() {
                        showNewMemberForm = false;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(120, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Simpan',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMembersList() {
    return Column(
      children: [
        Container(
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
                child: Row(
                  children: [
                    const Text(
                      'Members List',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer(),
                    TextButton.icon(
                      onPressed: () {
                        setState(() {
                          showNewMemberForm = true;
                        });
                      },
                      icon: const Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      label: const Text(
                        'New Member',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                constraints: const BoxConstraints(
                    maxHeight: 300), // Membatasi tinggi container
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: SingleChildScrollView(
                  // Menambahkan scroll untuk daftar member
                  child: Column(
                    children: filteredMembers.map((member) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.primary),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  member["name"]!,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.primary,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  member["phone"]!,
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: ConstrainedBox(
        // Menambahkan constraints untuk dialog
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.8,
          maxWidth: 400,
        ),
        child: SingleChildScrollView(
          // Menambahkan scroll untuk seluruh konten dialog
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
                showNewMemberForm ? _buildNewMemberForm() : _buildMembersList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
