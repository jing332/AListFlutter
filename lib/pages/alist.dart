import 'dart:developer';

import 'package:alist_flutter/generated_api.dart';
import 'package:alist_flutter/pages/pwd_edit_dialog.dart';
import 'package:alist_flutter/widgets/switch_floating_action_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'alist/log_list_view.dart';

class AListScreen extends StatelessWidget {
  const AListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ui = Get.put(AListController());

    return Scaffold(
        appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Obx(() => Text("AList - ${ui.alistVersion.value}")),
            actions: [
              IconButton(
                onPressed: () {
                  Android().addShortcut();
                },
                icon: const Icon(Icons.add_home),
              ),
              IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => PwdEditDialog(onConfirm: (pwd) {
                            log("pwd: $pwd");
                            Android().setAdminPwd(pwd);
                          }));
                },
                icon: const Icon(Icons.password),
              ),
              PopupMenuButton(
                itemBuilder: (context) {
                  return [
                    const PopupMenuItem(
                      value: 1,
                      child: Text("检查更新"),
                    ),
                    const PopupMenuItem(
                      value: 2,
                      child: Text("关于"),
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

    super.onInit();
  }
}
