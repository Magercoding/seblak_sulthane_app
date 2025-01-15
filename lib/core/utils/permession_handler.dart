import 'dart:developer';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

class PermessionHelper {
  /// Method to check and request storage or photos/media permission.
  Future<bool> checkPermission() async {
    final deviceInfo = await DeviceInfoPlugin().androidInfo;
    bool permissionStatus;

    if (deviceInfo.version.sdkInt > 32) {
      // For Android 33+ (API level 33 and above)
      final photoPermission = await Permission.photos.request().isGranted;

      permissionStatus = photoPermission;

      if (!permissionStatus) {
        log('Izin foto/media tidak diberikan. Membuka pengaturan aplikasi.');
        openAppSettings();
      }
    } else {
      // For Android < 33
      permissionStatus = await Permission.storage.request().isGranted;
      if (!permissionStatus) {
        log('Izin penyimpanan tidak diberikan. Membuka pengaturan aplikasi.');
        openAppSettings();
      }
    }

    log('Permission status: $permissionStatus');
    return permissionStatus;
  }

  /// Method to check and request Bluetooth-related permissions.
  Future<bool> checkBluetoothPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.bluetooth,
      Permission.bluetoothScan,
      Permission.bluetoothAdvertise,
      Permission.bluetoothConnect,
    ].request();

    // Check if all permissions are granted
    bool allGranted = statuses.values.every((status) => status.isGranted);

    if (!allGranted) {
      log("Izin Bluetooth tidak lengkap. Membuka pengaturan aplikasi.");
      openAppSettings();
    }

    log("Bluetooth Permission statuses: $statuses");
    return allGranted;
  }

  /// Helper function to print statuses of requested permissions.
  void printPermissionStatuses(List<Permission> permissions) async {
    Map<Permission, PermissionStatus> statuses = await permissions.request();
    statuses.forEach((permission, status) {
      log("Permission: $permission, Status: $status");
      if (status.isDenied) {
        log("$permission ditolak. Membuka pengaturan aplikasi.");
        openAppSettings();
      }
    });
  }

  /// Method to request specific permissions (e.g., custom list of permissions).
  Future<bool> requestSpecificPermissions(List<Permission> permissions) async {
    Map<Permission, PermissionStatus> statuses = await permissions.request();
    bool allGranted = statuses.values.every((status) => status.isGranted);

    if (!allGranted) {
      log("Beberapa izin tidak diberikan. Membuka pengaturan aplikasi.");
      openAppSettings();
    }

    log("Specific Permission statuses: $statuses");
    return allGranted;
  }
}
