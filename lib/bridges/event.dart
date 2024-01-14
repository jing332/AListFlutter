import 'package:flutter/services.dart';

abstract class Event {
  static const EventChannel _eventChannel = EventChannel('alistflutter/event');
  static void onListenStreamData(onEvent, onError) {
    _eventChannel.receiveBroadcastStream().listen(onEvent, onError: onError);
  }
}
