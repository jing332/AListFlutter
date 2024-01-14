import 'package:alist_flutter/pages/alist.dart';
import 'package:alist_flutter/pages/settings.dart';
import 'package:alist_flutter/pages/web.dart';
import 'package:flutter/material.dart';

abstract class AppRouter {
  static const List<Widget> pages = [
    AListScreen(),
    WebScreen(),
    SettingsScreen()
  ];

  static const List<NavigationDestination> destinations = [
    NavigationDestination(
      icon: Icon(Icons.home),
      label: 'AList',
    ),
    NavigationDestination(
      icon: Icon(Icons.preview),
      label: 'Web',
    ),
    NavigationDestination(
      icon: Icon(Icons.settings),
      label: 'Settings',
    ),
  ];
}
