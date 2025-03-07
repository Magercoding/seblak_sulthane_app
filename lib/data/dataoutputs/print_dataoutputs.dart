import 'dart:math';

import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';
import 'package:flutter/services.dart';
import 'package:seblak_sulthane_app/core/extensions/int_ext.dart';
import 'package:seblak_sulthane_app/core/extensions/string_ext.dart';
import 'package:seblak_sulthane_app/data/datasources/auth_local_datasource.dart';
import 'package:seblak_sulthane_app/data/datasources/auth_remote_datasource.dart';
import 'package:seblak_sulthane_app/data/datasources/outlet_datasource.dart';
import 'package:seblak_sulthane_app/data/models/response/outlet_model.dart';
import 'package:seblak_sulthane_app/data/models/response/user_model.dart';
import 'package:seblak_sulthane_app/presentation/home/models/product_quantity.dart';
import 'package:intl/intl.dart';
import 'package:image/image.dart' as img;

class PrintDataoutputs {
  PrintDataoutputs._init();

  static final PrintDataoutputs instance = PrintDataoutputs._init();

  // Get user profile from remote first, then fall back to local if remote fails
  static Future<UserModel?> _getUserProfile() async {
    try {
      // Try remote first
      final authRemoteDatasource = AuthRemoteDatasource();
      final result = await authRemoteDatasource.getProfile();

      UserModel? user;
      result.fold(
        (error) async {
          // If remote fails, try local
          user = await _getUserProfileFromLocal();
        },
        (userData) {
          user = userData;
          // Save to local for future offline use
          _saveUserProfileToLocal(userData);
        },
      );

      return user;
    } catch (e) {
      // If any error occurs, try local
      return _getUserProfileFromLocal();
    }
  }

  // Get user profile from local storage
  static Future<UserModel?> _getUserProfileFromLocal() async {
    try {
      final authLocalDataSource = AuthLocalDataSource();
      return await authLocalDataSource.getUserData();
    } catch (e) {
      return null;
    }
  }

  // Save user profile to local storage
  static Future<void> _saveUserProfileToLocal(UserModel user) async {
    try {
      final authLocalDataSource = AuthLocalDataSource();
      await authLocalDataSource.saveUserData(user);
    } catch (e) {
      // Just log error but continue
      print('Failed to save user profile to local: $e');
    }
  }

  static Future<int?> _fetchOutletIdFromProfile() async {
    try {
      // Try to get profile from either remote or local
      final user = await _getUserProfile();
      return user?.outletId;
    } catch (e) {
      return null;
    }
  }

  // Get cashier name directly from local storage with debugging
  static Future<String> _getCashierNameFromProfile() async {
    print("⭐ Starting to get cashier name from profile");
    try {
      // First try local storage for immediate offline support
      final authLocalDataSource = AuthLocalDataSource();
      try {
        print("📱 Attempting to get user data from local storage");
        final localUser = await authLocalDataSource.getUserData();
        print("📱 Local storage result: ${localUser.name}");

        if (localUser.name.isNotEmpty) {
          print("✅ Using name from local storage: ${localUser.name}");
          return localUser.name;
        } else {
          print("⚠️ Name from local storage is empty");
        }
      } catch (localError) {
        // If local storage fails, log error and continue to remote
        print('❌ Failed to get user name from local storage: $localError');
      }

      // If local storage didn't work, try remote
      print("🌐 Attempting to get profile from remote");
      try {
        final authRemoteDatasource = AuthRemoteDatasource();
        final result = await authRemoteDatasource.getProfile();

        String userName = "Cashier"; // Default
        result.fold(
          (error) {
            print("❌ Remote profile error: $error");
            // Remote failed, keep default
          },
          (userData) {
            if (userData.name.isNotEmpty) {
              userName = userData.name;
              print("✅ Using name from remote: ${userData.name}");

              // Save to local for future offline use
              print("💾 Saving remote user data to local");
              _saveUserProfileToLocal(userData);
            } else {
              print("⚠️ Name from remote is empty");
            }
          },
        );

        return userName;
      } catch (remoteError) {
        print("❌ Error accessing remote profile: $remoteError");
        throw remoteError; // Propagate to outer catch block
      }
    } catch (e) {
      print("❌ Final error getting cashier name: $e");
      return "Cashier"; // Default fallback
    }
  }

