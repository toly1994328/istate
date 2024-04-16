import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'get/counter.dart';

void main() {
  runApp(const MyApp());
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
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    print("======_MyHomePageState#build==============");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("计数器"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              '下面是你点击按钮的次数:',
            ),
            _buildText(context),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.find<CounterCtrl>().increment(),
        tooltip: '增加',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _buildText(BuildContext context) {
    // return GetX<CounterModel>(
    //   init: CounterModel(),
    //   builder: (CounterModel controller) {
    //     return Text(
    //       controller.count.toString(),
    //       style: Theme.of(context).textTheme.headlineMedium,
    //     );
    //   },
    // );
    return GetBuilder<CounterCtrl>(
      init: CounterCtrl(),
      builder: (CounterCtrl controller) {
        return Text(
          controller.count.toString(),
          style: Theme.of(context).textTheme.headlineMedium,
        );
      },
    );
  }
}
