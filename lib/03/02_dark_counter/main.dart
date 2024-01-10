import 'package:flutter/material.dart';
import 'app/theme.dart';
import 'views/home_page.dart';

import 'manager/app_theme_manager.dart';

void main() {
  runApp(const ManagerWrapper(child: MyApp()));
}

class ManagerWrapper extends StatelessWidget {
  final Widget child;

  const ManagerWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return AppThemeScope(
      notifier: AppThemeManager(),
      child: child,
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    AppThemeManager appThemeManager = AppThemeScope.of(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'istate',
      themeMode: appThemeManager.mode,
      darkTheme: AppTheme.getDarkThemeData(),
      theme: AppTheme.getLightThemeData(),
      home: const MyHomePage(
        title: '计数器',
      ),
    );
  }
}
