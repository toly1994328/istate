import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'data/counter_model.dart';

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
        appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(fontSize: 18, color: Colors.black)),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: '计数器'),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    print("=======MyHomePage#build============");
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(title),
        ),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                // 'You have pushed the button this many times:',
                '下面是你点击按钮的次数:',
              ),
              CounterText()
            ],
          ),
        ),
        floatingActionButton:  FloatingActionButton(
              onPressed: () => ref.read(counterProvider.notifier).increment(),
              tooltip: '增加',
              // tooltip: 'Increment',
              child: const Icon(Icons.add),
        ), // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}


class CounterText extends ConsumerWidget{
  const CounterText({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Text(
      '${ref.watch(counterProvider)}',
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }
}