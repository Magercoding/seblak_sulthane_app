import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:seblak_sulthane_app/core/constants/colors.dart';
import 'package:seblak_sulthane_app/core/utils/lifecycle_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';
import 'package:seblak_sulthane_app/data/datasources/auth_local_datasource.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const DirectPrinterApp());
}

class DirectPrinterApp extends StatelessWidget {
  const DirectPrinterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Seblak Sulthane Printer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        useMaterial3: true,
        textTheme: GoogleFonts.quicksandTextTheme(
          Theme.of(context).textTheme,
        ),
        appBarTheme: AppBarTheme(
          color: AppColors.white,
          elevation: 0,
          titleTextStyle: GoogleFonts.quicksand(
            color: AppColors.primary,
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
          ),
          iconTheme: const IconThemeData(
            color: AppColors.primary,
          ),
        ),
      ),
      home: const LifecycleManager(
        child: MobilePrinterPage(),
      ),
    );
  }
}

class MobilePrinterPage extends StatefulWidget {
  const MobilePrinterPage({super.key});

  @override
  State<MobilePrinterPage> createState() => _MobilePrinterPageState();
}

class _MobilePrinterPageState extends State<MobilePrinterPage> {
  int? selectedSize;
  String macName = '';
  bool connected = false;
  List<BluetoothInfo> items = [];
  bool _progress = false;
  String _msjprogress = "";
  String _msj = '';

  @override
  void initState() {
    super.initState();
    initPlatformState();
    loadData();
  }

  Future<void> initPlatformState() async {
    String platformVersion;
    int porcentbatery = 0;

    try {
      platformVersion = await PrintBluetoothThermal.platformVersion;
      porcentbatery = await PrintBluetoothThermal.batteryLevel;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    if (!mounted) return;

    final bool result = await PrintBluetoothThermal.bluetoothEnabled;
    if (result) {
      _msj = "Bluetooth diaktifkan, silakan cari printer";
      // Auto scan for devices
      getBluetoots();
    } else {
      _msj = "Bluetooth tidak aktif";
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Mohon aktifkan Bluetooth")),
      );
    }
  }

