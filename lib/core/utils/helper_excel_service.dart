import 'dart:developer';
import 'dart:io';

import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';

class HelperExcelService {
  static Future<File> saveExcel({
    required String name,
    required Excel excel,
  }) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/$name');
      log("file: $file");
      final bytes = excel.encode();
      await file.writeAsBytes(bytes!);

      return file;
    } catch (e) {
      log("Failed to save excel: $e");
      return Future.error("Failed to save excel: $e");
    }
  }
}
