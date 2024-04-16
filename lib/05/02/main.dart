import 'package:flutter/material.dart';
import 'view/home_page.dart';
void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
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

        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: const Color(0xfff2f2f2),
        ),
        appBarTheme: const AppBarTheme(
            scrolledUnderElevation: 0,
            centerTitle: true,
            backgroundColor: const Color(0xfff2f2f2),
            titleTextStyle:
            TextStyle(fontFamily: "黑体", fontSize: 16, color: Colors.black)),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),

        home: const MyHomePage(title: '计数器'),
    );
  }
}


