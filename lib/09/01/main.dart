import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'starter/bloc/bloc.dart';
import 'counter/bloc/counter_bloc.dart';
import 'counter/data/counter_repository.dart';
import 'app/bloc/app_theme_bloc.dart';
import 'app/bloc/theme.dart';

import 'starter/bloc/state.dart';
import 'starter/views/error_page.dart';
import 'views/navigation/app_navigation.dart';
import 'starter/views/splash_page.dart';

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
        BlocProvider(create: (_) => AppStartBloc()..startApp()),
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
        home: BlocListener<AppStartBloc, AppStatus>(
          listener: _listenAppStateChange,
          child: const SplashPage(),
        ));
  }

  void _listenAppStateChange(BuildContext context, AppStatus state) {
    if (state is AppLoadDone) {
      SharedPreferences sp = context.read<AppStartBloc>().sp;
      CounterRepository repository = CounterRepository(sp);
      context.read<AppCounterBloc>().init(repository);
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
