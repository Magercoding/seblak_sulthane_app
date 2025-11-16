/// Example script to clear all local data
///
/// Usage:
/// 1. Import this file in your main.dart or settings page
/// 2. Call ClearLocalData.clearAllData() when needed
///
/// Or run directly (if configured):
/// dart run clear_data_example.dart

import 'package:seblak_sulthane_app/core/utils/clear_local_data.dart';

void main() async {
  print('🗑️ Starting to clear all local data...');

  final success = await ClearLocalData.clearAllData();

  if (success) {
    print('✅ All local data cleared successfully!');
    print('📱 You can now build the app with clean data.');
  } else {
    print('❌ Failed to clear local data. Please check logs.');
  }
}
