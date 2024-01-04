import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/provider_test_item.dart';

class DebuggerPage extends StatelessWidget {
  const DebuggerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider(
      // lazy: false,
      create: (_) => DataModel(),
      dispose: (_, model) => model.dispose(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('功能测试'),
          // backgroundColor: Colors.white,
        ),
        body: ListView(
          children: <Widget>[
            Container(height: 15),
            const ProviderTestItem(),
          ],
        ),
      ),
    );
  }
}



