import 'dart:io';

import 'package:flutter/foundation.dart';

class PlatformInfo {
  static PlatformType get getCurrentPlatformType {
    if (kIsWeb) {
      return PlatformType.Web;
    }
    if (Platform.isMacOS) {
      return PlatformType.MacOS;
    }
    if (Platform.isFuchsia) {
      return PlatformType.Fuchsia;
    }
    if (Platform.isLinux) {
      return PlatformType.Linux;
    }
    if (Platform.isWindows) {
      return PlatformType.Windows;
    }
    if (Platform.isIOS) {
      return PlatformType.iOS;
    }
    if (Platform.isAndroid) {
      return PlatformType.Android;
    }
    return PlatformType.Unknown;
  }

  static bool get isDesktop =>
      Platform.isMacOS || Platform.isLinux || Platform.isWindows;

  static bool get isMobile => Platform.isIOS || Platform.isAndroid;

  static bool get isWeb => kIsWeb;

  static bool get isNotWeb => !kIsWeb;
}

enum PlatformType { Web, iOS, Android, MacOS, Fuchsia, Linux, Windows, Unknown }
