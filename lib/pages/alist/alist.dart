import 'dart:developer';
import 'dart:io';

import 'package:alist_flutter/generated_api.dart';
import 'package:alist_flutter/pages/alist/about_dialog.dart';
import 'package:alist_flutter/pages/alist/pwd_edit_dialog.dart';
import 'package:alist_flutter/pages/app_update_dialog.dart';
import 'package:alist_flutter/widgets/switch_floating_action_button.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../generated/l10n.dart';
import '../../utils/intent_utils.dart';
import 'log_list_view.dart';

class AListScreen extends StatelessWidget {
  const AListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ui = Get.put(AListController());

    return Scaffold(
        appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            title: Obx(() => Text("AList - ${ui.alistVersion.value}")),
            actions: [
              IconButton(
                tooltip: S.of(context).desktopShortcut,
                onPressed: () async  {
                  Android().addShortcut();
                },
                icon: const Icon(Icons.add_home),
              ),
              IconButton(
                tooltip: S.current.setAdminPassword,
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => PwdEditDialog(onConfirm: (pwd) {
                            Get.showSnackbar(GetSnackBar(
                                title: S.current.setAdminPassword,
                                message: pwd,
                                duration: const Duration(seconds: 1)));
                            Android().setAdminPwd(pwd);
                          }));
                },
                icon: const Icon(Icons.password),
              ),
              PopupMenuButton(
                tooltip: S.of(context).moreOptions,
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      value: 1,
                      onTap: () async {
                        AppUpdateDialog.checkUpdateAndShowDialog(context, (b) {
                          if (!b) {
                            Get.showSnackbar(GetSnackBar(
                                message: S.of(context).currentIsLatestVersion,
                                duration: const Duration(seconds: 2)));
                          }
                        });
                      },
                      child: Text(S.of(context).checkForUpdates),
                    ),
                    PopupMenuItem(
                      value: 2,
                      onTap: () {
                        showDialog(context: context, builder: ((context){
                          return const AppAboutDialog();
                        }));
                      },
                      child: Text(S.of(context).about),
                    ),
                  ];
                },
                icon: const Icon(Icons.more_vert),
              )
            ]),
        floatingActionButton: Obx(
          () => SwitchFloatingButton(
              isSwitch: ui.isSwitch.value,
              onSwitchChange: (s) {
                ui.clearLog();
                ui.isSwitch.value = s;
                Android().startService();
              }),
        ),
        body: Obx(() => LogListView(logs: ui.logs.value)));
  }
}

class MyEventReceiver extends Event {
  Function(Log log) logCb;
  Function(bool isRunning) statusCb;

  MyEventReceiver(this.statusCb, this.logCb);

  @override
  void onServiceStatusChanged(bool isRunning) {
    statusCb(isRunning);
  }

  @override
  void onServerLog(int level, String time, String log) {
    logCb(Log(level, time, log));
  }
}

class AListController extends GetxController {
  final ScrollController _scrollController = ScrollController();
  var isSwitch = false.obs;
  var alistVersion = "".obs;

  var logs = <Log>[].obs;

  void clearLog() {
    logs.clear();
  }

  void addLog(Log log) {
    logs.add(log);
    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
  }

  @override
  void onInit() {
    Event.setup(MyEventReceiver(
        (isRunning) => isSwitch.value = isRunning, (log) => addLog(log)));
    Android().getAListVersion().then((value) => alistVersion.value = value);
    Android().isRunning().then((value) => isSwitch.value = value);

    super.onInit();
  }
}
