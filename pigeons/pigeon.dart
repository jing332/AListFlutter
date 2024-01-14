import 'package:pigeon/pigeon.dart';

@HostApi()
abstract class AppConfig {
  bool isWakeLockEnabled();

  void setWakeLockEnabled(bool enabled);

  bool isStartAtBootEnabled();

  void setStartAtBootEnabled(bool enabled);

  bool isAutoCheckUpdateEnabled();

  void setAutoCheckUpdateEnabled(bool enabled);
}

@HostApi()
abstract class Android {
  void startService();

  bool isRunning();

  String getAListVersion();

  String getVersionName();

  int getVersionCode();

  void toast(String msg);

  void longToast(String msg);
}

@FlutterApi()
abstract class Event {
  void onServiceStatusChanged(bool isRunning);
}
