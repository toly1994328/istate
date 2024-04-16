import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'modules/starter/views/splash_page.dart';

import 'modules/starter/river/app_start.dart';
import 'modules/starter/river/state.dart';
import 'modules/starter/views/error_page.dart';
import 'view/secret_list/secrets_page.dart';

void main() {
  runApp(
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'istate',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        fontFamily: "黑体",
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: <TargetPlatform, PageTransitionsBuilder>{
            TargetPlatform.android: ZoomPageTransitionsBuilder(
              allowEnterRouteSnapshotting: false,
            ),
          },
        ),
        chipTheme: ChipThemeData(
          side: BorderSide.none,
          backgroundColor: Color(0xfff3f4f6),
          labelStyle: TextStyle(fontSize: 12,color: Colors.grey),
          labelPadding: EdgeInsets.symmetric(horizontal: 12),

          padding: EdgeInsets.zero
        ),
        appBarTheme: const AppBarTheme(
            backgroundColor: const Color(0xfff2f2f2),
            titleTextStyle: TextStyle(
                fontFamily: "黑体",
                fontSize: 16, color: Colors.black)),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const AppStartListener(
        child: SplashPage(),
      ),
    );
  }
}


class AppStartListener extends ConsumerWidget {
  final Widget child;
  const AppStartListener({super.key,required this.child});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    ref.listen(appStartProvider, (p,n)=>_listenAppStateChange(ref,p,n));
    return child;
  }

  void _listenAppStateChange(WidgetRef ref, AppStatus? prev, AppStatus state) {
    if (state is AppLoadDone) {
      /// 初始化任务已完成
      /// 可处理一些首页数据的预加载
    }

    if (state is AppStartSuccess) {
      Navigator.of(ref.context).pushReplacement(
        MaterialPageRoute(builder: (_) => const SecretsPage()),
      );
    }
    if (state is AppStartFailed) {
      Navigator.of(ref.context).pushReplacement(
        MaterialPageRoute(
            builder: (_) => AppStartErrorPage(message: state.error)),
      );
    }
  }
}

