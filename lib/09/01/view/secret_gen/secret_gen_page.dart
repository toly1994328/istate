import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/secret_list/model/secret.dart';
import 'secret_fetch_button.dart';
import 'secret_gen_button.dart';
import 'secret_text.dart';

class SecretGenPage extends ConsumerWidget {
  final Secret secret;
  const SecretGenPage( {super.key,required this.secret});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Column(
          children: [
            Text(secret.title),
            const SizedBox(height: 4,),
            Text("最近更新: ${secret.updateStr}",style: const TextStyle(fontSize: 10,color: Colors.grey),),
          ],
        ),
        actions: const [
          SecretGenButton(),
          SecretFetchButton(),
          SizedBox(width: 8,)
        ],
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[Text('您当前的秘钥数值是:'), SecretText()],
        ),
      ),
    );
  }
}