  static Future<OutletModel?> _getOutletInfo(int outletId) async {
    try {
      final outletDataSource = OutletLocalDataSource();
      final allOutlets = await outletDataSource.getAllOutlets();
      final outlet = await outletDataSource.getOutletById(outletId);

      if (outlet == null && allOutlets.isNotEmpty) {
        return allOutlets.first;
      }

      return outlet;
    } catch (e) {
      return null;
    }
  }

  // Replace the cashier name handling code in printOrderV3 with this:

  Future<List<int>> printOrderV3(
      List<ProductQuantity> products,
      int totalQuantity,
      int totalPrice,
      String paymentMethod,
      int nominalBayar,
      int kembalian,
      int tax,
      int discount,
      int subTotal,
      int serviceCharge,
      String
          namaKasir, // This parameter will be IGNORED and overridden with local data
      String customerName,
      int paper,
      {int? outletId}) async {
    List<int> bytes = [];

    final profile = await CapabilityProfile.load();
    final generator =
        Generator(paper == 58 ? PaperSize.mm58 : PaperSize.mm80, profile);

    final ByteData data =
        await rootBundle.load('assets/logo/seblak_sulthane.png');
    final Uint8List bytesData = data.buffer.asUint8List();
    final img.Image? orginalImage = img.decodeImage(bytesData);
    bytes += generator.reset();

    outletId ??= await PrintDataoutputs._fetchOutletIdFromProfile();
    outletId ??= 1;

    // IMPORTANT: Add logging to diagnose the issue
    print("🧾 ORDER - Cashier name parameter received: '$namaKasir'");

    // ALWAYS get cashier name from local storage regardless of what was passed in
    print("🧾 ORDER - Directly fetching cashier name from local storage");
    try {
      final authLocalDataSource = AuthLocalDataSource();
      final userData = await authLocalDataSource.getUserData();
      if (userData.name.isNotEmpty) {
        // Force override any passed name
        namaKasir = userData.name;
        print("🧾 ORDER - Forced name from local storage: '${userData.name}'");
      } else {
        print(
            "🧾 ORDER - Local user name is empty, using fallback: $namaKasir");
      }
    } catch (e) {
      print("🧾 ORDER - Error getting local user data: $e");
    }

    final OutletModel? outlet = await PrintDataoutputs._getOutletInfo(outletId);
    final String outletAddress = outlet?.address ?? 'OFFLINE';
    final String outletPhone = outlet?.phone ?? 'Seblak Sulthane';

    if (orginalImage != null) {
      final img.Image grayscalledImage = img.grayscale(orginalImage);
      final img.Image resizedImage =
          img.copyResize(grayscalledImage, width: 240);
      bytes += generator.imageRaster(resizedImage, align: PosAlign.center);
      bytes += generator.feed(3);
    }

    bytes += generator.text(outletAddress,
        styles: const PosStyles(bold: false, align: PosAlign.center));
    bytes += generator.text(outletPhone,
        styles: const PosStyles(bold: false, align: PosAlign.center));

    bytes += generator.text(
        paper == 80
            ? '------------------------------------------------'
            : '--------------------------------',
        styles: const PosStyles(bold: false, align: PosAlign.center));

    bytes += generator.row([
      PosColumn(
        text: DateFormat('dd MMM yyyy').format(DateTime.now()),
        width: 6,
        styles: const PosStyles(align: PosAlign.left),
      ),
      PosColumn(
        text: DateFormat('HH:mm').format(DateTime.now()),
        width: 6,
        styles: const PosStyles(align: PosAlign.right),
      ),
    ]);
    bytes += generator.row([
      PosColumn(
        text: 'Receipt Number',
        width: 6,
        styles: const PosStyles(align: PosAlign.left),
      ),
      PosColumn(
        text: 'RN-${DateFormat('yyyyMMddhhmm').format(DateTime.now())}',
        width: 6,
        styles: const PosStyles(align: PosAlign.right),
      ),
    ]);

    bytes += generator.row([
      PosColumn(
        text: 'Order ID',
        width: 6,
        styles: const PosStyles(align: PosAlign.left),
      ),
      PosColumn(
        text: Random().nextInt(100000).toString(),
        width: 6,
        styles: const PosStyles(align: PosAlign.right),
      ),
    ]);
    bytes += generator.row([
      PosColumn(
        text: 'Bill Name',
        width: 6,
        styles: const PosStyles(align: PosAlign.left),
      ),
      PosColumn(
        text: customerName,
        width: 6,
        styles: const PosStyles(align: PosAlign.right),
      ),
    ]);

    print("🧾 ORDER - Final cashier name being printed: '$namaKasir'");
    bytes += generator.row([
      PosColumn(
        text: 'Collected By',
        width: 5,
        styles: const PosStyles(align: PosAlign.left),
      ),
      PosColumn(
        text: namaKasir,
        width: 7,
        styles: const PosStyles(align: PosAlign.right),
      ),
    ]);
    bytes += generator.text(
        paper == 80
            ? '------------------------------------------------'
            : '--------------------------------',
        styles: const PosStyles(bold: false, align: PosAlign.center));
    for (final product in products) {
      bytes += generator.row([
        PosColumn(
          text: '${product.quantity} x ${product.product.name}',
          width: 8,
          styles: const PosStyles(bold: true, align: PosAlign.left),
        ),
        PosColumn(
          text: '${product.product.price!.toIntegerFromText * product.quantity}'
              .currencyFormatRpV2,
          width: 4,
          styles: const PosStyles(bold: true, align: PosAlign.right),
        ),
      ]);
    }
    bytes += generator.text(
        paper == 80
            ? '------------------------------------------------'
            : '--------------------------------',
        styles: const PosStyles(bold: false, align: PosAlign.center));

    bytes += generator.row([
      PosColumn(
        text: 'Subtotal $totalQuantity Product',
        width: 6,
        styles: const PosStyles(align: PosAlign.left),
      ),
      PosColumn(
        text: subTotal.currencyFormatRpV2,
        width: 6,
        styles: const PosStyles(align: PosAlign.right),
      ),
    ]);

    bytes += generator.row([
      PosColumn(
        text: 'Discount',
        width: 6,
        styles: const PosStyles(align: PosAlign.left),
      ),
      PosColumn(
        text: discount.currencyFormatRpV2,
        width: 6,
        styles: const PosStyles(align: PosAlign.right),
      ),
    ]);

    // Calculate tax percentage from the actual tax amount passed in and the subTotal
    double taxPercentage = 0;
    if (subTotal > 0) {
      taxPercentage = (tax / subTotal) * 100;
    }

    bytes += generator.row([
      PosColumn(
        text:
            'Tax (${taxPercentage.toStringAsFixed(0)}%)', // Use the calculated percentage
        width: 6,
        styles: const PosStyles(align: PosAlign.left),
      ),
      PosColumn(
        text: tax.currencyFormatRpV2,
        width: 6,
        styles: const PosStyles(align: PosAlign.right),
      ),
    ]);

    // Calculate the service charge percentage based on the provided subTotal
    double serviceChargePercentage = 0;
    if (subTotal > 0) {
      serviceChargePercentage = (serviceCharge / subTotal) * 100;
    }

    bytes += generator.row([
      PosColumn(
        text: 'Service Charge (${serviceChargePercentage.toStringAsFixed(0)}%)',
        width: 6,
        styles: const PosStyles(align: PosAlign.left),
      ),
      PosColumn(
        text: serviceCharge.currencyFormatRpV2,
        width: 6,
        styles: const PosStyles(align: PosAlign.right),
      ),
    ]);

    bytes += generator.text(
        paper == 80
            ? '------------------------------------------------'
            : '--------------------------------',
        styles: const PosStyles(bold: false, align: PosAlign.center));
    bytes += generator.row([
      PosColumn(
        text: 'Total',
        width: 6,
        styles: const PosStyles(bold: true, align: PosAlign.left),
      ),
      PosColumn(
        text: totalPrice.currencyFormatRpV2,
        width: 6,
        styles: const PosStyles(bold: true, align: PosAlign.right),
      ),
    ]);
    bytes += generator.row([
      PosColumn(
        text: paymentMethod == 'Cash' ? 'Cash' : 'QRIS',
        width: 6,
        styles: const PosStyles(align: PosAlign.left),
      ),
      PosColumn(
        text: nominalBayar.currencyFormatRpV2,
        width: 6,
        styles: const PosStyles(align: PosAlign.right),
      ),
    ]);

    // Only show kembalian (change) if payment method is Cash
    if (paymentMethod == 'Cash') {
      bytes += generator.row([
        PosColumn(
          text: 'Return',
          width: 6,
          styles: const PosStyles(align: PosAlign.left),
        ),
        PosColumn(
          text: kembalian.currencyFormatRpV2,
          width: 6,
          styles: const PosStyles(align: PosAlign.right),
        ),
      ]);
    }

    bytes += generator.text(
        paper == 80
            ? '------------------------------------------------'
            : '--------------------------------',
        styles: const PosStyles(bold: false, align: PosAlign.left));

    bytes += generator.text('Notes',
        styles: const PosStyles(bold: false, align: PosAlign.center));
    bytes += generator.feed(1);

    bytes += generator.text('Instagram: ',
        styles: const PosStyles(bold: false, align: PosAlign.center));
    bytes += generator.text('seblaksulthane_official',
        styles: const PosStyles(bold: false, align: PosAlign.center));
    bytes += generator.feed(1);

    bytes += generator.text('Pilih suka-suka loe',
        styles: const PosStyles(bold: false, align: PosAlign.center));
    bytes += generator.text('Pedesnya bar-bar',
        styles: const PosStyles(bold: false, align: PosAlign.center));

    bytes += generator.feed(3);
    bytes += generator.cut();
    return bytes;
  }

