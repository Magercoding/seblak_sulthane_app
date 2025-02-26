import 'package:intl/intl.dart';

extension StringExt on String {
  int get toIntegerFromText {
    final cleanedText = replaceAll(RegExp(r'[^0-9]'), '');
    final parsedValue = int.tryParse(cleanedText) ?? 0;
    return parsedValue;
  }

  String get currencyFormatRpV2 {
    final parsedValue = int.tryParse(this) ?? 0;
    return NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp ',
      decimalDigits: 0,
    ).format(parsedValue);
  }

  String get currencyFormatRpV3 {
    // Try parsing the string as an integer first
    try {
      final value = int.parse(this);
      return 'Rp ${value.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}';
    } catch (e) {
      // If it can't be parsed as int, try to handle it as a double
      try {
        final value = double.parse(this);
        return 'Rp ${value.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}';
      } catch (e) {
        // Return the original string if it can't be parsed
        return this;
      }
    }
  }
}
