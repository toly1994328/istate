import 'dart:ui';

import 'package:flutter/material.dart';
import 'app/theme.dart';
import 'views/home_page.dart';

import 'manager/app_theme_manager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    kAppThemeManager.addListener(_onDarkThemeChange);
  }

  void _onDarkThemeChange() {
    setState(() {});
  }

  @override
  void dispose() {
    kAppThemeManager.removeListener(_onDarkThemeChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'istate',
      themeMode: kAppThemeManager.mode,
      darkTheme: AppTheme.getDarkThemeData(),
      theme: AppTheme.getLightThemeData(),
      home: MyHomePage(
        title: '计数器',
      ),
    );
  }
}


