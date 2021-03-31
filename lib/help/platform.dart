import 'dart:async';
import 'dart:io' show Platform;
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart' as Foundation;
import 'package:device_info/device_info.dart';

const bool isProd = Foundation.kReleaseMode;

class PlatformHelper {
  static const platform = const MethodChannel('flutter.native/helper');

  static Future<bool> isInstalledFromMarket() async {
    bool status = false;

    // development mode is not installed from market
    if (!isProd) {
      return true;
    }

    // apple always install from market
    if (Platform.isIOS) {
      return true;
    }

    // check android
    try {
      status = await platform.invokeMethod('installedFromMarket');
    } on PlatformException catch (e) {
      print(e);
    }

    return status;
  }

  static const List<String> packages = [
    'com.guoshi.httpcanary',
  ];

  static Future<bool> isInstalledOneOfPackages(List<String> advancedPackages) async {
    bool status = false;

    // check android
    try {
      final merged = new List.from(packages)..addAll(advancedPackages);
      status = await platform.invokeMethod('isInstalledOneOfPackages', {
        'packages': merged,
      });
    } on PlatformException catch (e) {
      print(e);
    }

    return status;
  }

  static Future<DeviceInformation> getInfo() async {
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      AndroidDeviceInfo info = await deviceInfoPlugin.androidInfo;

      return new DeviceInformation(
        info.androidId,
        info.model,
        info.device,
        info.version.release,
      );
    }

    IosDeviceInfo info = await deviceInfoPlugin.iosInfo;

    return DeviceInformation(info.identifierForVendor, '', info.model, '');
  }
}

class DeviceInformation {
  String DeviceId;
  String Release;
  String model;
  String device;

  DeviceInformation(String deviceid, model, device, release) {
    this.DeviceId = deviceid;
    this.Release = release;
    this.model = model;
    this.device = device;
  }
}