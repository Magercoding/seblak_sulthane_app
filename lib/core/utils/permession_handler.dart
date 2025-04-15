import 'dart:developer';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

class PermessionHelper {
  Future<bool> checkPermission() async {
    final deviceInfo = await DeviceInfoPlugin().androidInfo;
    bool permissionStatus;

    if (deviceInfo.version.sdkInt > 32) {
      final photoPermission = await Permission.photos.request().isGranted;

      permissionStatus = photoPermission;

      if (!permissionStatus) {
        log('Izin foto/media tidak diberikan. Membuka pengaturan aplikasi.');
        openAppSettings();
      }
    } else {
      permissionStatus = await Permission.storage.request().isGranted;
      if (!permissionStatus) {
        log('Izin penyimpanan tidak diberikan. Membuka pengaturan aplikasi.');
        openAppSettings();
      }
    }

    log('Permission status: $permissionStatus');
    return permissionStatus;
  }

  Future<bool> checkBluetoothPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.bluetooth,
      Permission.bluetoothScan,
      Permission.bluetoothAdvertise,
      Permission.bluetoothConnect,
    ].request();

    bool allGranted = statuses.values.every((status) => status.isGranted);

    if (!allGranted) {
      log("Izin Bluetooth tidak lengkap. Membuka pengaturan aplikasi.");
      openAppSettings();
    }

    log("Bluetooth Permission statuses: $statuses");
    return allGranted;
  }

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
