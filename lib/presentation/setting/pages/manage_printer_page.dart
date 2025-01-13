import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:seblak_sulthane_app/core/components/components.dart';
import 'package:seblak_sulthane_app/core/extensions/build_context_ext.dart';
import 'package:seblak_sulthane_app/data/datasources/auth_local_datasource.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';

import '../../../core/constants/colors.dart';
import '../widgets/menu_printer_button.dart';
import '../widgets/menu_printer_content.dart';

class ManagePrinterPage extends StatefulWidget {
  const ManagePrinterPage({super.key});

  @override
  State<ManagePrinterPage> createState() => _ManagePrinterPageState();
}

class _ManagePrinterPageState extends State<ManagePrinterPage> {
  int selectedIndex = 0;
  int? selectedSize;
  // final List<PrinterModel> datas = [
  //   PrinterModel(
  //     name: 'Galaxy A30',
  //     address: 12324567412,
  //   ),
  //   PrinterModel(
  //     name: 'Galaxy A30',
  //     address: 12324567412,
  //   ),
  //   PrinterModel(
  //     name: 'Galaxy A30',
  //     address: 12324567412,
  //   ),
  // ];

  String macName = '';

  String _info = "";
  String _msj = '';
  bool connected = false;
  List<BluetoothInfo> items = [];
  final List<String> _options = [
    "permission bluetooth granted",
    "bluetooth enabled",
    "connection status",
    "update info"
  ];

  final String _selectSize = "2";
  final _txtText = TextEditingController(text: "Hello developer");
  bool _progress = false;
  String _msjprogress = "";

  String optionprinttype = "58 mm";
  List<String> options = ["58 mm", "80 mm"];

  @override
  void initState() {
    super.initState();
    initPlatformState();
    loadData();
  }

  Future<void> initPlatformState() async {
    String platformVersion;
    int porcentbatery = 0;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await PrintBluetoothThermal.platformVersion;
      print("patformversion: $platformVersion");
      porcentbatery = await PrintBluetoothThermal.batteryLevel;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    final bool result = await PrintBluetoothThermal.bluetoothEnabled;
    print("bluetooth enabled: $result");
    if (result) {
      _msj = "Bluetooth enabled, please search and connect";
    } else {
      _msj = "Bluetooth not enabled";
    }

    setState(() {
      _info = "$platformVersion ($porcentbatery% battery)";
    });
  }

  Future<void> getBluetoots() async {
    setState(() {
      _progress = true;
      _msjprogress = "Wait";
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
    });

    if (listResult.isEmpty) {
      _msj =
          "There are no bluetoohs linked, go to settings and link the printer";
    } else {
      _msj = "Touch an item in the list to connect";
    }

    setState(() {
      items = listResult;
    });
  }

  Future<void> connect(String mac) async {
    setState(() {
      _progress = true;
      _msjprogress = "Connecting...";
      connected = false;
    });
    final bool result =
        await PrintBluetoothThermal.connect(macPrinterAddress: mac);
    print("state conected $result");
    if (result) connected = true;
    setState(() {
      _progress = false;
    });
  }

  Future<void> disconnect() async {
    final bool status = await PrintBluetoothThermal.disconnect;
    setState(() {
      connected = false;
    });
    print("status disconnect $status");
  }

  Future<void> printTest() async {
    bool conexionStatus = await PrintBluetoothThermal.connectionStatus;
    //print("connection status: $conexionStatus");
    if (conexionStatus) {
      List<int> ticket = await testTicket();
      final result = await PrintBluetoothThermal.writeBytes(ticket);
      print("print test result:  $result");
    } else {
      //no conectado, reconecte
    }
  }

  Future<List<int>> testTicket() async {
    List<int> bytes = [];
    // Using default profile
    final profile = await CapabilityProfile.load();
    final generator = Generator(
        optionprinttype == "58 mm" ? PaperSize.mm58 : PaperSize.mm80, profile);
    //bytes += generator.setGlobalFont(PosFontType.fontA);
    bytes += generator.reset();

    bytes +=
        generator.text('Code with Bahri', styles: const PosStyles(bold: true));
    bytes +=
        generator.text('Reverse text', styles: const PosStyles(reverse: true));
    bytes += generator.text('Underlined text',
        styles: const PosStyles(underline: true), linesAfter: 1);
    bytes += generator.text('Align left',
        styles: const PosStyles(align: PosAlign.left));
    bytes += generator.text('Align center',
        styles: const PosStyles(align: PosAlign.center));
    bytes += generator.text('Align right',
        styles: const PosStyles(align: PosAlign.right), linesAfter: 1);

    bytes += generator.text(
      'FIC Batch 11',
      styles: const PosStyles(
        height: PosTextSize.size2,
        width: PosTextSize.size2,
      ),
    );

    bytes += generator.feed(2);
    //bytes += generator.cut();
    return bytes;
  }

