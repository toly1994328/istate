import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/secret_list/secret_list_river.dart';
import '../secret_gen/secret_gen_page.dart';

class AddSecretDialog extends StatefulWidget {
  const AddSecretDialog({super.key});

  @override
  State<AddSecretDialog> createState() => _AddSecretDialogState();
}

class _AddSecretDialogState extends State<AddSecretDialog> {
  final TextEditingController _ctrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    const TextStyle inputStyle = TextStyle(fontSize: 14);
    const TextStyle holderStyle = TextStyle(fontSize: 14, color: Colors.grey);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text('添加秘钥领域'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ConformButton(
              onConform: (WidgetRef ref) {
                ref.read(secretListProvider.notifier).addSecret(_ctrl.text);
              },
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: CupertinoTextField(
                controller: _ctrl,
                placeholder: '请输入领域名称',
                style: inputStyle,
                placeholderStyle: holderStyle,
              ),
            ),
            const Text(
              '添加领域之后，将会生成对应领域的随机秘钥。',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

class ConformButton extends ConsumerWidget {
  final ValueChanged<WidgetRef> onConform;

  const ConformButton({super.key, required this.onConform});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(secretListProvider, (p, n) => _listenListChange(context, p, n));
    final taskValue = ref.watch(secretListProvider);
    return TextButton(
      onPressed: () => onConform(ref),
      child: taskValue.when(
          data: (v) => const Text('确定'),
          error: (error, __) => _buildError(error.toString()),
          loading: () => const CupertinoActivityIndicator()),
    );
  }

  Widget _buildError(String msg) {
    return Tooltip(
      message: msg,
      child: const Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [Text('确定'), Icon(Icons.error, color: Colors.red, size: 12)],
      ),
    );
  }

  void _listenListChange(BuildContext context, previous, next) {
    int prevLen = previous?.secret?.secrets.length ?? 0;
    int nextLen = next.secret?.secrets.length ?? 0;
    if (prevLen + 1 == nextLen) {
      Navigator.pop(context);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => SecretGenPage(secret: next.secret!.activeSecret!),
        ),
      );
    }
  }
}
