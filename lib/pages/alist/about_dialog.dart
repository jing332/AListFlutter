import 'dart:ffi';

import 'package:alist_flutter/contant/native_bridge.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../generated/l10n.dart';
import '../../generated_api.dart';
import '../../utils/intent_utils.dart';

class AppAboutDialog extends StatefulWidget {
  const AppAboutDialog({super.key});

  @override
  State<AppAboutDialog> createState() {
    return _AppAboutDialogState();
  }
}

class _AppAboutDialogState extends State<AppAboutDialog> {
  String _alistVersion = "";
  String _version = "";
  int _versionCode = 0;

  Future<Void?> updateVer() async {
    _alistVersion = await Android().getAListVersion();
    _version = await NativeBridge.common.getVersionName();
    _versionCode = await NativeBridge.common.getVersionCode();
    return null;
  }

  @override
  void initState() {
    updateVer().then((value) => setState(() {}));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final alistUrl =
        "https://github.com/alist-org/alist/releases/tag/$_alistVersion";
    final appUrl =
        "https://github.com/jing332/AListFlutter/releases/tag/$_version";
    return AboutDialog(
      applicationName: S.of(context).appName,
      applicationVersion: '$_version ($_versionCode)',
      applicationIcon: SvgPicture.asset(
        "assets/alist.svg",
        width: 48,
        height: 48,
      ),
      children: [
        TextButton(
          onPressed: () {
            IntentUtils.getUrlIntent(alistUrl).launchChooser("AList");
          },
          onLongPress: () {
            Clipboard.setData(ClipboardData(text: alistUrl));
            Get.showSnackbar(GetSnackBar(
                message: S.of(context).copiedToClipboard,
                duration: const Duration(seconds: 1)));
          },
          child: const Text("AList"),
        ),
        TextButton(
            onPressed: () {
              IntentUtils.getUrlIntent(appUrl).launchChooser("AListFlutter");
            },
            onLongPress: () {
              Clipboard.setData(ClipboardData(text: appUrl));
              Get.showSnackbar(GetSnackBar(
                  message: S.of(context).copiedToClipboard,
                  duration: const Duration(seconds: 1)));
            },
            child: const Text("AListFlutter")),
      ],
    );
  }
}
