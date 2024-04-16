import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'counter/river/counter_river.dart';
import 'starter/river/app_start.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app/river/app_theme_river.dart';

import 'counter/data/counter_repository.dart';

import 'app/river/theme.dart';

import 'starter/river/state.dart';
import 'starter/views/error_page.dart';
import 'views/navigation/app_navigation.dart';
import 'starter/views/splash_page.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    ThemeMode themeMode = ref.watch(appThemeRiverProvider);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'istate',
        themeMode: themeMode,
        darkTheme: AppTheme.getDarkThemeData(),
        theme: AppTheme.getLightThemeData(),
        home: AppStartListener(child: const SplashPage()));
  }


}

class AppStartListener extends ConsumerWidget {
  final Widget child;
  const AppStartListener({super.key,required this.child});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    ref.listen(appStartProvider, (p,n)=>_listenAppStateChange(context,ref,p,n));
    return child;

  }

  void _listenAppStateChange(BuildContext context, WidgetRef ref, AppStatus? prev, AppStatus state) {
    if (state is AppLoadDone) {
      SharedPreferences sp = ref.read(appStartProvider.notifier).sp;
      CounterRepository repository = CounterRepository(sp);
      ref.read(counterRiverProvider.notifier).init(repository);
    }

    if (state is AppStartSuccess) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const AppNavigation()),
      );
    }
    if (state is AppStartFailed) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (_) => AppStartErrorPage(message: state.error)),
      );
    }
  }
}
