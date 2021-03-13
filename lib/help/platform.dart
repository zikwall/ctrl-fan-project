import 'dart:async';
import 'dart:io' show Platform;
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart' as Foundation;

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
}