  Future<void> getBluetoots() async {
    setState(() {
      _progress = true;
      _msjprogress = "Mencari printer...";
      items = [];
    });

    var status2 = await Permission.bluetoothScan.status;
    if (status2.isDenied) {
      await Permission.bluetoothScan.request();
    }

    var status = await Permission.bluetoothConnect.status;
    if (status.isDenied) {
      await Permission.bluetoothConnect.request();
    }

    final List<BluetoothInfo> listResult =
        await PrintBluetoothThermal.pairedBluetooths;

    setState(() {
      _progress = false;
      items = listResult;
    });

    if (listResult.isEmpty) {
      _msj =
          "Tidak ada perangkat Bluetooth yang tersedia. Harap pasangkan printer di pengaturan ponsel Anda.";
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_msj)),
      );
    }
  }

  Future<void> connect(String mac) async {
    setState(() {
      _progress = true;
      _msjprogress = "Menghubungkan...";
      connected = false;
    });

    final bool result =
        await PrintBluetoothThermal.connect(macPrinterAddress: mac);

    if (result) {
      connected = true;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Berhasil terhubung dengan printer")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Gagal terhubung dengan printer")),
      );
    }

    setState(() {
      _progress = false;
    });
  }

  Future<void> testPrint() async {
    if (connected) {
      setState(() {
        _progress = true;
        _msjprogress = "Mencetak...";
      });

      List<int> ticket = await getTestTicket();
      final result = await PrintBluetoothThermal.writeBytes(ticket);

      setState(() {
        _progress = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(result ? "Berhasil mencetak" : "Gagal mencetak")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Printer tidak terhubung")),
      );
    }
  }

  Future<List<int>> getTestTicket() async {
    List<int> bytes = [];
    final profile = await CapabilityProfile.load();
    final generator = Generator(
        selectedSize == 58 ? PaperSize.mm58 : PaperSize.mm80, profile);

    bytes += generator.reset();
    bytes += generator.text('Seblak Sulthane',
        styles: const PosStyles(bold: true, align: PosAlign.center));
    bytes += generator.text('Test Print',
        styles: const PosStyles(reverse: true, align: PosAlign.center));
    bytes += generator.text('================',
        styles: const PosStyles(align: PosAlign.center));
    bytes += generator.text('Ini adalah test print',
        styles: const PosStyles(align: PosAlign.center), linesAfter: 1);
    bytes += generator.text(
        'Jika teks ini tercetak dengan benar, berarti printer berhasil terhubung',
        styles: const PosStyles(align: PosAlign.center),
        linesAfter: 1);
    bytes += generator.text('================',
        styles: const PosStyles(align: PosAlign.center));
    bytes += generator.text('Selamat menggunakan aplikasi',
        styles: const PosStyles(
            height: PosTextSize.size1,
            width: PosTextSize.size1,
            align: PosAlign.center),
        linesAfter: 1);

    // Waktu sekarang
    final now = DateTime.now();
    final formatter =
        "${now.day}/${now.month}/${now.year} ${now.hour}:${now.minute}";
    bytes += generator.text(formatter,
        styles: const PosStyles(align: PosAlign.center), linesAfter: 1);

    bytes += generator.feed(3);
    bytes += generator.cut();
    return bytes;
  }

  Future<void> loadData() async {
    final savedSize = await AuthLocalDataSource().getSizeReceipt();
    if (savedSize.isNotEmpty) {
      setState(() {
        selectedSize = int.parse(savedSize);
      });
    } else {
      // Default ke 58mm jika belum ada pengaturan
      setState(() {
        selectedSize = 58;
      });
    }
  }

  Future<void> saveSettings() async {
    if (selectedSize != null && macName.isNotEmpty) {
      // Simpan ukuran dan alamat MAC printer
      await AuthLocalDataSource().saveSizeReceipt(selectedSize.toString());
      await connect(macName);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pengaturan berhasil disimpan')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Pilih ukuran dan printer terlebih dahulu')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kelola Printer'),
        centerTitle: true,
      ),
      body: _progress
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(color: AppColors.primary),
                  const SizedBox(height: 16),
                  Text(_msjprogress),
                ],
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Ukuran Receipt
                  Text(
                    "Pilih Ukuran Receipt",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Option untuk ukuran receipt
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: Column(
                      children: [
                        // Radio untuk 58mm
                        RadioListTile<int>(
                          title: const Text('58 mm'),
                          subtitle: const Text('Ukuran receipt kecil'),
                          value: 58,
                          groupValue: selectedSize,
                          onChanged: (value) {
                            setState(() {
                              selectedSize = value;
                            });
                          },
                          activeColor: AppColors.primary,
                          contentPadding: EdgeInsets.zero,
                        ),
                        // Radio untuk 80mm
                        RadioListTile<int>(
                          title: const Text('80 mm'),
                          subtitle: const Text('Ukuran receipt besar'),
                          value: 80,
                          groupValue: selectedSize,
                          onChanged: (value) {
                            setState(() {
                              selectedSize = value;
                            });
                          },
                          activeColor: AppColors.primary,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Pilih Printer section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Pilih Printer",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: getBluetoots,
                        icon: const Icon(Icons.search),
                        label: const Text('Scan'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Daftar printer yang ditemukan
                  if (items.isNotEmpty)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey[300]!),
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.print, color: AppColors.primary),
                              const SizedBox(width: 8),
                              const Text(
                                "Printer Tersedia:",
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          const Divider(),
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: items.length,
                            separatorBuilder: (context, index) =>
                                const Divider(),
                            itemBuilder: (context, index) => InkWell(
                              onTap: () {
                                setState(() {
                                  macName = items[index].macAdress;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12.0, horizontal: 8.0),
                                decoration: BoxDecoration(
                                  color: macName == items[index].macAdress
                                      ? AppColors.primary.withOpacity(0.1)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.print,
                                      color: macName == items[index].macAdress
                                          ? AppColors.primary
                                          : Colors.grey,
                                      size: 28,
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            items[index].name,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            items[index].macAdress,
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey[600],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Radio<String>(
                                      value: items[index].macAdress,
                                      groupValue: macName,
                                      onChanged: (value) {
                                        setState(() {
                                          macName = value!;
                                        });
                                      },
                                      activeColor: AppColors.primary,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey[300]!),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.print_disabled,
                            size: 48,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            "Tidak ada printer yang ditemukan",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            "Pastikan printer Bluetooth sudah dipasangkan di pengaturan smartphone",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),

                  const SizedBox(height: 24),

                  // Buttons
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: macName.isNotEmpty
                              ? () => connect(macName)
                              : null,
                          icon: const Icon(Icons.bluetooth),
                          label: const Text('Hubungkan'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            minimumSize: const Size(0, 48),
                            disabledBackgroundColor: Colors.grey[300],
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: connected ? testPrint : null,
                          icon: const Icon(Icons.receipt),
                          label: const Text('Test Print'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                            minimumSize: const Size(0, 48),
                            disabledBackgroundColor: Colors.grey[300],
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Save button
                  ElevatedButton(
                    onPressed: saveSettings,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 48),
                    ),
                    child: const Text('Simpan Pengaturan'),
                  ),
                ],
              ),
            ),
    );
  }
}
