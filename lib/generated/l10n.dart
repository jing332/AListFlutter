// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `AList`
  String get appName {
    return Intl.message(
      'AList',
      name: 'appName',
      desc: '',
      args: [],
    );
  }

  /// `桌面快捷方式`
  String get desktopShortcut {
    return Intl.message(
      '桌面快捷方式',
      name: 'desktopShortcut',
      desc: '',
      args: [],
    );
  }

  /// `设置admin密码`
  String get setAdminPassword {
    return Intl.message(
      '设置admin密码',
      name: 'setAdminPassword',
      desc: '',
      args: [],
    );
  }

  /// `更多选项`
  String get moreOptions {
    return Intl.message(
      '更多选项',
      name: 'moreOptions',
      desc: '',
      args: [],
    );
  }

  /// `检查更新`
  String get checkForUpdates {
    return Intl.message(
      '检查更新',
      name: 'checkForUpdates',
      desc: '',
      args: [],
    );
  }

  /// `已经是最新版本`
  String get currentIsLatestVersion {
    return Intl.message(
      '已经是最新版本',
      name: 'currentIsLatestVersion',
      desc: '',
      args: [],
    );
  }

  /// `确认`
  String get confirm {
    return Intl.message(
      '确认',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `取消`
  String get cancel {
    return Intl.message(
      '取消',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `发布页面`
  String get releasePage {
    return Intl.message(
      '发布页面',
      name: 'releasePage',
      desc: '',
      args: [],
    );
  }

  /// `下载APK`
  String get downloadApk {
    return Intl.message(
      '下载APK',
      name: 'downloadApk',
      desc: '',
      args: [],
    );
  }

  /// `关于`
  String get about {
    return Intl.message(
      '关于',
      name: 'about',
      desc: '',
      args: [],
    );
  }

  /// `通用`
  String get general {
    return Intl.message(
      '通用',
      name: 'general',
      desc: '',
      args: [],
    );
  }

  /// `自动检查更新`
  String get autoCheckForUpdates {
    return Intl.message(
      '自动检查更新',
      name: 'autoCheckForUpdates',
      desc: '',
      args: [],
    );
  }

  /// `启动时自动检查更新`
  String get autoCheckForUpdatesDesc {
    return Intl.message(
      '启动时自动检查更新',
      name: 'autoCheckForUpdatesDesc',
      desc: '',
      args: [],
    );
  }

  /// `唤醒锁`
  String get wakeLock {
    return Intl.message(
      '唤醒锁',
      name: 'wakeLock',
      desc: '',
      args: [],
    );
  }

  /// `开启防止锁屏后CPU休眠，保持进程在后台运行。（部分系统可能导致杀后台）`
  String get wakeLockDesc {
    return Intl.message(
      '开启防止锁屏后CPU休眠，保持进程在后台运行。（部分系统可能导致杀后台）',
      name: 'wakeLockDesc',
      desc: '',
      args: [],
    );
  }

  /// `开机自启动服务`
  String get bootAutoStartService {
    return Intl.message(
      '开机自启动服务',
      name: 'bootAutoStartService',
      desc: '',
      args: [],
    );
  }

  /// `在开机后自动启动AList服务。（请确保授予自启动权限）`
  String get bootAutoStartServiceDesc {
    return Intl.message(
      '在开机后自动启动AList服务。（请确保授予自启动权限）',
      name: 'bootAutoStartServiceDesc',
      desc: '',
      args: [],
    );
  }

  /// `网页`
  String get webPage {
    return Intl.message(
      '网页',
      name: 'webPage',
      desc: '',
      args: [],
    );
  }

  /// `设置`
  String get settings {
    return Intl.message(
      '设置',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `选择应用打开`
  String get selectAppToOpen {
    return Intl.message(
      '选择应用打开',
      name: 'selectAppToOpen',
      desc: '',
      args: [],
    );
  }

  /// `前往`
  String get goTo {
    return Intl.message(
      '前往',
      name: 'goTo',
      desc: '',
      args: [],
    );
  }

  /// `下载此文件吗？`
  String get downloadThisFile {
    return Intl.message(
      '下载此文件吗？',
      name: 'downloadThisFile',
      desc: '',
      args: [],
    );
  }

  /// `下载`
  String get download {
    return Intl.message(
      '下载',
      name: 'download',
      desc: '',
      args: [],
    );
  }

  /// `已复制到剪贴板`
  String get copiedToClipboard {
    return Intl.message(
      '已复制到剪贴板',
      name: 'copiedToClipboard',
      desc: '',
      args: [],
    );
  }

  /// `重要`
  String get importantSettings {
    return Intl.message(
      '重要',
      name: 'importantSettings',
      desc: '',
      args: [],
    );
  }

  /// `界面`
  String get uiSettings {
    return Intl.message(
      '界面',
      name: 'uiSettings',
      desc: '',
      args: [],
    );
  }

  /// `申请【所有文件访问权限】`
  String get grantManagerStoragePermission {
    return Intl.message(
      '申请【所有文件访问权限】',
      name: 'grantManagerStoragePermission',
      desc: '',
      args: [],
    );
  }

  /// `挂载本地存储时必须授予，否则无权限读写文件`
  String get grantStoragePermissionDesc {
    return Intl.message(
      '挂载本地存储时必须授予，否则无权限读写文件',
      name: 'grantStoragePermissionDesc',
      desc: '',
      args: [],
    );
  }

  /// `申请【读写外置存储权限】`
  String get grantStoragePermission {
    return Intl.message(
      '申请【读写外置存储权限】',
      name: 'grantStoragePermission',
      desc: '',
      args: [],
    );
  }

  /// `申请【通知权限】`
  String get grantNotificationPermission {
    return Intl.message(
      '申请【通知权限】',
      name: 'grantNotificationPermission',
      desc: '',
      args: [],
    );
  }

  /// `用于前台服务保活`
  String get grantNotificationPermissionDesc {
    return Intl.message(
      '用于前台服务保活',
      name: 'grantNotificationPermissionDesc',
      desc: '',
      args: [],
    );
  }

  /// `将网页设置为打开首页`
  String get autoStartWebPage {
    return Intl.message(
      '将网页设置为打开首页',
      name: 'autoStartWebPage',
      desc: '',
      args: [],
    );
  }

  /// `跳转到其他APP ？`
  String get jumpToOtherApp {
    return Intl.message(
      '跳转到其他APP ？',
      name: 'jumpToOtherApp',
      desc: '',
      args: [],
    );
  }

  /// `打开主界面时的首页`
  String get autoStartWebPageDesc {
    return Intl.message(
      '打开主界面时的首页',
      name: 'autoStartWebPageDesc',
      desc: '',
      args: [],
    );
  }

  /// `data 文件夹路径`
  String get dataDirectory {
    return Intl.message(
      'data 文件夹路径',
      name: 'dataDirectory',
      desc: '',
      args: [],
    );
  }

  /// `是否设为初始目录？`
  String get setDefaultDirectory {
    return Intl.message(
      '是否设为初始目录？',
      name: 'setDefaultDirectory',
      desc: '',
      args: [],
    );
  }

  /// `静默跳转APP`
  String get silentJumpApp {
    return Intl.message(
      '静默跳转APP',
      name: 'silentJumpApp',
      desc: '',
      args: [],
    );
  }

  /// `跳转APP时，不弹出提示框`
  String get silentJumpAppDesc {
    return Intl.message(
      '跳转APP时，不弹出提示框',
      name: 'silentJumpAppDesc',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'zh'),
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
