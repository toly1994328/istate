import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'data/secret_gen_river.dart';
import 'view/secret_gen_page.dart';

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
        appBarTheme: const AppBarTheme(
            backgroundColor: const Color(0xfff2f2f2),
            titleTextStyle: TextStyle(
                fontFamily: "黑体",
                fontSize: 16, color: Colors.black)),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SecretGenPage(),
    );
  }
}

