// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "about": MessageLookupByLibrary.simpleMessage("About"),
        "appName": MessageLookupByLibrary.simpleMessage("AList"),
        "autoCheckForUpdates":
            MessageLookupByLibrary.simpleMessage("Auto check for updates"),
        "autoCheckForUpdatesDesc": MessageLookupByLibrary.simpleMessage(
            "Check for updates when app starts"),
        "autoStartWebPage": MessageLookupByLibrary.simpleMessage("将网页设置为打开首页"),
        "autoStartWebPageDesc":
            MessageLookupByLibrary.simpleMessage("打开主界面时的首页"),
        "bootAutoStartService":
            MessageLookupByLibrary.simpleMessage("Boot auto-start service"),
        "bootAutoStartServiceDesc": MessageLookupByLibrary.simpleMessage(
            "Automatically start AList service after boot. (Please make sure to grant auto-start permission)"),
        "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "checkForUpdates":
            MessageLookupByLibrary.simpleMessage("Check for updates"),
        "confirm": MessageLookupByLibrary.simpleMessage("OK"),
        "copiedToClipboard":
            MessageLookupByLibrary.simpleMessage("Copied to clipboard"),
        "currentIsLatestVersion":
            MessageLookupByLibrary.simpleMessage("Current is latest version"),
        "dataDirectory": MessageLookupByLibrary.simpleMessage("data Directory"),
        "desktopShortcut":
            MessageLookupByLibrary.simpleMessage("Desktop shortcut"),
        "download": MessageLookupByLibrary.simpleMessage("download"),
        "downloadApk": MessageLookupByLibrary.simpleMessage("Download APK"),
        "downloadThisFile":
            MessageLookupByLibrary.simpleMessage("Download this file？"),
        "general": MessageLookupByLibrary.simpleMessage("General"),
        "goTo": MessageLookupByLibrary.simpleMessage("GO"),
        "grantManagerStoragePermission": MessageLookupByLibrary.simpleMessage(
            "Grant 【Manage external storage】 permission"),
        "grantNotificationPermission": MessageLookupByLibrary.simpleMessage(
            "Grant 【Notification】 permission"),
        "grantNotificationPermissionDesc": MessageLookupByLibrary.simpleMessage(
            "Used for foreground service keep alive"),
        "grantStoragePermission": MessageLookupByLibrary.simpleMessage(
            "Grant 【external storage】 permission"),
        "grantStoragePermissionDesc": MessageLookupByLibrary.simpleMessage(
            "Mounting local storage is a must, otherwise no permission to read and write files"),
        "importantSettings":
            MessageLookupByLibrary.simpleMessage("Important settings"),
        "jumpToOtherApp":
            MessageLookupByLibrary.simpleMessage("Jump to other app？"),
        "moreOptions": MessageLookupByLibrary.simpleMessage("More options"),
        "releasePage": MessageLookupByLibrary.simpleMessage("Release Page"),
        "selectAppToOpen":
            MessageLookupByLibrary.simpleMessage("Select app to open"),
        "setAdminPassword":
            MessageLookupByLibrary.simpleMessage("Set admin password"),
        "setDefaultDirectory":
            MessageLookupByLibrary.simpleMessage("是否设为默认目录？"),
        "settings": MessageLookupByLibrary.simpleMessage("Settings"),
        "silentJumpApp":
            MessageLookupByLibrary.simpleMessage("silent jump app"),
        "silentJumpAppDesc": MessageLookupByLibrary.simpleMessage(
            "Jump to other app without prompt"),
        "uiSettings": MessageLookupByLibrary.simpleMessage("UI"),
        "wakeLock": MessageLookupByLibrary.simpleMessage("Wake lock"),
        "wakeLockDesc": MessageLookupByLibrary.simpleMessage(
            "Prevent CPU from sleeping when screen is off. (May cause app killed in background on some devices)"),
        "webPage": MessageLookupByLibrary.simpleMessage("Web Page")
      };
}
