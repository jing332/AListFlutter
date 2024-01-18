import 'dart:developer';

import 'package:alist_flutter/generated_api.dart';
import 'package:alist_flutter/utils/intent_utils.dart';
import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

import '../../generated/l10n.dart';

GlobalKey<WebScreenState> webGlobalKey = GlobalKey();

class WebScreen extends StatefulWidget {
  const WebScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return WebScreenState();
  }
}

class WebScreenState extends State<WebScreen> {
  InAppWebViewController? _webViewController;
  double _progress = 0;
  String _url = "http://localhost:5244";
  bool _canGoBack = false;

  onClickNavigationBar() {
    log("onClickNavigationBar");
    _webViewController?.reload();
  }

  @override
  void initState() {
    Android()
        .getAListHttpPort()
        .then((port) => {_url = "http://localhost:$port"});
    super.initState();
  }

  @override
  void dispose() {
    _webViewController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: !_canGoBack,
        onPopInvoked: (didPop) async {
          log("onPopInvoked $didPop");
          if (didPop) return;
          _webViewController?.goBack();
        },
        child: Scaffold(
          body: Column(children: <Widget>[
            SizedBox(height: MediaQuery.of(context).padding.top),
            LinearProgressIndicator(
              value: _progress,
              backgroundColor: Colors.grey[200],
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
            Expanded(
              child: InAppWebView(
                initialUrlRequest: URLRequest(url: WebUri(_url)),
                onWebViewCreated: (InAppWebViewController controller) {
                  _webViewController = controller;
                },
                onLoadStart: (InAppWebViewController controller, Uri? url) {
                  setState(() {
                    _progress = 0;
                  });
                },
                shouldOverrideUrlLoading: (controller, navigationAction) async {
                  if (navigationAction.request.url?.scheme.startsWith("http") ==
                      true) {
                    return NavigationActionPolicy.ALLOW;
                  }
                  Get.showSnackbar(GetSnackBar(
                      message: S.of(context).jumpToOtherApp,
                      duration: const Duration(seconds: 3),
                      mainButton: TextButton(
                        onPressed: () {
                          final intent = AndroidIntent(
                              action: "action_view",
                              data: navigationAction.request.url!.toString());

                          intent.launchChooser(S.of(context).selectAppToOpen);
                        },
                        child: Text(S.of(context).goTo),
                      )));

                  return NavigationActionPolicy.CANCEL;
                },
                onReceivedError: (controller, request, error) async {
                  final isRunning = await Android().isRunning();
                  if (!isRunning) {
                    Android().startService();
                  } else {
                    await Future.delayed(const Duration(milliseconds: 100));
                  }
                    controller.reload();
                },
                onDownloadStartRequest: (controller, url) async {
                  Get.showSnackbar(GetSnackBar(
                    title: S.of(context).downloadThisFile,
                    message: url.suggestedFilename ??
                        url.contentDisposition ??
                        url.toString(),
                    duration: const Duration(seconds: 3),
                    mainButton: Column(children: [
                      TextButton(
                        onPressed: () {
                          IntentUtils.getUrlIntent(url.url.toString())
                              .launchChooser(S.of(context).selectAppToOpen);
                        },
                        child: Text(S.of(context).selectAppToOpen),
                      ),
                      TextButton(
                        onPressed: () {
                          IntentUtils.getUrlIntent(url.url.toString()).launch();
                        },
                        child: Text(S.of(context).download),
                      ),
                    ]),
                    onTap: (_) {
                      Clipboard.setData(
                          ClipboardData(text: url.url.toString()));
                      Get.closeCurrentSnackbar();
                      Get.showSnackbar(GetSnackBar(
                        message: S.of(context).copiedToClipboard,
                        duration: const Duration(seconds: 1),
                      ));
                    },
                  ));
                },
                onLoadStop:
                    (InAppWebViewController controller, Uri? url) async {
                  setState(() {
                    _progress = 0;
                  });
                },
                onProgressChanged:
                    (InAppWebViewController controller, int progress) {
                  setState(() {
                    _progress = progress / 100;
                    if (_progress == 1) _progress = 0;
                  });
                  controller.canGoBack().then((value) => setState(() {
                        _canGoBack = value;
                      }));
                },
              ),
            ),
          ]),
        ));
  }
}
