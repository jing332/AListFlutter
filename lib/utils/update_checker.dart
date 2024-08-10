import 'dart:convert';
import 'dart:core';
import 'dart:developer';
import 'dart:io';

import 'package:alist_flutter/contant/native_bridge.dart';
import 'package:alist_flutter/generated_api.dart';

class UpdateChecker {
  String owner;
  String repo;

  Map<String, dynamic>? _data;

  UpdateChecker({required this.owner, required this.repo});

  String _versionName = "";
  String _systemABI = "";

  downloadData() async {
    _data = await _getLatestRelease(owner, repo);
    _versionName = await NativeBridge.common.getVersionName();
    _systemABI = await NativeBridge.common.getDeviceCPUABI();
  }

  Map<String, dynamic> get data {
    if (_data == null) {
      throw Exception('Data not downloaded');
    }
    return _data!;
  }

  static Future<Map<String, dynamic>> _getLatestRelease(
      String owner, String repo) async {
    HttpClient client = HttpClient();
    final req = await client.getUrl(
        Uri.parse('https://api.github.com/repos/$owner/$repo/releases/latest'));
    final response = await req.close();

    if (response.statusCode == HttpStatus.ok) {
      final body = await response.transform(utf8.decoder).join();
      return json.decode(body);
    } else {
      throw Exception(
          'Failed to get latest release, status code: ${response.statusCode}');
    }
  }

  String getTag() {
    return data['tag_name'];
  }

  Future<bool> hasNewVersion() async {
    final latestVersion = getTag();
    final currentVersion = _versionName;

    log('latestVersion: $latestVersion, currentVersion: $currentVersion');
    // return true;
    return _extractNumbers(latestVersion) > _extractNumbers(currentVersion);
  }

  String getApkDownloadUrl() {
    final assets = data['assets'];
    for (var asset in assets) {
      if (asset['name'].contains(_systemABI)) {
        return asset['browser_download_url'];
      }
    }

    throw Exception('Failed to get apk download url');
  }

  String getUpdateContent() {
    return data['body'];
  }

  String getHtmlUrl() {
    return data['html_url'];
  }

  // 1.24.011609 to Int
  static int _extractNumbers(String input) {
    final s = input.replaceAll(RegExp(r'[^0-9]'), '');
    return int.parse(s);
  }
}
