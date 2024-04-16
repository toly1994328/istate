import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'app_theme_river.g.dart';

Map<ThemeMode, String> kThemeModeMap = const {
  ThemeMode.system: "跟随系统",
  ThemeMode.light: "浅色模式",
  ThemeMode.dark: "深色模式",
};


@riverpod
class AppThemeRiver extends _$AppThemeRiver{

  @override
  ThemeMode build() => ThemeMode.system;

  void setTheme(ThemeMode theme){
    state = theme;
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