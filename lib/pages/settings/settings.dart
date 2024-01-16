import 'package:alist_flutter/generated_api.dart';
import 'package:alist_flutter/pages/settings/preference_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../generated/l10n.dart';

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

          DividerPreference(title: S.of(context).general),

          SwitchPreference(
            title: S.of(context).autoCheckForUpdates,
            subtitle: S.of(context).autoCheckForUpdatesDesc,
            icon: const Icon(Icons.system_update),
            value: controller.autoUpdate,
            onChanged: (value) {
              controller.autoUpdate = value;
            },
          ),
          SwitchPreference(
            title: S.of(context).wakeLock,
            subtitle: S.of(context).wakeLockDesc,
            icon: const Icon(Icons.screen_lock_portrait),
            value: controller.wakeLock,
            onChanged: (value) {
              controller.wakeLock = value;
            },
          ),
          SwitchPreference(
            title: S.of(context).bootAutoStartService,
            subtitle: S.of(context).bootAutoStartServiceDesc,
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
