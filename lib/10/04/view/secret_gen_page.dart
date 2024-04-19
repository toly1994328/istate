import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'secret_gen_button.dart';
import 'secret_text.dart';

class SecretGenPage extends ConsumerWidget {
  const SecretGenPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("秘钥生成器"),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('下面是随机生成的秘密数字:'),
            SecretText()
          ],
        ),
      ),
      floatingActionButton: const SecretGenButton(), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
