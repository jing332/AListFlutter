import 'package:alist_flutter/generated_api.dart';
import 'package:alist_flutter/pages/settings/preference_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SettingsController());
    return Scaffold(
        body: Obx(
      () => ListView(
        children: [
          // SizedBox(height: MediaQuery.of(context).padding.top),

          const DividerPreference(title: '通用'),

          SwitchPreference(
            title: '自动检查更新',
            subtitle: '打开主界面时自动从Github检查更新。',
            icon: const Icon(Icons.system_update),
            value: controller.autoUpdate,
            onChanged: (value) {
              controller.autoUpdate = value;
            },
          ),
          SwitchPreference(
            title: '唤醒锁',
            subtitle: '开启防止锁屏后CPU休眠，保持进程在后台运行。（部分系统可能导致杀后台）',
            icon: const Icon(Icons.screen_lock_portrait),
            value: controller.wakeLock,
            onChanged: (value) {
              controller.wakeLock = value;
            },
          ),
          SwitchPreference(
            title: '开机自启动服务',
            subtitle: '在开机后自动启动AList服务。（请确保授予自启动权限）',
            icon: const Icon(Icons.power_settings_new),
            value: controller.startAtBoot,
            onChanged: (value) {
              controller.startAtBoot = value;
            },
          ),
        ],
      ),
    ));
  }
}

class SettingsController extends GetxController {
  final _autoUpdate = true.obs;

  set autoUpdate(value) =>
      {_autoUpdate.value = value, AppConfig().setAutoCheckUpdateEnabled(value)};

  get autoUpdate => _autoUpdate.value;

  final _wakeLock = true.obs;

  set wakeLock(value) =>
      {_wakeLock.value = value, AppConfig().setWakeLockEnabled(value)};

  get wakeLock => _wakeLock.value;

  final _autoStart = true.obs;

  set startAtBoot(value) =>
      {_autoStart.value = value, AppConfig().setStartAtBootEnabled(value)};

  get startAtBoot => _autoStart.value;

  @override
  void onInit() {
    final cfg = AppConfig();
    cfg.isAutoCheckUpdateEnabled().then((value) => autoUpdate = value);
    cfg.isWakeLockEnabled().then((value) => wakeLock = value);
    cfg.isStartAtBootEnabled().then((value) => startAtBoot = value);

    super.onInit();
  }
}
