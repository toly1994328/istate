import 'package:flutter/material.dart';

class AppThemeScope extends InheritedNotifier<AppThemeManager>{
  const AppThemeScope({super.key, required super.child,super.notifier});

  static AppThemeManager of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppThemeScope>()!.notifier!;
  }

  static AppThemeManager read(BuildContext context) {
    return context.getInheritedWidgetOfExactType<AppThemeScope>()!.notifier!;
  }
}

Map<ThemeMode, String> kThemeModeMap = const {
  ThemeMode.system: "跟随系统",
  ThemeMode.light: "浅色模式",
  ThemeMode.dark: "深色模式",
};

class AppThemeManager extends ChangeNotifier {

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
