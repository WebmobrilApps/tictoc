import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart'; // For defaultTargetPlatform

class DeviceInfoUtil {
  static Future<String> getDeviceModel() async {
    final deviceInfoPlugin = DeviceInfoPlugin();
    try {
      if (defaultTargetPlatform == TargetPlatform.android) {
        final androidInfo = await deviceInfoPlugin.androidInfo;
        return androidInfo.model;
      } else if (defaultTargetPlatform == TargetPlatform.iOS) {
        final iosInfo = await deviceInfoPlugin.iosInfo;
        return iosInfo.utsname.machine;
      } else {
        return 'Unsupported Platform';
      }
    } catch (e) {
      return 'Error retrieving device model: $e';
    }
  }
}
