import 'package:flutter/cupertino.dart';

import '../../contant/log_level.dart';

class LogLevelView extends StatefulWidget {
  final int level;

  const LogLevelView({super.key, required this.level});

  @override
  State<LogLevelView> createState() => _LogLevelViewState();
}

class _LogLevelViewState extends State<LogLevelView> {
  @override
  Widget build(BuildContext context) {
    final s = LogLevel.toStr(widget.level);
    final c = LogLevel.toColor(widget.level);
    return Text(s, style: TextStyle(color: c));
  }
}
