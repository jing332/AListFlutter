import 'package:flutter/services.dart';

abstract class AppConfig {
  static const MethodChannel _channel = MethodChannel('alistflutter/config');

  static Future<bool> isWakLockEnabled() async {
    return await _channel.invokeMethod("isWakeLockEnabled");
  }

  static void setWakeLockEnabled(bool enabled) {
    _channel.invokeMethod("setWakeLockEnabled", enabled);
  }

  static bool isStartAtBootEnabled() {
    return _channel.invokeMethod("isStartAtBootEnabled") as bool;
  }

  static void setStartAtBootEnabled(bool enabled) {
    _channel.invokeMethod("setStartAtBootEnabled", enabled);
  }

  static bool isAutoCheckUpdateEnabled() {
    return _channel.invokeMethod("isAutoCheckUpdateEnabled") as bool;
  }

  static void setAutoCheckUpdateEnabled(bool enabled) {
    _channel.invokeMethod("setAutoCheckUpdateEnabled", enabled);
  }
}
