import 'dart:ui';

import 'package:flutter/material.dart';

//      theme: ThemeData(
//         scaffoldBackgroundColor: Colors.white,
//         fontFamily: "黑体",
//         pageTransitionsTheme: const PageTransitionsTheme(
//           builders: <TargetPlatform, PageTransitionsBuilder>{
//             TargetPlatform.android: ZoomPageTransitionsBuilder(
//               allowEnterRouteSnapshotting: false,
//             ),
//           },
//         ),
//         appBarTheme: const AppBarTheme(
//             centerTitle: true,
//             backgroundColor: const Color(0xfff2f2f2),
//             titleTextStyle:
//                 TextStyle(fontFamily: "黑体", fontSize: 16, color: Colors.black)),
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
class AppTheme {
  static double px1 =
      1 / PlatformDispatcher.instance.views.first.devicePixelRatio;

  static ThemeData getDarkThemeData() {
    Color primaryColor = Colors.blueGrey;
    ColorScheme scheme = ColorScheme.fromSeed(seedColor: Colors.blue);

    return ThemeData(
      // useMaterial3: false,
      primaryColor: primaryColor,
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: <TargetPlatform, PageTransitionsBuilder>{
          TargetPlatform.android: ZoomPageTransitionsBuilder(
            allowEnterRouteSnapshotting: false,
          ),
        },
      ),
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.all(primaryColor),
        trackColor:  MaterialStateProperty.all( Color(0xff010201)),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primaryColor,
      ),
      // colorScheme: scheme,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xff010201),
      appBarTheme: AppBarTheme(
          backgroundColor: primaryColor,
          titleTextStyle: const TextStyle(fontSize: 18, color: Colors.white)),
      listTileTheme: const ListTileThemeData(
        tileColor: Color(0xff181818),
        textColor: Color(0xffD6D6D6),
      ),
      dividerTheme: DividerThemeData(
        color: const Color(0xff2F2F2F),
        space: px1,
        thickness: px1,
      ),
    );
  }

  static ThemeData getLightThemeData() {
    ColorScheme scheme = ColorScheme.fromSeed(seedColor: Colors.blue);
    return ThemeData(
      // useMaterial3: false,
      bottomSheetTheme: BottomSheetThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),

      scaffoldBackgroundColor: const Color(0xffF3F4F6),
      appBarTheme: AppBarTheme(
          centerTitle: true,
          backgroundColor: const Color(0xfff2f2f2),
          titleTextStyle: const TextStyle(
            fontSize: 18,
            color: Colors.black,
          )),
      colorScheme: scheme,
      listTileTheme: const ListTileThemeData(
        tileColor: Colors.white,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: const Color(0xfff2f2f2),
      ),
      chipTheme: ChipThemeData(
          side: BorderSide.none,
          backgroundColor: Color(0xfff3f4f6),
          labelStyle: TextStyle(fontSize: 12, color: Colors.grey),
          labelPadding: EdgeInsets.symmetric(horizontal: 12),
          padding: EdgeInsets.zero),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: const Color(0xfff2f2f2),
      ),

      pageTransitionsTheme: const PageTransitionsTheme(
        builders: <TargetPlatform, PageTransitionsBuilder>{
          TargetPlatform.android: ZoomPageTransitionsBuilder(
            allowEnterRouteSnapshotting: false,
          ),
        },
      ),
      dividerTheme: DividerThemeData(
        color: const Color(0xffDEE0E2),
        space: px1,
        thickness: px1,
      ),
    );
  }
}
