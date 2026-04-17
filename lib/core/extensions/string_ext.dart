import 'package:intl/intl.dart';

extension StringExt on String {
  int get toIntegerFromText {
    final cleanedText = replaceAll(RegExp(r'[^0-9]'), '');
    final parsedValue = int.tryParse(cleanedText) ?? 0;
    return parsedValue;
  }

  String get currencyFormatRp {
    final parsedValue = int.tryParse(this) ?? 0;
    return NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp ',
      decimalDigits: 0,
    ).format(parsedValue);
  }

  String get currencyFormatRpV3 {
    final formatter = NumberFormat('#,##0', 'id_ID');
    try {
      return 'Rp ${formatter.format(int.parse(this))}';
    } catch (_) {
      try {
        return 'Rp ${formatter.format(double.parse(this).round())}';
      } catch (_) {
        return this;
      }
    }
  }
}
