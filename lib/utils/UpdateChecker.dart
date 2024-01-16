import 'dart:js_interop_unsafe';

import 'package:get/get_connect/http/src/response/response.dart';

class UpdateChecker {
  static Future<bool> checkForUpdate() async {
    final version = Android().getVersion
    final PackageInfo info = await PackageInfo.fromPlatform();
    final String currentVersion = info.version;
    final String url =
        'https://raw.githubusercontent.com/iamSahdeep/liquid_swipe_flutter/master/pubspec.yaml';
    try {
      final http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        final String body = response.body;
        final List<String> list = body.split('\n');
        final String latestVersion = list
            .firstWhere((String element) => element.contains('version'))
            .split(': ')[1];
        if (currentVersion.compareTo(latestVersion) < 0) {
          return true;
        }
      }
    } catch (e) {
      print(e);
    }
    return false;
  }
}