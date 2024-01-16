import 'package:alist_flutter/pages/alist/log_level_view.dart';
import 'package:flutter/material.dart';

class Log {
  final int level;
  final String time;
  final String content;

  Log(this.level, this.time, this.content);
}

class LogListView extends StatefulWidget {
  const LogListView({Key? key, required this.logs, this.controller}) : super(key: key);

  final List<Log> logs;
  final ScrollController? controller;

  @override
  State<LogListView> createState() => _LogListViewState();
}

class _LogListViewState extends State<LogListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.logs.length,
      controller: widget.controller,
      itemBuilder: (context, index) {
        final log = widget.logs[index];
        return ListTile(
          dense: true,
          title: SelectableText(log.content),
          subtitle: SelectableText(log.time),
          leading: LogLevelView(level: log.level),
        );
      },
    );
  }
}
