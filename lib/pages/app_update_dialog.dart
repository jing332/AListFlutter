import 'package:flutter/material.dart';

import '../utils/intent_utils.dart';

class AppUpdateDialog extends StatelessWidget {
  final String content;
  final String apkUrl;
  final String htmlUrl;
  final String version;

  const AppUpdateDialog(
      {super.key,
      required this.content,
      required this.apkUrl,
      required this.version,
      required this.htmlUrl});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("发现新版本"),
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        Text("v$version"),
        Text(content),
      ]),
      actions: <Widget>[
        TextButton(
          child: const Text('取消'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        TextButton(
          child: const Text('发布页面'),
          onPressed: () {
            Navigator.pop(context);
            IntentUtils.getUrlIntent(htmlUrl).launchChooser("发布页面");
          },
        ),
        TextButton(
          child: const Text('下载APK'),
          onPressed: () {
            Navigator.pop(context);
            IntentUtils.getUrlIntent(apkUrl).launchChooser("下载APK");

          },
        ),
      ],
    );
  }
}
