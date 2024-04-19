import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../river/river.dart';
import '../../data/data.dart';

import '../secret_list/dialog/edit_secret_page.dart';
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
        title: const GenBarTitle(),
        actions: [
          IconButton(
            onPressed: () => _toEditPage(ref, context),
            icon: const Icon(Icons.edit, size: 20),
          ),
          const SizedBox(
            width: 6,
          )
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

  void _toEditPage(WidgetRef ref, BuildContext context) {
    Secret? secret = ref.watch(secretListProvider).value?.activeSecret;
    if (secret != null) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => EditSecretPage(op: EditOp(secret))),
      );
    }
  }
}

class GenBarTitle extends ConsumerWidget {
  const GenBarTitle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const TextStyle style = TextStyle(fontSize: 10, color: Colors.grey);
    return ref.watch(secretListProvider).when(
        data: (value) {
          return Column(
            children: [
              Text("${value.activeSecret?.title}"),
              Text(
                "最近更新: ${value.activeSecret?.updateStr}",
                style: style,
              ),
            ],
          );
        },
        error: (_, __) => const SizedBox(),
        loading: () => const CupertinoActivityIndicator(radius: 8));
  }
}
