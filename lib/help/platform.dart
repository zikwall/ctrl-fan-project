import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart' as Foundation;

const bool isProd = Foundation.kReleaseMode;

class PlatformHelper {
  static const platform = const MethodChannel('flutter.native/helper');

  static Future<bool> isInstalledFromMarket() async {
    bool status = false;

    try {
      status = await platform.invokeMethod('installedFromMarket');
    } on PlatformException catch (e) {
      print(e);
    }

    return status;
  }
}