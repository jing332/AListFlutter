import 'dart:ui';

class LogLevel {
  static const int panic = 0;
  static const int fatal = 1;
  static const int error = 2;

  static const int warn = 3;
  static const int info = 4;
  static const int debug = 5;
  static const int trace = 6;

  static Color toColor(int level) {
    //Color.fromARGB(a, r, g, b)
    return switch(level) {
      LogLevel.panic => const Color.fromARGB(255, 255, 0, 0),
      LogLevel.fatal => const Color.fromARGB(255, 255, 0, 0),
      LogLevel.error => const Color.fromARGB(255, 255, 0, 0),
      LogLevel.warn => const Color.fromARGB(255, 255, 165, 0),
      LogLevel.info => const Color.fromARGB(255, 0, 0, 255),
      LogLevel.debug => const Color.fromARGB(255, 0, 255, 0),
      LogLevel.trace => const Color.fromARGB(255, 0, 255, 0),
      _ => const Color.fromARGB(255, 0, 0, 0)
    };
  }

  static String toStr(int level) {
    return switch(level) {
      LogLevel.panic => "Panic",
      LogLevel.fatal => "Fatal",
      LogLevel.error => "Error",
      LogLevel.warn => "Warn",
      LogLevel.info => "Info",
      LogLevel.debug => "Debug",
      LogLevel.trace => "Trace",
      _ => ""
    };
  }
}
