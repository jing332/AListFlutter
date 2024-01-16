import 'dart:developer';

import 'package:alist_flutter/generated_api.dart';
import 'package:alist_flutter/utils/intent_utils.dart';
import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

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
                  setState(() async {
                    _progress = 0;
                  });
                },
                shouldOverrideUrlLoading: (controller, navigationAction) async {
                  if (navigationAction.request.url?.scheme.startsWith("http") ==
                      true) {
                    return NavigationActionPolicy.ALLOW;
                  }
                  Get.showSnackbar(GetSnackBar(
                      message: "是否跳转到其他应用？",
                      duration: const Duration(seconds: 3),
                      mainButton: TextButton(
                        onPressed: () {
                          final intent = AndroidIntent(
                              action: "action_view",
                              data: navigationAction.request.url!.toString());

                          intent.launchChooser("选择应用");
                        },
                        child: const Text('前往'),
                      )));

                  return NavigationActionPolicy.CANCEL;
                },
                onDownloadStartRequest: (controller, url) async {
                  Get.showSnackbar(GetSnackBar(
                    title: "是否下载文件？",
                    message: url.suggestedFilename ??
                        url.contentDisposition ??
                        url.toString(),
                    duration: const Duration(seconds: 3),
                    mainButton: Column(children: [
                      TextButton(
                        onPressed: () {
                          IntentUtils.getUrlIntent(url.url.toString())
                              .launchChooser("选择应用");
                        },
                        child: const Text('选择应用下载'),
                      ),
                      TextButton(
                        onPressed: () {
                          IntentUtils.getUrlIntent(url.url.toString()).launch();
                        },
                        child: const Text('下载'),
                      ),
                    ]),
                    onTap: (_) {
                      Clipboard.setData(
                          ClipboardData(text: url.url.toString()));
                      Get.closeCurrentSnackbar();
                      Get.showSnackbar(const GetSnackBar(
                        message: "下载链接已复制到剪贴板",
                        duration: Duration(seconds: 1),
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
