import 'dart:developer';
import 'dart:io';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class FileOpenerService {
  static Future<void> openFile(File file, BuildContext context) async {
    try {
      final filePath = file.path;
      log('Attempting to open file: $filePath');

      if (!await file.exists()) {
        log('File does not exist: $filePath');
        throw Exception('File not found');
      }

      final extension = path.extension(filePath).toLowerCase();
      log('File extension: $extension');
      log('File size: ${await file.length()} bytes');

      final result = await OpenFile.open(
        filePath,
        type: _getMimeType(extension),
      );

      if (result.message.contains('No APP found to open this file')) {
        if (!context.mounted) return;

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Aplikasi Tidak Ditemukan'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                    'Tidak ada aplikasi yang dapat membuka file ini. Anda dapat:'),
                const SizedBox(height: 16),
                Text(
                    '1. Install aplikasi untuk membuka file ${extension.toUpperCase()} seperti:'),
                const Padding(
                  padding: EdgeInsets.only(left: 16, top: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('• Microsoft Excel'),
                      Text('• Google Sheets'),
                      Text('• WPS Office'),
                      Text('• OfficeSuite'),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                const Text('2. Atau bagikan file ke aplikasi lain'),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Tutup'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _shareFile(file);
                },
                child: const Text('Bagikan File'),
              ),
            ],
          ),
        );
      } else if (result.type != ResultType.done) {
        log('Error opening file: ${result.message}');
        throw Exception(result.message);
      }
    } catch (e) {
      log('Error in openFile: $e');
      rethrow;
    }
  }

  static String? _getMimeType(String extension) {
    switch (extension) {
      case '.xlsx':
        return 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet';
      case '.xls':
        return 'application/vnd.ms-excel';
      case '.pdf':
        return 'application/pdf';
      default:
        return null;
    }
  }

  static Future<void> _shareFile(File file) async {
    try {
      await Share.shareXFiles(
        [XFile(file.path)],
        subject: 'Share Excel File',
      );
    } catch (e) {
      log('Error sharing file: $e');
    }
  }
}
