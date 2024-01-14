import 'package:alist_flutter/generated_api.dart';
import 'package:alist_flutter/widgets/switch_floating_action_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AListScreen extends StatelessWidget {
  const AListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ui = Get.put(AListController());
    return Obx(() =>
        Scaffold(
          appBar: AppBar(
            backgroundColor: Theme
                .of(context)
                .colorScheme
                .inversePrimary,
            title: Text("AList - ${ui.alistVersion.value}"),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.add_home),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.password),
              ),
            ],
          ),
          floatingActionButton: SwitchFloatingButton(
            isSwitch: ui.isSwitch.value,
            onSwitchChange: (s) {
              ui.isSwitch.value = s;
              Android().startService();
            },
          ),
        ));
  }
}

class MyEventReceiver extends Event {
  RxBool isRunning;

  MyEventReceiver(this.isRunning);

  @override
  void onServiceStatusChanged(bool b) {
    isRunning.value = b;
  }
}

class AListController extends GetxController {
  var isSwitch = false.obs;
  var alistVersion = "".obs;

  @override
  void onInit() {
    Event.setup(MyEventReceiver(isSwitch));
    Android().getAListVersion().then((value) => alistVersion.value = value);

    super.onInit();
  }
}
