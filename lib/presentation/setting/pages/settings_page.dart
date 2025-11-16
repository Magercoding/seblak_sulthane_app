import 'package:flutter/material.dart';
import 'package:seblak_sulthane_app/data/datasources/auth_local_datasource.dart';
import 'package:seblak_sulthane_app/presentation/setting/pages/daily_cash_page.dart';
import 'package:seblak_sulthane_app/presentation/setting/pages/discount_page.dart';
import 'package:seblak_sulthane_app/presentation/setting/pages/profile_page.dart';
import 'package:seblak_sulthane_app/presentation/setting/pages/manage_printer_page.dart';
import 'package:seblak_sulthane_app/presentation/setting/pages/sync_data_page.dart';
import 'package:seblak_sulthane_app/presentation/setting/pages/tax_page.dart';
import 'package:seblak_sulthane_app/presentation/setting/pages/member_page.dart';

import '../../../core/assets/assets.gen.dart';
import '../../../core/components/spaces.dart';
import '../../../core/components/buttons.dart';
import '../../../core/constants/colors.dart';
import '../../../core/utils/clear_local_data.dart';
import 'history_order_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  int currentIndex = 0;
  String? role;

  void indexValue(int index) {
    currentIndex = index;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    setRole();
  }

  void setRole() {
    AuthLocalDataSource().getAuthData().then((value) {
      setState(() {
        role = value.user!.role;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.topCenter,
              child: ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  const Text(
                    'Settings',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SpaceHeight(16.0),
                  ListTile(
                    contentPadding: const EdgeInsets.all(12.0),
                    leading: Assets.icons.profile.svg(),
                    title: const Text('Profil Pengguna'),
                    subtitle: const Text('Lihat informasi akun '),
                    textColor: AppColors.primary,
                    tileColor: currentIndex == 0
                        ? AppColors.blueLight
                        : Colors.transparent,
                    onTap: () => indexValue(0),
                  ),
                  ListTile(
                    contentPadding: const EdgeInsets.all(12.0),
                    leading: Assets.icons.kelolaDiskon.svg(),
                    title: const Text('Kelola Diskon'),
                    subtitle: const Text('Kelola diskon pelanggan'),
                    textColor: AppColors.primary,
                    tileColor: currentIndex == 1
                        ? AppColors.blueLight
                        : Colors.transparent,
                    onTap: () => indexValue(1),
                  ),
                  ListTile(
                    contentPadding: const EdgeInsets.all(12.0),
                    leading: Assets.icons.member2.svg(),
                    title: const Text('Kelola Member'),
                    subtitle: const Text('Kelola member pelanggan'),
                    textColor: AppColors.primary,
                    tileColor: currentIndex == 2
                        ? AppColors.blueLight
                        : Colors.transparent,
                    onTap: () => indexValue(2),
                  ),
                  ListTile(
                    contentPadding: const EdgeInsets.all(12.0),
                    leading: Assets.icons.kelolaPajak.svg(),
                    title: const Text('Perhitungan Biaya'),
                    subtitle: const Text('Kelola biaya diluar biaya modal'),
                    textColor: AppColors.primary,
                    tileColor: currentIndex == 3
                        ? AppColors.blueLight
                        : Colors.transparent,
                    onTap: () => indexValue(3),
                  ),
                  ListTile(
                    contentPadding: const EdgeInsets.all(12.0),
                    leading: Assets.icons.kelolaPajak.svg(),
                    title: const Text('Kelola Uang Harian'),
                    subtitle: const Text('Kelola cash harian'),
                    textColor: AppColors.primary,
                    tileColor: currentIndex == 4
                        ? AppColors.blueLight
                        : Colors.transparent,
                    onTap: () => indexValue(4),
                  ),
                  ListTile(
                    contentPadding: const EdgeInsets.all(12.0),
                    leading: Assets.icons.kelolaPrinter.svg(),
                    title: const Text('Kelola Printer'),
                    subtitle: const Text('Tambah atau hapus printer'),
                    textColor: AppColors.primary,
                    tileColor: currentIndex == 5
                        ? AppColors.blueLight
                        : Colors.transparent,
                    onTap: () => indexValue(5),
                  ),
                  ListTile(
                    contentPadding: const EdgeInsets.all(12.0),
                    leading: Assets.icons.kelolaPajak.svg(),
                    title: const Text('Sync Data'),
                    subtitle:
                        const Text('Sinkronisasi data dari dan ke server'),
                    textColor: AppColors.primary,
                    tileColor: currentIndex == 6
                        ? AppColors.blueLight
                        : Colors.transparent,
                    onTap: () => indexValue(6),
                  ),
                  ListTile(
                    contentPadding: const EdgeInsets.all(12.0),
                    leading: Icon(Icons.history, color: AppColors.primary),
                    title: const Text('Riwayat Pesanan'),
                    subtitle: const Text('Lihat seluruh riwayat transaksi'),
                    textColor: AppColors.primary,
                    tileColor: currentIndex == 7
                        ? AppColors.blueLight
                        : Colors.transparent,
                    onTap: () => indexValue(7),
                  ),
                  // const Divider(height: 32),
                  // ListTile(
                  //   contentPadding: const EdgeInsets.all(12.0),
                  //   leading: Icon(Icons.delete_forever, color: Colors.red),
                  //   title: const Text(
                  //     'Hapus Semua Data Lokal',
                  //     style: TextStyle(color: Colors.red),
                  //   ),
                  //   subtitle: const Text(
                  //     'Hapus semua data yang tersimpan di device',
                  //     style: TextStyle(color: Colors.red),
                  //   ),
                  //   textColor: Colors.red,
                  //   onTap: () => _showClearDataDialog(context),
                  // ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Align(
              alignment: AlignmentDirectional.topStart,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: IndexedStack(
                  index: currentIndex,
                  children: [
                    ProfilePage(),
                    DiscountPage(),
                    MemberPage(),
                    TaxPage(),
                    DailyCashPage(),
                    ManagePrinterPage(),
                    SyncDataPage(),
                    HistoryOrderPage(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showClearDataDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Hapus Semua Data Lokal',
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Apakah Anda yakin ingin menghapus semua data lokal?',
              style: TextStyle(fontSize: 16),
            ),
            SpaceHeight(16.0),
            Text(
              'Data yang akan dihapus:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            SpaceHeight(8.0),
            Text('• Data autentikasi (perlu login ulang)'),
            Text('• Data produk'),
            Text('• Data pesanan'),
            Text('• Data member'),
            Text('• Data diskon'),
            Text('• Data kategori'),
            Text('• Pengaturan aplikasi'),
            SpaceHeight(16.0),
            Text(
              '⚠️ PERINGATAN: Tindakan ini tidak dapat dibatalkan!',
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ],
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Button.outlined(
                  onPressed: () => Navigator.pop(context),
                  label: 'Batal',
                ),
              ),
              const SpaceWidth(8.0),
              Expanded(
                child: Button.filled(
                  onPressed: () async {
                    Navigator.pop(context); // Close dialog first

                    // Show loading dialog
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => const Center(
                        child: Card(
                          child: Padding(
                            padding: EdgeInsets.all(24.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CircularProgressIndicator(),
                                SpaceHeight(16.0),
                                Text('Menghapus data...'),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );

                    // Clear all data
                    final success = await ClearLocalData.clearAllData();

                    // Close loading dialog
                    if (context.mounted) {
                      Navigator.pop(context);
                    }

                    // Show result
                    if (context.mounted) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text(
                            success ? 'Berhasil' : 'Gagal',
                            style: TextStyle(
                              color: success ? Colors.green : Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          content: Text(
                            success
                                ? 'Semua data lokal berhasil dihapus.\n\nAplikasi akan restart dan Anda perlu login ulang.'
                                : 'Gagal menghapus data lokal. Silakan coba lagi.',
                          ),
                          actions: [
                            Button.filled(
                              onPressed: () {
                                Navigator.pop(context);
                                if (success) {
                                  // Restart app or navigate to login
                                  // You might want to add navigation to login page here
                                }
                              },
                              label: 'OK',
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  label: 'Hapus',
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
