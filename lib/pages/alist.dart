import 'package:alist_flutter/widgets/switch_floating_action_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AListScreen extends StatelessWidget {
  const AListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ui = Get.put(AListController());
    return Obx(() => Scaffold(
          floatingActionButton: SwitchFloatingButton(
            isSwitch: ui.isSwitch.value,
            onSwitchChange: (s ) {
              ui.isSwitch.value = s;
            },
          ),
        ));
  }
}

class AListController extends GetxController {
  var isSwitch = false.obs;
}
