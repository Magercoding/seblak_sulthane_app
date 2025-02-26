import 'package:intl/intl.dart';

extension DoubleExt on double {
  String get currencyFormatRp => NumberFormat.currency(
        locale: 'id',
        symbol: 'Rp. ',
        decimalDigits: 2, // Tampilkan 2 angka desimal
      ).format(this);
}
