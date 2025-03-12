import 'dart:convert';
import 'package:seblak_sulthane_app/data/models/response/outlet_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OutletLocalDataSource {
  static const String _keyOutlets = 'outlets';

  static final OutletLocalDataSource _instance =
      OutletLocalDataSource._internal();
  factory OutletLocalDataSource() => _instance;
  OutletLocalDataSource._internal();

  Future<bool> saveOutlet(OutletModel outlet) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      Map<String, dynamic> outlets = {};
      if (prefs.containsKey(_keyOutlets)) {
        outlets = jsonDecode(prefs.getString(_keyOutlets) ?? '{}');
      }

      outlets['${outlet.id}'] = outlet.toMap();

      return await prefs.setString(_keyOutlets, jsonEncode(outlets));
    } catch (e) {
      return false;
    }
  }

  Future<OutletModel?> getOutletById(int id) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      if (!prefs.containsKey(_keyOutlets)) {
        return null;
      }

      final outlets = jsonDecode(prefs.getString(_keyOutlets) ?? '{}');

      if (outlets['$id'] == null) {
        return null;
      }

      return OutletModel.fromMap(outlets['$id']);
    } catch (e) {
      return null;
    }
  }

  Future<List<OutletModel>> getAllOutlets() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      if (!prefs.containsKey(_keyOutlets)) {
        return [];
      }

      final outlets = jsonDecode(prefs.getString(_keyOutlets) ?? '{}');

      return outlets.values
          .map<OutletModel>((outlet) => OutletModel.fromMap(outlet))
          .toList();
    } catch (e) {
      return [];
    }
  }

  Future<bool> clearOutlets() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return await prefs.remove(_keyOutlets);
    } catch (e) {
      return false;
    }
  }

  Future<String> getOutletAddress(int outletId) async {
    try {
      final outlet = await getOutletById(outletId);

      if (outlet != null) {
        String address = '';

        // Add address1 if available
        if (outlet.address1 != null && outlet.address1!.isNotEmpty) {
          address = outlet.address1!;
        }

        // Add address2 if available
        if (outlet.address2 != null && outlet.address2!.isNotEmpty) {
          if (address.isNotEmpty) {
            address += ', '; // Add separator if address1 was present
          }
          address += outlet.address2!;
        }

        // Return the combined address or default if both are empty
        return address.isNotEmpty ? address : 'Seblak Sulthane';
      }

      // If specific outlet not found, try to get the first outlet
      final allOutlets = await getAllOutlets();
      if (allOutlets.isNotEmpty) {
        String address = '';
        final firstOutlet = allOutlets.first;

        // Add address1 if available
        if (firstOutlet.address1 != null && firstOutlet.address1!.isNotEmpty) {
          address = firstOutlet.address1!;
        }

        // Add address2 if available
        if (firstOutlet.address2 != null && firstOutlet.address2!.isNotEmpty) {
          if (address.isNotEmpty) {
            address += ', '; // Add separator if address1 was present
          }
          address += firstOutlet.address2!;
        }

        // Return the combined address or default if both are empty
        return address.isNotEmpty ? address : 'Seblak Sulthane';
      }

      return 'Seblak Sulthane'; // Default fallback
    } catch (e) {
      return 'Seblak Sulthane'; // Default fallback on error
    }
  }
}
