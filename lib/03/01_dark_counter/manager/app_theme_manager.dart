
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


}
