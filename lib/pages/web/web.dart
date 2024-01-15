import 'package:alist_flutter/generated_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

class WebScreen extends StatefulWidget {
  const WebScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _WebScreenState();
  }
}

class _WebScreenState extends State<WebScreen> {
  InAppWebViewController? _webViewController;
  double _progress = 0;
  String _url = "http://localhost:5244";

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
        onPopInvoked: (b) {
          _webViewController?.canGoBack().then((value) => {
                if (value) {_webViewController?.goBack()} else {Get.back()}
              });
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
                      message:
                          "shouldOverrideUrlLoading ${navigationAction.request.url}",
                      duration: const Duration(seconds: 3),
                      mainButton: TextButton(
                        onPressed: () {},
                        child: const Text('前往'),
                      )));

                  return NavigationActionPolicy.CANCEL;
                },
                onDownloadStartRequest: (controller, url) async {
                  Get.showSnackbar(GetSnackBar(
                      message: "是否下载文件？ ${url.contentDisposition}",
                      duration: const Duration(seconds: 3),
                      mainButton: TextButton(
                        onPressed: () {},
                        child: const Text('下载'),
                      )));
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
                },
              ),
            ),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  child: const Icon(Icons.arrow_back),
                  onPressed: () {
                    if (_webViewController != null) {
                      _webViewController!.goBack();
                    }
                  },
                ),
                ElevatedButton(
                  child: const Icon(Icons.arrow_forward),
                  onPressed: () {
                    if (_webViewController != null) {
                      _webViewController!.goForward();
                    }
                  },
                ),
                ElevatedButton(
                  child: const Icon(Icons.refresh),
                  onPressed: () {
                    if (_webViewController != null) {
                      _webViewController!.reload();
                    }
                  },
                ),
              ],
            ),
          ]),
        ));
  }
}
