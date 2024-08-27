import 'package:pigeon/pigeon.dart';


@ConfigurePigeon(PigeonOptions(
  dartOut: 'lib/generated_api.dart',
  dartOptions: DartOptions(),
  javaOut: 'android/app/src/main/java/com/github/jing332/pigeon/GeneratedApi.java',
  javaOptions: JavaOptions(package: 'com.github.jing332.pigeon'),
  // kotlinOut: 'android/app/src/main/kotlin/com/app/studyplugin2/Messages.g.kt',
  // kotlinOptions: KotlinOptions(),
  swiftOut: 'ios/Runner/GeneratedApi.swift',
  swiftOptions: SwiftOptions(),
  // objcHeaderOut: 'macos/Runner/messages.g.h',
  // objcSourceOut: 'macos/Runner/messages.g.m',
  // Set this to a unique prefix for your plugin or application, per Objective-C naming conventions.
  objcOptions: ObjcOptions(prefix: 'PGN'),
  // copyrightHeader: 'pigeons/copyright.txt',
  // dartPackageName: 'pigeon_example_package',
))

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

  String getDataDir();

  void setDataDir(String dir);

  bool isSilentJumpAppEnabled();

  void setSilentJumpAppEnabled(bool enabled);
}

@HostApi()
abstract class NativeCommon {
  bool startActivityFromUri(String intentUri);

  int getDeviceSdkInt();

  String getDeviceCPUABI();

  String getVersionName();

  int getVersionCode();

  void toast(String msg);

  void longToast(String msg);
}

@HostApi()
abstract class Android {
  void addShortcut();

  void startService();

  void setAdminPwd(String pwd);

  int getAListHttpPort();

  bool isRunning();

  String getAListVersion();
}

@FlutterApi()
abstract class Event {
  void onServiceStatusChanged(bool isRunning);

  void onServerLog(
    int level,
    String time,
    String log,
  );
}
