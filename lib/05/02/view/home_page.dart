import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../logic/counter_logic.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final CounterLogic logic = CounterLogic();
  StreamSubscription<Status>? _statusSubscription;

  @override
  void initState() {
    super.initState();
    _statusSubscription = logic.stream.listen(_onStatusChange);
  }

  @override
  void dispose() {
    _statusSubscription?.cancel();
    logic.close();
    super.dispose();
  }

  void _onStatusChange(Status status) {
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              // 'You have pushed the button this many times:',
              '下面是你点击按钮的次数:',
            ),
            Text(
              '${logic.state}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: buttonAction,
        tooltip: '增加',
        child: buttonChild,
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget get buttonChild => switch(logic.status){
    Status.loading =>const CupertinoActivityIndicator(),
    Status.none => const Icon(Icons.add),
    Status.error => const Icon(Icons.error,color: Colors.redAccent,),
  };

  VoidCallback? get buttonAction => switch(logic.status){
    Status.loading => null,
    Status.none => logic.emit,
    Status.error => logic.emit,
  };

}
