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
        "bootAutoStartService":
            MessageLookupByLibrary.simpleMessage("Boot auto-start service"),
        "bootAutoStartServiceDesc": MessageLookupByLibrary.simpleMessage(
            "Automatically start AList service after boot. (Please make sure to grant auto-start permission)"),
        "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "checkForUpdates":
            MessageLookupByLibrary.simpleMessage("Check for updates"),
        "copiedToClipboard": MessageLookupByLibrary.simpleMessage("已复制到剪贴板"),
        "currentIsLatestVersion":
            MessageLookupByLibrary.simpleMessage("Current is latest version"),
        "desktopShortcut":
            MessageLookupByLibrary.simpleMessage("Desktop shortcut"),
        "download": MessageLookupByLibrary.simpleMessage("下载"),
        "downloadApk": MessageLookupByLibrary.simpleMessage("Download APK"),
        "downloadThisFile": MessageLookupByLibrary.simpleMessage("下载此文件吗？"),
        "general": MessageLookupByLibrary.simpleMessage("General"),
        "goTo": MessageLookupByLibrary.simpleMessage("前往"),
        "jump_to_other_app":
            MessageLookupByLibrary.simpleMessage("Jump to other app？"),
        "moreOptions": MessageLookupByLibrary.simpleMessage("More options"),
        "releasePage": MessageLookupByLibrary.simpleMessage("Release Page"),
        "selectAppToOpen": MessageLookupByLibrary.simpleMessage("选择应用打开"),
        "setAdminPassword":
            MessageLookupByLibrary.simpleMessage("Set admin password"),
        "settings": MessageLookupByLibrary.simpleMessage("Settings"),
        "wakeLock": MessageLookupByLibrary.simpleMessage("Wake lock"),
        "wakeLockDesc": MessageLookupByLibrary.simpleMessage(
            "Prevent CPU from sleeping when screen is off. (May cause app killed in background on some devices)"),
        "webPage": MessageLookupByLibrary.simpleMessage("Web Page")
      };
}
