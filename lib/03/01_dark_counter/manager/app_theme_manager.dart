import 'dart:ui';

import 'package:flutter/material.dart';

final AppThemeManager kAppThemeManager = AppThemeManager();

Map<ThemeMode, String> kThemeModeMap = const {
  ThemeMode.system: "跟随系统",
  ThemeMode.light: "浅色模式",
  ThemeMode.dark: "深色模式",
};

class AppThemeManager extends ChangeNotifier {

  // 单例模式
  // static AppThemeManager? _instance;
  // AppThemeManager._();
  //
  // static AppThemeManager get instance{
  //   _instance ??= AppThemeManager._();
  //   return _instance!;
  // }



  ThemeMode _mode = ThemeMode.system;

  ThemeMode get mode => _mode;

  String get title => kThemeModeMap[mode]!;

  set mode(ThemeMode mode) {
    _mode = mode;
    notifyListeners();
  }

  void switchTheme(bool dark) {
    if (dark) {
      mode = ThemeMode.dark;
    } else {
      mode = ThemeMode.light;
    }
  }

  ThemeData getDarkThemeData() {
    double px1 = 1/PlatformDispatcher.instance.views.first.devicePixelRatio;
    Color primaryColor = Colors.deepPurple;

    return ThemeData(
      // useMaterial3: false,
      primaryColor: primaryColor,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xff010201),
      appBarTheme: AppBarTheme(
          backgroundColor: primaryColor,
          titleTextStyle: const TextStyle(fontSize: 18, color: Colors.white)),
      listTileTheme: const ListTileThemeData(
        tileColor: Color(0xff181818),
        textColor: Color(0xffD6D6D6),
      ),
      dividerTheme: DividerThemeData(
        color: const Color(0xff2F2F2F),
        space: px1,
        thickness: px1,
      ),
    );
  }

  ThemeData getLightThemeData() {
    double px1 = 1/PlatformDispatcher.instance.views.first.devicePixelRatio;
    ColorScheme scheme = ColorScheme.fromSeed(seedColor: Colors.deepPurple);
    return ThemeData(
      // useMaterial3: false,
      scaffoldBackgroundColor: const Color(0xffF3F4F6),
      appBarTheme: AppBarTheme(
          backgroundColor: scheme.inversePrimary,
          titleTextStyle: const TextStyle(
            fontSize: 18,
            color: Colors.black,
          )),
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      listTileTheme: const ListTileThemeData(
        tileColor: Colors.white,
      ),
      dividerTheme: DividerThemeData(
        color: const Color(0xffDEE0E2),
        space: px1,
        thickness: px1,
      ),
    );
  }
}
