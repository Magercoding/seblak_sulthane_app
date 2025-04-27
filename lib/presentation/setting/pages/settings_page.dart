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
import '../../../core/constants/colors.dart';
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
}
