import 'dart:developer';
import 'dart:io';

import 'package:open_file_plus/open_file_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart';

class HelperPdfService {
  static Future<File> saveDocument({
    required String name,
    required Document pdf,
  }) async {
    try {
      final bytes = await pdf.save();

      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/$name');
      log("berkas: $file");
      await file.writeAsBytes(bytes);

      return file;
    } catch (e) {
      log("Gagal menyimpan dokumen: $e");
      return Future.error("Gagal menyimpan dokumen: $e");
    }
  }

  static Future openFile(File file) async {
    try {
      final url = file.path;
      log("bukaBerkas: $url");
      await OpenFile.open(url, type: "application/pdf");
      log("selesaiBukaBerkas: $url");
    } catch (e) {
      log("Gagal membuka berkas: $e");
    }
  }
}
