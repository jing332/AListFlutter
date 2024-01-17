import 'package:flutter/material.dart';

import '../generated/l10n.dart';
import '../utils/update_checker.dart';
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

  static checkUpdateAndShowDialog(
      BuildContext context, ValueChanged<bool>? checkFinished) async {
    final checker = UpdateChecker(owner: "jing332", repo: "AListFlutter");
    await checker.downloadData();
    checker.hasNewVersion().then((value) {
      checkFinished?.call(value);
      if (value) {
        showDialog(
            context: context,
            barrierDismissible: false,
            barrierColor: Colors.black.withOpacity(0.5),
            builder: (context) {
              return AppUpdateDialog(
                content: checker.getUpdateContent(),
                apkUrl: checker.getApkDownloadUrl(),
                htmlUrl: checker.getHtmlUrl(),
                version: checker.getTag(),
              );
            });
      }
    });
  }

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
          child: Text(S.of(context).cancel),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        TextButton(
          child: Text(S.of(context).releasePage),
          onPressed: () {
            Navigator.pop(context);
            IntentUtils.getUrlIntent(htmlUrl)
                .launchChooser(S.of(context).releasePage);
          },
        ),
        TextButton(
          child: Text(S.of(context).downloadApk),
          onPressed: () {
            Navigator.pop(context);
            IntentUtils.getUrlIntent(apkUrl)
                .launchChooser(S.of(context).downloadApk);
          },
        ),
      ],
    );
  }
}
