import 'package:flutter/services.dart';

abstract class Bridge {
  static const MethodChannel _channel = MethodChannel('alistflutter/bridge');

  static void startService() {
    _channel.invokeMethod("startService");
  }

  static void isRunning() {
    _channel.invokeMethod("isRunning");
  }
}