  Future<void> printWithoutPackage() async {
    //impresion sin paquete solo de PrintBluetoothTermal
    bool connectionStatus = await PrintBluetoothThermal.connectionStatus;
    if (connectionStatus) {
      String text = "${_txtText.text}\n";
      bool result = await PrintBluetoothThermal.writeString(
          printText: PrintTextSize(size: int.parse(_selectSize), text: text));
      print("status print result: $result");
      setState(() {
        _msj = "printed status: $result";
      });
    } else {
      //no conectado, reconecte
      setState(() {
        _msj = "no connected device";
      });
      print("no conectado");
    }
  }

  Future<void> printString() async {
    bool conexionStatus = await PrintBluetoothThermal.connectionStatus;
    if (conexionStatus) {
      String enter = '\n';
      await PrintBluetoothThermal.writeBytes(enter.codeUnits);
      //size of 1-5
      String text = "Hello";
      await PrintBluetoothThermal.writeString(
          printText: PrintTextSize(size: 1, text: text));
      await PrintBluetoothThermal.writeString(
          printText: PrintTextSize(size: 2, text: "$text size 2"));
      await PrintBluetoothThermal.writeString(
          printText: PrintTextSize(size: 3, text: "$text size 3"));
    } else {
      //desconectado
      print("desconectado bluetooth $conexionStatus");
    }
  }

  Future<void> loadData() async {
    final savedSize = await AuthLocalDataSource().getSizeReceipt();
    if (savedSize.isNotEmpty) {
      setState(() {
        selectedSize = int.parse(savedSize);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kelola Printer'),
        centerTitle: true,
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: Button.filled(
            onPressed: () async {
              // Periksa apakah ukuran dan printer telah dipilih
              if (selectedSize != null && macName.isNotEmpty) {
                // Simpan ukuran dan alamat MAC printer
                AuthLocalDataSource().saveSizeReceipt(selectedSize.toString());
                await connect(macName);

                // Tampilkan pesan berhasil
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Pengaturan berhasil disimpan')),
                );
              } else {
                // Tampilkan pesan error jika belum dipilih
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content:
                          Text('Pilih ukuran dan printer terlebih dahulu')),
                );
              }
            },
            label: 'Simpan'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          Text(
            "Pilih Ukuran",
            style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: AppColors.primary),
          ),
          SpaceHeight(16),
          Container(
            width: context.deviceWidth / 2,
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                // Radio button untuk ukuran 58
                Expanded(
                  child: Row(
                    children: [
                      Radio<int>(
                        value: 58,
                        groupValue: selectedSize,
                        onChanged: (value) {
                          setState(() {
                            selectedSize = value;
                          });
                        },
                      ),
                      const Text('58 mm'),
                    ],
                  ),
                ),
                // Radio button untuk ukuran 80
                Expanded(
                  child: Row(
                    children: [
                      Radio<int>(
                        value: 80,
                        groupValue: selectedSize,
                        onChanged: (value) {
                          setState(() {
                            selectedSize = value;
                          });
                        },
                      ),
                      const Text('80 mm'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SpaceHeight(24),
          Text(
            "Pilih Printer",
            style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: AppColors.primary),
          ),
          SpaceHeight(16),
          Container(
            width: context.deviceWidth / 2,
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                MenuPrinterButton(
                  label: 'Search',
                  onPressed: () {
                    getBluetoots();
                    selectedIndex = 0;
                    setState(() {});
                  },
                  isActive: selectedIndex == 0,
                ),
              ],
            ),
          ),
          const SpaceHeight(34.0),
          _Body(
            // selectedIndex: selectedIndex,
            macName: macName,
            datas: items,
            clickHandler: (mac) async {
              macName = mac;

              setState(() {});
            },
          ),
          SpaceHeight(24),
        ],
      ),
    );
  }
}

class _Body extends StatelessWidget {
  // final int selectedIndex;
  final String macName;
  final List<BluetoothInfo> datas;

  //clickHandler
  final Function(String) clickHandler;

  const _Body({
    required this.macName,
    required this.datas,
    required this.clickHandler,
  });

  @override
  Widget build(BuildContext context) {
    if (datas.isEmpty) {
      return const Text('No data available');
    } else {
      return Container(
        padding: const EdgeInsets.all(24.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: AppColors.card, width: 2),
          borderRadius: BorderRadius.circular(6),
        ),
        child: ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: datas.length,
          separatorBuilder: (context, index) => const SpaceHeight(16.0),
          itemBuilder: (context, index) => InkWell(
            onTap: () {
              clickHandler(datas[index].macAdress);
            },
            child: MenuPrinterContent(
              isSelected: macName == datas[index].macAdress,
              data: datas[index],
            ),
          ),
        ),
      );
    }
    // return const Placeholder();
  }
}
