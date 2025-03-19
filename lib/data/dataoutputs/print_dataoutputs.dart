import 'dart:math';

import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';
import 'package:flutter/services.dart';
import 'package:seblak_sulthane_app/core/extensions/int_ext.dart';
import 'package:seblak_sulthane_app/core/extensions/string_ext.dart';
import 'package:seblak_sulthane_app/data/datasources/auth_local_datasource.dart';
import 'package:seblak_sulthane_app/data/datasources/auth_remote_datasource.dart';
import 'package:seblak_sulthane_app/data/datasources/outlet_datasource.dart';
import 'package:seblak_sulthane_app/data/models/response/outlet_model.dart';
import 'package:seblak_sulthane_app/data/models/response/summary_response_model.dart';
import 'package:seblak_sulthane_app/data/models/response/user_model.dart';
import 'package:seblak_sulthane_app/presentation/home/models/product_quantity.dart';
import 'package:intl/intl.dart';
import 'package:image/image.dart' as img;
import 'package:seblak_sulthane_app/core/utils/date_formatter.dart';

class PrintDataoutputs {
  PrintDataoutputs._init();

  static final PrintDataoutputs instance = PrintDataoutputs._init();

  static Future<UserModel?> _getUserProfile() async {
    try {
      final authRemoteDatasource = AuthRemoteDatasource();
      final result = await authRemoteDatasource.getProfile();

      UserModel? user;
      result.fold(
        (error) async {
          user = await _getUserProfileFromLocal();
        },
        (userData) {
          user = userData;

          _saveUserProfileToLocal(userData);
        },
      );

      return user;
    } catch (e) {
      return _getUserProfileFromLocal();
    }
  }

  static Future<UserModel?> _getUserProfileFromLocal() async {
    try {
      final authLocalDataSource = AuthLocalDataSource();
      return await authLocalDataSource.getUserData();
    } catch (e) {
      return null;
    }
  }

  static Future<void> _saveUserProfileToLocal(UserModel user) async {
    try {
      final authLocalDataSource = AuthLocalDataSource();
      await authLocalDataSource.saveUserData(user);
    } catch (e) {
      print('Failed to save user profile to local: $e');
    }
  }

  static Future<int?> _fetchOutletIdFromProfile() async {
    try {
      final user = await _getUserProfile();
      return user?.outletId;
    } catch (e) {
      return null;
    }
  }

