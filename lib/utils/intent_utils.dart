import 'package:android_intent_plus/android_intent.dart';

class IntentUtils {
  static AndroidIntent getUrlIntent(String url) {
    return AndroidIntent(action: "action_view", data: url);
  }
}
