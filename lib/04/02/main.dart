import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app/theme.dart';

import 'manager/app_theme_provider.dart';
import 'views/navigation/app_navigation.dart';

void main() {
  runApp(const ManagerWrapper(child: MyApp()));
}

class ManagerWrapper extends StatelessWidget {
  final Widget child;

  const ManagerWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppThemeManager(),
      child:  const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    AppThemeManager appThemeManager = context.watch<AppThemeManager>();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'istate',
      themeMode: appThemeManager.mode,
      darkTheme: AppTheme.getDarkThemeData(),
      theme: AppTheme.getLightThemeData(),
      home: AppNavigation(),
    );
  }
}