  static Future<String> _getCashierNameFromProfile() async {
    print("⭐ Starting to get cashier name from profile");
    try {
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
        print('❌ Failed to get user name from local storage: $localError');
      }

      print("🌐 Attempting to get profile from remote");
      try {
        final authRemoteDatasource = AuthRemoteDatasource();
        final result = await authRemoteDatasource.getProfile();

        String userName = "Cashier";
        result.fold(
          (error) {
            print("❌ Remote profile error: $error");
          },
          (userData) {
            if (userData.name.isNotEmpty) {
              userName = userData.name;
              print("✅ Using name from remote: ${userData.name}");

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
        throw remoteError;
      }
    } catch (e) {
      print("❌ Final error getting cashier name: $e");
      return "Cashier";
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
      String namaKasir,
      String customerName,
      int paper,
      {int? outletId,
      String orderType = ''}) async {
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

    try {
      final authLocalDataSource = AuthLocalDataSource();
      final userData = await authLocalDataSource.getUserData();
      if (userData.name.isNotEmpty) {
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
    String outletAddress = 'OFFLINE';

    if (outlet != null) {
      if (outlet.address1 != null && outlet.address1!.isNotEmpty) {
        outletAddress = outlet.address1!;

        if (outlet.address2 != null && outlet.address2!.isNotEmpty) {
          outletAddress += ', ${outlet.address2!}';
        }
      }
    }
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
    if (orderType.isNotEmpty) {
      bytes += generator.row([
        PosColumn(
          text: 'Order Type',
          width: 6,
          styles: const PosStyles(align: PosAlign.left),
        ),
        PosColumn(
          text: orderType == 'take_away' ? 'TAKE AWAY' : 'DINE IN',
          width: 6,
          styles: const PosStyles(align: PosAlign.right, bold: true),
        ),
      ]);
    }
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
              .currencyFormatRp,
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

    double taxPercentage = 0;
    if (subTotal > 0) {
      taxPercentage = (tax / subTotal) * 100;
    }

    bytes += generator.row([
      PosColumn(
        text: 'Tax (${taxPercentage.toStringAsFixed(0)}%)',
        width: 6,
        styles: const PosStyles(align: PosAlign.left),
      ),
      PosColumn(
        text: tax.currencyFormatRpV2,
        width: 6,
        styles: const PosStyles(align: PosAlign.right),
      ),
    ]);

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

  Future<List<int>> printChecker(List<ProductQuantity> products,
      int tableNumber, String draftName, String cashierName, int paper,
      {int? outletId, String orderType = ''}) async {
    List<int> bytes = [];

    final profile = await CapabilityProfile.load();
    final generator =
        Generator(paper == 58 ? PaperSize.mm58 : PaperSize.mm80, profile);

    outletId ??= await PrintDataoutputs._fetchOutletIdFromProfile();
    outletId ??= 1;

    print("📝 CHECKER - Cashier name parameter received: '$cashierName'");

    print("📝 CHECKER - Directly fetching cashier name from local storage");
    try {
      final authLocalDataSource = AuthLocalDataSource();
      final userData = await authLocalDataSource.getUserData();
      if (userData.name.isNotEmpty) {
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
        width: 12,
        styles: const PosStyles(align: PosAlign.left),
      ),
    ]);
    if (orderType.isNotEmpty) {
      bytes +=
          generator.text(orderType == 'take_away' ? 'TAKE AWAY' : 'DINE IN',
              styles: const PosStyles(
                bold: true,
                align: PosAlign.center,
                height: PosTextSize.size2,
                width: PosTextSize.size2,
              ));
      bytes += generator.feed(1);
    }

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

  // Improved helper method to safely parse any numeric value to double
  double _parseToDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) {
      try {
        // Remove any currency symbols or formatting
        String cleanValue = value
            .replaceAll('Rp', '')
            .replaceAll('.', '') // Remove thousand separators
            .replaceAll(',', '.') // Convert comma to decimal point
            .trim();
        return double.parse(cleanValue);
      } catch (_) {
        return 0.0;
      }
    }
    return 0.0;
  }

  // Updated printSummaryReport method with improved value parsing and formatting
  Future<List<int>> printSummaryReport(
      EnhancedSummaryData summary, String searchDateFormatted, int paper,
      {int? outletId}) async {
    List<int> bytes = [];

    final profile = await CapabilityProfile.load();
    final generator =
        Generator(paper == 58 ? PaperSize.mm58 : PaperSize.mm80, profile);

    outletId ??= await PrintDataoutputs._fetchOutletIdFromProfile();
    outletId ??= 1;

    final String cashierName = await _getCashierNameFromProfile();

    final OutletModel? outlet = await PrintDataoutputs._getOutletInfo(outletId);
    String outletAddress = 'OFFLINE';

    if (outlet != null) {
      if (outlet.address1 != null && outlet.address1!.isNotEmpty) {
        outletAddress = outlet.address1!;

        if (outlet.address2 != null && outlet.address2!.isNotEmpty) {
          outletAddress += ', ${outlet.address2!}';
        }
      }
    }

    final String outletPhone = outlet?.phone ?? 'Seblak Sulthane';
    final String outletName = outlet?.name ?? 'Seblak Sulthane';

    try {
      final ByteData data =
          await rootBundle.load('assets/logo/seblak_sulthane.png');
      final Uint8List bytesData = data.buffer.asUint8List();
      final img.Image? originalImage = img.decodeImage(bytesData);

      bytes += generator.reset();

      if (originalImage != null) {
        final img.Image grayscaleImage = img.grayscale(originalImage);
        final img.Image resizedImage =
            img.copyResize(grayscaleImage, width: 240);
        bytes += generator.imageRaster(resizedImage, align: PosAlign.center);
        bytes += generator.feed(2);
      }
    } catch (e) {
      print("Error loading logo: $e");
      bytes += generator.reset();
    }

    bytes += generator.text(outletName,
        styles: const PosStyles(bold: true, align: PosAlign.center));
    bytes += generator.text(outletAddress,
        styles: const PosStyles(bold: false, align: PosAlign.center));
    bytes += generator.text(outletPhone,
        styles: const PosStyles(bold: false, align: PosAlign.center));

    bytes += generator.text(
        paper == 80
            ? '------------------------------------------------'
            : '--------------------------------',
        styles: const PosStyles(bold: false, align: PosAlign.center));

    bytes += generator.text('SUMMARY REPORT',
        styles: const PosStyles(align: PosAlign.center, bold: true));

    bytes += generator.row([
      PosColumn(
        text: searchDateFormatted,
        width: 12,
        styles: const PosStyles(align: PosAlign.center),
      ),
    ]);

    bytes += generator.row([
      PosColumn(
        text: 'Printed:',
        width: 4,
        styles: const PosStyles(align: PosAlign.left),
      ),
      PosColumn(
        text: DateFormat('dd MMM yyyy HH:mm').format(DateTime.now()),
        width: 8,
        styles: const PosStyles(align: PosAlign.right),
      ),
    ]);

    bytes += generator.row([
      PosColumn(
        text: 'By:',
        width: 4,
        styles: const PosStyles(align: PosAlign.left),
      ),
      PosColumn(
        text: cashierName,
        width: 8,
        styles: const PosStyles(align: PosAlign.right),
      ),
    ]);

    bytes += generator.text(
        paper == 80
            ? '------------------------------------------------'
            : '--------------------------------',
        styles: const PosStyles(bold: false, align: PosAlign.center));

    bytes += generator.text('FINANCIAL SUMMARY',
        styles: const PosStyles(align: PosAlign.center, bold: true));
    bytes += generator.feed(1);

    // Parse total revenue as double, handling various input formats
    double totalRevenue = _parseToDouble(summary.totalRevenue);
    bytes += generator.row([
      PosColumn(
        text: 'Total Revenue',
        width: 6,
        styles: const PosStyles(align: PosAlign.left),
      ),
      PosColumn(
        text: 'Rp ${_formatCurrency(totalRevenue)}',
        width: 6,
        styles: const PosStyles(align: PosAlign.right),
      ),
    ]);

    // Parse total subtotal as double, handling various input formats
    double totalSubtotal = _parseToDouble(summary.totalSubtotal);
    bytes += generator.row([
      PosColumn(
        text: 'Total Subtotal',
        width: 6,
        styles: const PosStyles(align: PosAlign.left),
      ),
      PosColumn(
        text: 'Rp ${_formatCurrency(totalSubtotal)}',
        width: 6,
        styles: const PosStyles(align: PosAlign.right),
      ),
    ]);

    // Parse total tax as double, handling various input formats
    double totalTax = _parseToDouble(summary.totalTax);
    bytes += generator.row([
      PosColumn(
        text: 'Total Tax',
        width: 6,
        styles: const PosStyles(align: PosAlign.left),
      ),
      PosColumn(
        text: 'Rp ${_formatCurrency(totalTax)}',
        width: 6,
        styles: const PosStyles(align: PosAlign.right),
      ),
    ]);

    // Parse total discount as double, handling various input formats
    double totalDiscount = _parseToDouble(summary.totalDiscount);
    bytes += generator.row([
      PosColumn(
        text: 'Total Discount',
        width: 6,
        styles: const PosStyles(align: PosAlign.left),
      ),
      PosColumn(
        text: 'Rp ${_formatCurrency(totalDiscount)}',
        width: 6,
        styles: const PosStyles(align: PosAlign.right),
      ),
    ]);

    // Parse service charge, handling various input formats
    double serviceCharge = 0.0;
    if (summary.totalServiceCharge is num) {
      serviceCharge = (summary.totalServiceCharge as num).toDouble();
    } else if (summary.totalServiceCharge is String) {
      serviceCharge = _parseToDouble(summary.totalServiceCharge as String);
    }

    bytes += generator.row([
      PosColumn(
        text: 'Service Charge',
        width: 6,
        styles: const PosStyles(align: PosAlign.left),
      ),
      PosColumn(
        text: 'Rp ${_formatCurrency(serviceCharge)}',
        width: 6,
        styles: const PosStyles(align: PosAlign.right),
      ),
    ]);

    bytes += generator.text(
        paper == 80
            ? '------------------------------------------------'
            : '--------------------------------',
        styles: const PosStyles(bold: false, align: PosAlign.center));

    bytes += generator.text('DAILY CASH FLOW',
        styles: const PosStyles(align: PosAlign.center, bold: true));
    bytes += generator.feed(1);

    // Opening Balance
    double openingBalance = summary.openingBalance?.toDouble() ?? 0.0;
    bytes += generator.row([
      PosColumn(
        text: 'Opening Balance',
        width: 6,
        styles: const PosStyles(align: PosAlign.left),
      ),
      PosColumn(
        text: 'Rp ${_formatCurrency(openingBalance)}',
        width: 6,
        styles: const PosStyles(align: PosAlign.right),
      ),
    ]);

    // Expenses
    double expenses = summary.expenses?.toDouble() ?? 0.0;
    bytes += generator.row([
      PosColumn(
        text: 'Expenses',
        width: 6,
        styles: const PosStyles(align: PosAlign.left),
      ),
      PosColumn(
        text: '- Rp ${_formatCurrency(expenses)}',
        width: 6,
        styles: const PosStyles(align: PosAlign.right),
      ),
    ]);

    // Cash Sales
    double cashSales = summary.getCashSalesAsInt().toDouble();
    bytes += generator.row([
      PosColumn(
        text: 'Cash Sales',
        width: 6,
        styles: const PosStyles(align: PosAlign.left),
      ),
      PosColumn(
        text: 'Rp ${_formatCurrency(cashSales)}',
        width: 6,
        styles: const PosStyles(align: PosAlign.right),
      ),
    ]);

    // QRIS Sales
    double qrisSales = summary.getQrisSalesAsInt().toDouble();
    bytes += generator.row([
      PosColumn(
        text: 'QRIS Sales',
        width: 6,
        styles: const PosStyles(align: PosAlign.left),
      ),
      PosColumn(
        text: 'Rp ${_formatCurrency(qrisSales)}',
        width: 6,
        styles: const PosStyles(align: PosAlign.right),
      ),
    ]);

    // QRIS Fee
    double qrisFee = _parseToDouble(summary.qrisFee);
    bytes += generator.row([
      PosColumn(
        text: 'QRIS Fee',
        width: 6,
        styles: const PosStyles(align: PosAlign.left),
      ),
      PosColumn(
        text: '- Rp ${_formatCurrency(qrisFee)}',
        width: 6,
        styles: const PosStyles(align: PosAlign.right),
      ),
    ]);

    // Beverage Sales
    double beverageSales = summary.getBeverageSalesAsInt().toDouble();
    bytes += generator.row([
      PosColumn(
        text: 'Beverage Sales',
        width: 6,
        styles: const PosStyles(align: PosAlign.left),
      ),
      PosColumn(
        text: 'Rp ${_formatCurrency(beverageSales)}',
        width: 6,
        styles: const PosStyles(align: PosAlign.right),
      ),
    ]);

    // Closing Balance
    double closingBalance = summary.closingBalance?.toDouble() ?? 0.0;
    bytes += generator.row([
      PosColumn(
        text: 'Closing Balance',
        width: 6,
        styles: const PosStyles(align: PosAlign.left, bold: true),
      ),
      PosColumn(
        text: 'Rp ${_formatCurrency(closingBalance)}',
        width: 6,
        styles: const PosStyles(align: PosAlign.right, bold: true),
      ),
    ]);

    bytes += generator.text(
        paper == 80
            ? '------------------------------------------------'
            : '--------------------------------',
        styles: const PosStyles(bold: false, align: PosAlign.center));

    if (summary.paymentMethods != null) {
      bytes += generator.text('PAYMENT METHODS',
          styles: const PosStyles(align: PosAlign.center, bold: true));
      bytes += generator.feed(1);

      if (summary.paymentMethods?.cash != null) {
        bytes += generator.row([
          PosColumn(
            text: 'Cash (${summary.paymentMethods!.cash!.count} txn)',
            width: 6,
            styles: const PosStyles(align: PosAlign.left),
          ),
          PosColumn(
            text:
                'Rp ${_formatCurrency(summary.paymentMethods!.cash!.getTotalAsInt().toDouble())}',
            width: 6,
            styles: const PosStyles(align: PosAlign.right),
          ),
        ]);

        // Add Cash QRIS Fees
        double cashQrisFees =
            _parseToDouble(summary.paymentMethods!.cash!.qrisFees);
        bytes += generator.row([
          PosColumn(
            text: 'Cash QRIS Fees',
            width: 6,
            styles: const PosStyles(align: PosAlign.left),
          ),
          PosColumn(
            text: '- Rp ${_formatCurrency(cashQrisFees)}',
            width: 6,
            styles: const PosStyles(align: PosAlign.right),
          ),
        ]);
      }

      if (summary.paymentMethods?.qris != null) {
        bytes += generator.row([
          PosColumn(
            text: 'QRIS (${summary.paymentMethods!.qris!.count} txn)',
            width: 6,
            styles: const PosStyles(align: PosAlign.left),
          ),
          PosColumn(
            text:
                'Rp ${_formatCurrency(summary.paymentMethods!.qris!.getTotalAsInt().toDouble())}',
            width: 6,
            styles: const PosStyles(align: PosAlign.right),
          ),
        ]);

        // Add QRIS Fees
        double qrisFees =
            _parseToDouble(summary.paymentMethods!.qris!.qrisFees);
        bytes += generator.row([
          PosColumn(
            text: 'QRIS Fees',
            width: 6,
            styles: const PosStyles(align: PosAlign.left),
          ),
          PosColumn(
            text: '- Rp ${_formatCurrency(qrisFees)}',
            width: 6,
            styles: const PosStyles(align: PosAlign.right),
          ),
        ]);
      }

      bytes += generator.text(
          paper == 80
              ? '------------------------------------------------'
              : '--------------------------------',
          styles: const PosStyles(bold: false, align: PosAlign.center));
    }

    if (summary.dailyBreakdown != null && summary.dailyBreakdown!.isNotEmpty) {
      bytes += generator.text('DAILY BREAKDOWN',
          styles: const PosStyles(align: PosAlign.center, bold: true));
      bytes += generator.feed(1);

      for (var i = 0; i < summary.dailyBreakdown!.length; i++) {
        final day = summary.dailyBreakdown![i];

        bytes += generator.text('Date: ${day.date}',
            styles: const PosStyles(align: PosAlign.left, bold: true));

        // Opening Balance
        double dayOpeningBalance = day.openingBalance?.toDouble() ?? 0.0;
        bytes += generator.row([
          PosColumn(
            text: 'Opening:',
            width: 5,
            styles: const PosStyles(align: PosAlign.left),
          ),
          PosColumn(
            text: 'Rp ${_formatCurrency(dayOpeningBalance)}',
            width: 7,
            styles: const PosStyles(align: PosAlign.right),
          ),
        ]);

        // Expenses
        double dayExpenses = day.expenses?.toDouble() ?? 0.0;
        bytes += generator.row([
          PosColumn(
            text: 'Expenses:',
            width: 5,
            styles: const PosStyles(align: PosAlign.left),
          ),
          PosColumn(
            text: '- Rp ${_formatCurrency(dayExpenses)}',
            width: 7,
            styles: const PosStyles(align: PosAlign.right),
          ),
        ]);

        // Cash Sales
        double dayCashSales = day.getCashSalesAsInt().toDouble();
        bytes += generator.row([
          PosColumn(
            text: 'Cash Sales:',
            width: 5,
            styles: const PosStyles(align: PosAlign.left),
          ),
          PosColumn(
            text: 'Rp ${_formatCurrency(dayCashSales)}',
            width: 7,
            styles: const PosStyles(align: PosAlign.right),
          ),
        ]);

        // QRIS Sales
        double dayQrisSales = day.getQrisSalesAsInt().toDouble();
        bytes += generator.row([
          PosColumn(
            text: 'QRIS Sales:',
            width: 5,
            styles: const PosStyles(align: PosAlign.left),
          ),
          PosColumn(
            text: 'Rp ${_formatCurrency(dayQrisSales)}',
            width: 7,
            styles: const PosStyles(align: PosAlign.right),
          ),
        ]);

        // QRIS Fee
        double dayQrisFee = _parseToDouble(day.qrisFee);
        bytes += generator.row([
          PosColumn(
            text: 'QRIS Fee:',
            width: 5,
            styles: const PosStyles(align: PosAlign.left),
          ),
          PosColumn(
            text: '- Rp ${_formatCurrency(dayQrisFee)}',
            width: 7,
            styles: const PosStyles(align: PosAlign.right),
          ),
        ]);

        // Total Sales
        double dayTotalSales = _parseToDouble(day.totalSales);
        bytes += generator.row([
          PosColumn(
            text: 'Total Sales:',
            width: 5,
            styles: const PosStyles(align: PosAlign.left),
          ),
          PosColumn(
            text: 'Rp ${_formatCurrency(dayTotalSales)}',
            width: 7,
            styles: const PosStyles(align: PosAlign.right),
          ),
        ]);

        // Closing Balance
        double dayClosingBalance = day.closingBalance?.toDouble() ?? 0.0;
        bytes += generator.row([
          PosColumn(
            text: 'Closing:',
            width: 5,
            styles: const PosStyles(align: PosAlign.left),
          ),
          PosColumn(
            text: 'Rp ${_formatCurrency(dayClosingBalance)}',
            width: 7,
            styles: const PosStyles(align: PosAlign.right, bold: true),
          ),
        ]);

        if (i < summary.dailyBreakdown!.length - 1) {
          bytes += generator.text(
              paper == 80 ? '----------------' : '------------',
              styles: const PosStyles(bold: false, align: PosAlign.center));
        }
      }
    }

    bytes += generator.feed(3);
    bytes += generator.cut();

    return bytes;
  }

  // Updated printEndShift method with improved formatting and handling of negative values
  Future<List<int>> printEndShift(
      EnhancedSummaryData summary, String searchDateFormatted, int paper,
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

    final OutletModel? outlet = await PrintDataoutputs._getOutletInfo(outletId);
    final String outletName = outlet?.name ?? 'Seblak Sulthane';

    if (orginalImage != null) {
      final img.Image grayscalledImage = img.grayscale(orginalImage);
      final img.Image resizedImage =
          img.copyResize(grayscalledImage, width: 240);
      bytes += generator.imageRaster(resizedImage, align: PosAlign.center);
      bytes += generator.feed(3);
    }

    bytes += generator.reset();

    bytes += generator.text("END SHIFT",
        styles: const PosStyles(align: PosAlign.center, bold: true));

    bytes += generator.text(
        paper == 80
            ? "================================================"
            : "================================",
        styles: const PosStyles(align: PosAlign.center));

    bytes += generator.text('Name: $outletName',
        styles: const PosStyles(align: PosAlign.left, bold: true));

    final singleDate = extractSingleDate(searchDateFormatted);
    final formattedDate = formatDate(singleDate);

    bytes += generator.text('Date: $formattedDate',
        styles: const PosStyles(align: PosAlign.left, bold: true));

    final DateTime now = DateTime.now();
    final String endTime = DateFormat('dd/MM/yyyy HH:mm:ss').format(now);

    bytes += generator.text('Printed: $endTime',
        styles: const PosStyles(align: PosAlign.left, bold: true));

    bytes += generator.text(
        paper == 80
            ? "================================================"
            : "================================",
        styles: const PosStyles(align: PosAlign.center));

    // Initial Cash (Opening Balance)
    double openingBalance = summary.openingBalance?.toDouble() ?? 0.0;
    bytes += generator.row([
      PosColumn(
        text: "Initial Cash",
        width: 6,
        styles: const PosStyles(align: PosAlign.left),
      ),
      PosColumn(
        text: formatNumberWithoutDecimal(openingBalance),
        width: 6,
        styles: const PosStyles(align: PosAlign.right),
      ),
    ]);

    // Cash Payment
    double cashSales = summary.getCashSalesAsInt().toDouble();
    bytes += generator.row([
      PosColumn(
        text: "Cash Payment",
        width: 6,
        styles: const PosStyles(align: PosAlign.left),
      ),
      PosColumn(
        text: formatNumberWithoutDecimal(cashSales),
        width: 6,
        styles: const PosStyles(align: PosAlign.right),
      ),
    ]);

    // Other Expenses
    double expenses = summary.expenses?.toDouble() ?? 0.0;
    bytes += generator.row([
      PosColumn(
        text: "Other Expenses",
        width: 6,
        styles: const PosStyles(align: PosAlign.left),
      ),
      PosColumn(
        text: formatNumberWithoutDecimal(expenses),
        width: 6,
        styles: const PosStyles(align: PosAlign.right),
      ),
    ]);

    // Add QRIS Fee as an expense
    double qrisFeeAmount = _parseToDouble(summary.qrisFee);
    bytes += generator.row([
      PosColumn(
        text: "QRIS Fee",
        width: 6,
        styles: const PosStyles(align: PosAlign.left),
      ),
      PosColumn(
        text: formatNumberWithoutDecimal(qrisFeeAmount),
        width: 6,
        styles: const PosStyles(align: PosAlign.right),
      ),
    ]);

    // Calculate final cash including QRIS fee
    double totalFinalCash =
        openingBalance + cashSales - expenses - qrisFeeAmount;

    bytes += generator.row([
      PosColumn(
        text: "Total Final Cash",
        width: 7,
        styles: const PosStyles(align: PosAlign.left),
      ),
      PosColumn(
        text: formatNumberWithoutDecimal(totalFinalCash),
        width: 5,
        styles: const PosStyles(align: PosAlign.right),
      ),
    ]);

    bytes += generator.row([
      PosColumn(
        text: "Total Cash in Drawer",
        width: 8,
        styles: const PosStyles(align: PosAlign.left),
      ),
      PosColumn(
        text: formatNumberWithoutDecimal(totalFinalCash),
        width: 4,
        styles: const PosStyles(align: PosAlign.right),
      ),
    ]);

    bytes += generator.row([
      PosColumn(
        text: "Difference",
        width: 6,
        styles: const PosStyles(align: PosAlign.left),
      ),
      PosColumn(
        text: "0",
        width: 6,
        styles: const PosStyles(align: PosAlign.right),
      ),
    ]);

    // QRIS Sales (Other Payment)
    double qrisSales = summary.getQrisSalesAsInt().toDouble();
    bytes += generator.row([
      PosColumn(
        text: "Total Other Payment",
        width: 8,
        styles: const PosStyles(align: PosAlign.left),
      ),
      PosColumn(
        text: formatNumberWithoutDecimal(qrisSales),
        width: 4,
        styles: const PosStyles(align: PosAlign.right),
      ),
    ]);

    bytes += generator.feed(3);
    bytes += generator.cut();

    return bytes;
  }

  String _formatCurrency(double value) {
    return value.toStringAsFixed(2).replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
  }

  String formatNumberWithoutDecimal(double value) {
    final formatter = NumberFormat("#,###", "id_ID");
    return formatter.format(value.round());
  }

  String extractSingleDate(String dateRange) {
    final parts = dateRange.split(' to ');
    return parts.isNotEmpty ? parts[0] : dateRange;
  }

  String formatDate(String dateString) {
    final inputFormat = DateFormat('d MMMM yyyy', 'id_ID');
    final outputFormat = DateFormat('yyyy-MM-dd');

    try {
      final date = inputFormat.parse(dateString);
      return outputFormat.format(date);
    } catch (e) {
      return dateString;
    }
  }
}
