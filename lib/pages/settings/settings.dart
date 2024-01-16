import 'dart:developer';

import 'package:alist_flutter/generated_api.dart';
import 'package:alist_flutter/pages/settings/preference_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../generated/l10n.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() {
    return _SettingsScreenState();
  }
}

class _SettingsScreenState extends State<SettingsScreen> {
  late AppLifecycleListener _lifecycleListener;

  @override
  void initState() {
    _lifecycleListener = AppLifecycleListener(
      onResume: () async {
        log("onResume");
        final controller = Get.put(SettingsController());
        controller.updateData();
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    _lifecycleListener.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SettingsController());
    return Scaffold(
        body: Obx(
      () => ListView(
        children: [
          // SizedBox(height: MediaQuery.of(context).padding.top),
          Visibility(
            visible: !controller._managerStorageGranted.value ||
                !controller._notificationGranted.value ||
                !controller._storageGranted.value,
            child: DividerPreference(title: S.of(context).importantSettings),
          ),
          Visibility(
            visible: !controller._managerStorageGranted.value,
            child: BasicPreference(
              title: S.of(context).grantManagerStoragePermission,
              subtitle: S.of(context).grantStoragePermissionDesc,
              onTap: () {
                Permission.manageExternalStorage.request();
              },
            ),
          ),
          Visibility(
              visible: !controller._storageGranted.value,
              child: BasicPreference(
                title: S.of(context).grantStoragePermission,
                subtitle: S.of(context).grantStoragePermissionDesc,
                onTap: () {
                  Permission.storage.request();
                },
              )),

          Visibility(
              visible: !controller._notificationGranted.value,
              child: BasicPreference(
                title: S.of(context).grantNotificationPermission,
                subtitle: S.of(context).grantNotificationPermissionDesc,
                onTap: () {},
              )),

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
  final _managerStorageGranted = true.obs;
  final _notificationGranted = true.obs;
  final _storageGranted = true.obs;

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
  void onInit() async {
    log("onInit");
    updateData();

    super.onInit();
  }

  void updateData() async {
    final cfg = AppConfig();
    cfg.isAutoCheckUpdateEnabled().then((value) => autoUpdate = value);
    cfg.isWakeLockEnabled().then((value) => wakeLock = value);
    cfg.isStartAtBootEnabled().then((value) => startAtBoot = value);

    final sdk = await Android().getDeviceSdkInt();
    // A11
    if (sdk >= 30) {
      _managerStorageGranted.value =
          await Permission.manageExternalStorage.isGranted;

      Permission.manageExternalStorage.status.then((value) => log(value.toString()));
    } else {
      _managerStorageGranted.value = true;
      _storageGranted.value = await Permission.storage.isGranted;
    }

    // A12
    if (sdk >= 32) {
      _notificationGranted.value = await Permission.notification.isGranted;
    } else {
      _notificationGranted.value = true;
    }
  }
}
