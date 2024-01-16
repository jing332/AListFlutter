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

  /// `Desktop shortcut`
  String get desktopShortcut {
    return Intl.message(
      'Desktop shortcut',
      name: 'desktopShortcut',
      desc: '',
      args: [],
    );
  }

  /// `Set admin password`
  String get setAdminPassword {
    return Intl.message(
      'Set admin password',
      name: 'setAdminPassword',
      desc: '',
      args: [],
    );
  }

  /// `More options`
  String get moreOptions {
    return Intl.message(
      'More options',
      name: 'moreOptions',
      desc: '',
      args: [],
    );
  }

  /// `Check for updates`
  String get checkForUpdates {
    return Intl.message(
      'Check for updates',
      name: 'checkForUpdates',
      desc: '',
      args: [],
    );
  }

  /// `Current is latest version`
  String get currentIsLatestVersion {
    return Intl.message(
      'Current is latest version',
      name: 'currentIsLatestVersion',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Release Page`
  String get releasePage {
    return Intl.message(
      'Release Page',
      name: 'releasePage',
      desc: '',
      args: [],
    );
  }

  /// `Download APK`
  String get downloadApk {
    return Intl.message(
      'Download APK',
      name: 'downloadApk',
      desc: '',
      args: [],
    );
  }

  /// `About`
  String get about {
    return Intl.message(
      'About',
      name: 'about',
      desc: '',
      args: [],
    );
  }

  /// `General`
  String get general {
    return Intl.message(
      'General',
      name: 'general',
      desc: '',
      args: [],
    );
  }

  /// `Auto check for updates`
  String get autoCheckForUpdates {
    return Intl.message(
      'Auto check for updates',
      name: 'autoCheckForUpdates',
      desc: '',
      args: [],
    );
  }

  /// `Check for updates when app starts`
  String get autoCheckForUpdatesDesc {
    return Intl.message(
      'Check for updates when app starts',
      name: 'autoCheckForUpdatesDesc',
      desc: '',
      args: [],
    );
  }

  /// `Wake lock`
  String get wakeLock {
    return Intl.message(
      'Wake lock',
      name: 'wakeLock',
      desc: '',
      args: [],
    );
  }

  /// `Prevent CPU from sleeping when screen is off. (May cause app killed in background on some devices)`
  String get wakeLockDesc {
    return Intl.message(
      'Prevent CPU from sleeping when screen is off. (May cause app killed in background on some devices)',
      name: 'wakeLockDesc',
      desc: '',
      args: [],
    );
  }

  /// `Boot auto-start service`
  String get bootAutoStartService {
    return Intl.message(
      'Boot auto-start service',
      name: 'bootAutoStartService',
      desc: '',
      args: [],
    );
  }

  /// `Automatically start AList service after boot. (Please make sure to grant auto-start permission)`
  String get bootAutoStartServiceDesc {
    return Intl.message(
      'Automatically start AList service after boot. (Please make sure to grant auto-start permission)',
      name: 'bootAutoStartServiceDesc',
      desc: '',
      args: [],
    );
  }

  /// `Web Page`
  String get webPage {
    return Intl.message(
      'Web Page',
      name: 'webPage',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Jump to other app？`
  String get jumpToOtherApp {
    return Intl.message(
      'Jump to other app？',
      name: 'jumpToOtherApp',
      desc: '',
      args: [],
    );
  }

  /// `Select app to open`
  String get selectAppToOpen {
    return Intl.message(
      'Select app to open',
      name: 'selectAppToOpen',
      desc: '',
      args: [],
    );
  }

  /// `GO`
  String get goTo {
    return Intl.message(
      'GO',
      name: 'goTo',
      desc: '',
      args: [],
    );
  }

  /// `Download this file？`
  String get downloadThisFile {
    return Intl.message(
      'Download this file？',
      name: 'downloadThisFile',
      desc: '',
      args: [],
    );
  }

  /// `download`
  String get download {
    return Intl.message(
      'download',
      name: 'download',
      desc: '',
      args: [],
    );
  }

  /// `Copied to clipboard`
  String get copiedToClipboard {
    return Intl.message(
      'Copied to clipboard',
      name: 'copiedToClipboard',
      desc: '',
      args: [],
    );
  }

  /// `Important settings`
  String get importantSettings {
    return Intl.message(
      'Important settings',
      name: 'importantSettings',
      desc: '',
      args: [],
    );
  }

  /// `Grant 【Manage external storage】 permission`
  String get grantManagerStoragePermission {
    return Intl.message(
      'Grant 【Manage external storage】 permission',
      name: 'grantManagerStoragePermission',
      desc: '',
      args: [],
    );
  }

  /// `Mounting local storage is a must, otherwise no permission to read and write files`
  String get grantStoragePermissionDesc {
    return Intl.message(
      'Mounting local storage is a must, otherwise no permission to read and write files',
      name: 'grantStoragePermissionDesc',
      desc: '',
      args: [],
    );
  }

  /// `Grant 【external storage】 permission`
  String get grantStoragePermission {
    return Intl.message(
      'Grant 【external storage】 permission',
      name: 'grantStoragePermission',
      desc: '',
      args: [],
    );
  }

  /// `Grant 【Notification】 permission`
  String get grantNotificationPermission {
    return Intl.message(
      'Grant 【Notification】 permission',
      name: 'grantNotificationPermission',
      desc: '',
      args: [],
    );
  }

  /// `Used for foreground service keep alive`
  String get grantNotificationPermissionDesc {
    return Intl.message(
      'Used for foreground service keep alive',
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

  /// `打开主界面时的首页`
  String get autoStartWebPageDesc {
    return Intl.message(
      '打开主界面时的首页',
      name: 'autoStartWebPageDesc',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'zh'),
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
