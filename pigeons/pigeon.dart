import 'package:pigeon/pigeon.dart';

@HostApi()
abstract class AppConfig {
  bool isWakeLockEnabled();

  void setWakeLockEnabled(bool enabled);

  bool isStartAtBootEnabled();

  void setStartAtBootEnabled(bool enabled);

  bool isAutoCheckUpdateEnabled();

  void setAutoCheckUpdateEnabled(bool enabled);

  bool isAutoOpenWebPageEnabled();

  void setAutoOpenWebPageEnabled(bool enabled);
}

@HostApi()
abstract class Android {
  void addShortcut();

  void startService();

  void setAdminPwd(String pwd);

  int getAListHttpPort();

  bool isRunning();

  int getDeviceSdkInt();

  String getDeviceCPUABI();

  String getAListVersion();

  String getVersionName();

  int getVersionCode();

  void toast(String msg);

  void longToast(String msg);
}

@FlutterApi()
abstract class Event {
  void onServiceStatusChanged(bool isRunning);

  void onServerLog(int level,
      String time,
      String log,);
}
