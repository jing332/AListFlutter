import 'dart:developer';

import 'package:alist_flutter/generated/l10n.dart';
import 'package:alist_flutter/generated_api.dart';
import 'package:alist_flutter/pages/alist/alist.dart';
import 'package:alist_flutter/pages/app_update_dialog.dart';
import 'package:alist_flutter/pages/settings/settings.dart';
import 'package:alist_flutter/pages/web/web.dart';
import 'package:fade_indexed_stack/fade_indexed_stack.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Android
  if (!kIsWeb &&
      kDebugMode &&
      defaultTargetPlatform == TargetPlatform.android) {
    await InAppWebViewController.setWebContentsDebuggingEnabled(kDebugMode);
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'AListFlutter',
      themeMode: ThemeMode.system,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blueGrey,
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
      ),
      darkTheme:ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorSchemeSeed: Colors.blueGrey,
        /* dark theme settings */
      ),
      supportedLocales: S.delegate.supportedLocales,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: const MyHomePage(title: ""),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  static const webPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(_MainController());

    return Scaffold(
        body: Obx(
          () => FadeIndexedStack(
            lazy: true,
            index: controller.selectedIndex.value,
            children: [
              WebScreen(key: webGlobalKey),
              const AListScreen(),
              const SettingsScreen()
            ],
          ),
        ),
        bottomNavigationBar: Obx(() => NavigationBar(
                destinations: [
                  NavigationDestination(
                    icon: const Icon(Icons.preview),
                    label: S.current.webPage,
                  ),
                  NavigationDestination(
                    icon: SvgPicture.asset(
                      "assets/alist.svg",
                      color: Theme.of(context).hintColor,
                      width: 32,
                      height: 32,
                    ),
                    label: S.current.appName,
                  ),
                  NavigationDestination(
                    icon: const Icon(Icons.settings),
                    label: S.current.settings,
                  ),
                ],
                selectedIndex: controller.selectedIndex.value,
                onDestinationSelected: (int index) {
                  // Web
                  if (controller.selectedIndex.value == webPageIndex &&
                      controller.selectedIndex.value == webPageIndex) {
                    webGlobalKey.currentState?.onClickNavigationBar();
                  }

                  controller.setPageIndex(index);
                })));
  }
}

class _MainController extends GetxController {
  final selectedIndex = 1.obs;

  setPageIndex(int index) {
    selectedIndex.value = index;
  }

  @override
  void onInit() async {
    final webPage = await AppConfig().isAutoOpenWebPageEnabled();
    if (webPage) {
      setPageIndex(MyHomePage.webPageIndex);
    }

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      if (await AppConfig().isAutoCheckUpdateEnabled()) {
        AppUpdateDialog.checkUpdateAndShowDialog(Get.context!, null);
      }
    });

    super.onInit();
  }
}
