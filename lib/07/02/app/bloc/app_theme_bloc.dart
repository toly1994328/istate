import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Map<ThemeMode, String> kThemeModeMap = const {
  ThemeMode.system: "跟随系统",
  ThemeMode.light: "浅色模式",
  ThemeMode.dark: "深色模式",
};

class AppThemeBloc extends Cubit<ThemeMode>{

  AppThemeBloc():super(ThemeMode.system);

  void setTheme(ThemeMode theme){
    emit(theme);
  }

  void switchTheme(bool dark) {
    if (dark) {
      setTheme(ThemeMode.dark);
    } else {
      setTheme(ThemeMode.light);
    }
  }

  String get title => kThemeModeMap[state]!;
}