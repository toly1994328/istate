import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/secret_list/model/secret.dart';
import '../../data/secret_list/secret_list_river.dart';
import 'secret_fetch_button.dart';
import 'secret_gen_button.dart';
import 'secret_push_button.dart';
import 'secret_text.dart';

class SecretGenPage extends ConsumerWidget {
  final Secret secret;

  const SecretGenPage({super.key, required this.secret});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(36),
          child: Row(
            children: const [
              SecretGenButton(),
              SecretFetchButton(),
              SecretPushButton(),
            ],
          ),
        ),
        title: Column(
          children: [
            Text(secret.title),
            const SizedBox(height: 2),
            const GenTitleText(),
          ],
        ),
        // actions: const [
        //   SecretGenButton(),
        //   SecretFetchButton(),
        //   SizedBox(
        //     width: 8,
        //   )
        // ],
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

class GenTitleText extends ConsumerWidget {
  const GenTitleText({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(secretListProvider).when(
        data: (value) {
          print(value.activeSecret);
          return Text(
            "最近更新: ${value.activeSecret?.updateStr}",
            style: const TextStyle(fontSize: 10, color: Colors.grey),
          );
        },
        error: (_, __) => SizedBox(),
        loading: () => const CupertinoActivityIndicator(radius: 8,));
  }
}
