import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'
    hide ChangeNotifierProvider;
import 'package:provider/provider.dart';
import 'state/counter_page.dart';
import 'bloc/bloc_counter_page.dart';
import 'bloc/counter_bloc.dart';
import 'get/get_counter_page.dart';
import 'provider/counter_model.dart';
import 'provider/provider_counter_page.dart';
import 'riverpod/riverpod_counter_page.dart';

void main() => runApp(MyApp());

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
        appBarTheme: const AppBarTheme(
            centerTitle: true,
            backgroundColor: const Color(0xfff2f2f2),
            titleTextStyle:
                TextStyle(fontFamily: "黑体", fontSize: 16, color: Colors.black)),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> descMap = [
      {
        'title': 'State',
        'slogan': 'Flutter 内部状态管理',
      },
      {
        'title': 'Provider',
        'slogan': '包装 InheritedWidget 使其更易于使用和重用',
      },
      {
        'title': 'Bloc',
        'slogan': '对 BLoC 设计模式的 Flutter 框架实现',
      },
      {
        'title': 'Riverpod',
        'slogan': '响应式缓存和数据绑定框架，让异步代码更简单',
      },
      {
        'title': 'Get',
        'slogan': '无上下文依赖，注入依赖关系的轻量管理状态',
      }
    ];

    return Scaffold(
        appBar: AppBar(
          title: const Text("状态数据生命测试"),
        ),
        body: ListView.builder(
          itemBuilder: (ctx, index) => ListTile(
            onTap: () => onTap(ctx, descMap[index]['title']!),
            title: Text(descMap[index]['title']!),
            subtitle: Text(
              descMap[index]['slogan']!,
              style: TextStyle(fontSize: 12),
            ),
            trailing: Icon(Icons.navigate_next),
          ),
          itemCount: descMap.length,
        ));
  }

  void onTap(BuildContext context, String title) {
    Widget page = const SizedBox();

    if (title == 'Bloc') {
      page = BlocProvider<CounterBloc>(
        create: (BuildContext context) {
          return CounterBloc();
        },
        child: const BlocCounterPage(),
      );
    }
    if (title == 'State') {
      page = CounterPage();
    }

    if (title == 'Provider') {
      page = ChangeNotifierProvider<CounterModel>(
        create: (BuildContext context) {
          return CounterModel();
        },
        child: const ProviderCounterPage(),
      );
    }

    if (title == 'Riverpod') {
      page = const ProviderScope(
        child: RiverpodCounterPage(),
      );
    }
    if (title == 'Get') {
      page = const GetCounterPage();
    }
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => page));
  }
}
