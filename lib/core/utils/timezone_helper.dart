import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class TimezoneHelper {
  static bool _initialized = false;

  static Future<void> initialize() async {
    if (!_initialized) {
      tz.initializeTimeZones();
      _initialized = true;
    }
  }

  /// Convert UTC DateTime to WIB (Asia/Jakarta)
  static DateTime toWIB(DateTime utcDateTime) {
    try {
      final utc = tz.UTC;
      final jakarta = tz.getLocation('Asia/Jakarta');
      
      // Ensure the DateTime is treated as UTC
      final utcTz = tz.TZDateTime.from(utcDateTime.isUtc ? utcDateTime : utcDateTime.toUtc(), utc);
      final jakartaTz = tz.TZDateTime.from(utcTz, jakarta);
      
      // Convert back to regular DateTime but with WIB time values
      return DateTime(
        jakartaTz.year,
        jakartaTz.month,
        jakartaTz.day,
        jakartaTz.hour,
        jakartaTz.minute,
        jakartaTz.second,
        jakartaTz.millisecond,
        jakartaTz.microsecond,
      );
    } catch (e) {
      // Fallback: manually add 7 hours if timezone conversion fails
      return utcDateTime.add(const Duration(hours: 7));
    }
  }

  /// Convert WIB DateTime to UTC
  static DateTime toUTC(DateTime wibDateTime) {
    try {
      final jakarta = tz.getLocation('Asia/Jakarta');
      final utc = tz.UTC;
      
      // Create TZDateTime in Jakarta timezone
      final jakartaTz = tz.TZDateTime(
        jakarta,
        wibDateTime.year,
        wibDateTime.month,
        wibDateTime.day,
        wibDateTime.hour,
        wibDateTime.minute,
        wibDateTime.second,
        wibDateTime.millisecond,
        wibDateTime.microsecond,
      );
      
      // Convert to UTC
      final utcTz = tz.TZDateTime.from(jakartaTz, utc);
      
      // Convert back to regular DateTime
      return DateTime(
        utcTz.year,
        utcTz.month,
        utcTz.day,
        utcTz.hour,
        utcTz.minute,
        utcTz.second,
        utcTz.millisecond,
        utcTz.microsecond,
      ).toUtc();
    } catch (e) {
      // Fallback: manually subtract 7 hours if timezone conversion fails
      return wibDateTime.subtract(const Duration(hours: 7)).toUtc();
    }
  }

  /// Get current time in WIB
  static DateTime nowWIB() {
    try {
      final jakarta = tz.getLocation('Asia/Jakarta');
      final now = tz.TZDateTime.now(jakarta);
      
      return DateTime(
        now.year,
        now.month,
        now.day,
        now.hour,
        now.minute,
        now.second,
        now.millisecond,
        now.microsecond,
      );
    } catch (e) {
      // Fallback: get UTC now and add 7 hours
      return DateTime.now().toUtc().add(const Duration(hours: 7));
    }
  }
}