  Future<List<int>> printQRIS(
      int totalPrice, Uint8List imageQris, int paper) async {
    List<int> bytes = [];

    final profile = await CapabilityProfile.load();
    final generator =
        Generator(paper == 58 ? PaperSize.mm58 : PaperSize.mm80, profile);

    final img.Image? orginalImage = img.decodeImage(imageQris);
    bytes += generator.reset();

    bytes += generator.text('Scan QRIS Below for Payment',
        styles: const PosStyles(bold: false, align: PosAlign.center));
    bytes += generator.feed(2);
    if (orginalImage != null) {
      final img.Image grayscalledImage = img.grayscale(orginalImage);
      final img.Image resizedImage =
          img.copyResize(grayscalledImage, width: 240);
      bytes += generator.imageRaster(resizedImage, align: PosAlign.center);
      bytes += generator.feed(1);
    }

    bytes += generator.text('Price : ${totalPrice.currencyFormatRp}',
        styles: const PosStyles(bold: false, align: PosAlign.center));

    bytes += generator.feed(4);
    bytes += generator.cut();

    return bytes;
  }

  Future<List<int>> printChecker(List<ProductQuantity> products,
      int tableNumber, String draftName, String cashierName, int paper,
      {int? outletId}) async {
    List<int> bytes = [];

    final profile = await CapabilityProfile.load();
    final generator =
        Generator(paper == 58 ? PaperSize.mm58 : PaperSize.mm80, profile);

    outletId ??= await PrintDataoutputs._fetchOutletIdFromProfile();
    outletId ??= 1;

    // IMPORTANT: Add logging to diagnose the issue
    print("📝 CHECKER - Cashier name parameter received: '$cashierName'");

    // ALWAYS get cashier name from local storage regardless of what was passed in
    print("📝 CHECKER - Directly fetching cashier name from local storage");
    try {
      final authLocalDataSource = AuthLocalDataSource();
      final userData = await authLocalDataSource.getUserData();
      if (userData.name.isNotEmpty) {
        // Force override any passed name
        cashierName = userData.name;
        print(
            "📝 CHECKER - Forced name from local storage: '${userData.name}'");
      } else {
        print(
            "📝 CHECKER - Local user name is empty, using fallback: $cashierName");
      }
    } catch (e) {
      print("📝 CHECKER - Error getting local user data: $e");
    }

    final OutletModel? outlet = await PrintDataoutputs._getOutletInfo(outletId);
    final String outletName = outlet?.name ?? 'Seblak Sulthane';

    bytes += generator.reset();

    bytes += generator.text('Order Checker',
        styles: const PosStyles(
          bold: true,
          align: PosAlign.center,
          height: PosTextSize.size2,
          width: PosTextSize.size2,
        ));
    bytes += generator.feed(1);

    // Only print the table number if it's greater than 0
    if (tableNumber > 0) {
      bytes += generator.text(tableNumber.toString(),
          styles: const PosStyles(
            bold: true,
            align: PosAlign.center,
            height: PosTextSize.size2,
            width: PosTextSize.size2,
          ));
      bytes += generator.feed(1);
    }

    bytes += generator.row([
      PosColumn(
        text: 'Date',
        width: 5,
        styles: const PosStyles(align: PosAlign.left),
      ),
      PosColumn(
        text: DateFormat('dd-MM-yyyy HH:mm').format(DateTime.now()),
        width: 7,
        styles: const PosStyles(align: PosAlign.right),
      ),
    ]);

    bytes += generator.row([
      PosColumn(
        text: 'Receipt',
        width: 6,
        styles: const PosStyles(align: PosAlign.left),
      ),
      PosColumn(
        text: 'SS-${DateFormat('yyyyMMddhhmm').format(DateTime.now())}',
        width: 6,
        styles: const PosStyles(align: PosAlign.right),
      ),
    ]);

    bytes += generator.row([
      PosColumn(
        text: 'Cashier',
        width: 5,
        styles: const PosStyles(align: PosAlign.left),
      ),
      PosColumn(
        text: cashierName,
        width: 7,
        styles: const PosStyles(align: PosAlign.right),
      ),
    ]);

    bytes += generator.row([
      PosColumn(
        text: 'Customer - $draftName',
        width: 12, // Fixed width to 12 as per previous fix
        styles: const PosStyles(align: PosAlign.left),
      ),
    ]);

    bytes += generator.text(
        paper == 80
            ? '------------------------------------------------'
            : '--------------------------------',
        styles: const PosStyles(bold: false, align: PosAlign.center));
    bytes += generator.feed(1);
    for (final product in products) {
      bytes += generator.text('${product.quantity} x  ${product.product.name}',
          styles: const PosStyles(
            align: PosAlign.left,
            bold: false,
            height: PosTextSize.size2,
            width: PosTextSize.size1,
          ));
    }

    bytes += generator.feed(1);
    bytes += generator.text(
        paper == 80
            ? '------------------------------------------------'
            : '--------------------------------',
        styles: const PosStyles(bold: false, align: PosAlign.center));
    bytes += generator.feed(3);

    bytes += generator.cut();

    return bytes;
  }
}
