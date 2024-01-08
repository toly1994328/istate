import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'manager/app_counter_bloc.dart';
import 'manager/app_theme_bloc.dart';
import 'app/theme.dart';

import 'views/navigation/app_navigation.dart';

void main() {
  runApp(const ManagerWrapper(child: MyApp()));
}

class ManagerWrapper extends StatelessWidget {
  final Widget child;

  const ManagerWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AppCounterBloc()),
        BlocProvider(create: (_) => AppThemeBloc()),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    AppThemeBloc appThemeBloc = context.watch<AppThemeBloc>();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'istate',
      themeMode: appThemeBloc.state,
      darkTheme: AppTheme.getDarkThemeData(),
      theme: AppTheme.getLightThemeData(),
      home: AppNavigation(),
    );
  }
}
