import 'package:flutter/material.dart';

class DividerPreference extends StatelessWidget {
  const DividerPreference({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const Divider(
        height: 1,
      ),
      Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        child: Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Theme.of(context).primaryColor),
        ),
      ),
    ]);
  }
}

class BasicPreference extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget? leading;
  final Widget? trailing;
  final GestureTapCallback? onTap;

  const BasicPreference({
    super.key,
    required this.title,
    required this.subtitle,
    this.onTap,
    this.leading,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      leading: leading,
      trailing: trailing,
      onTap: onTap,
    );
  }
}

class SwitchPreference extends StatelessWidget {
  const SwitchPreference({
    super.key,
    required this.title,
    required this.subtitle,
    this.icon,
    required this.value,
    required this.onChanged,
  });

  final String title;
  final String subtitle;
  final Widget? icon;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return BasicPreference(
      title: title,
      subtitle: subtitle,
      leading: icon,
      trailing: Switch(value: value, onChanged: onChanged),
      onTap: () {
        onChanged(!value);
      },
    );
  }
}
