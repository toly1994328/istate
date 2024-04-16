import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/secret_gen_river.dart';
import 'secret_fetch_button.dart';
import 'secret_gen_button.dart';
import 'secret_text.dart';

class SecretGenPage extends ConsumerWidget {
  const SecretGenPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 52,
        centerTitle: true,
        title: const Text("秘钥生成器"),
        actions: const [
          SecretFetchButton(),
          SizedBox(width: 12,)
        ],
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[Text('您当前的秘钥数值是:'), SecretText()],
        ),
      ),
      floatingActionButton:
          const SecretGenButton(), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
