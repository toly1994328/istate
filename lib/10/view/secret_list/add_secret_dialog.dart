import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:istate/utils/toast.dart';

import '../../river/river.dart';
import '../../data/data.dart';
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
                ref.read(secretListOpProvider.notifier).addSecret(AddOp(_ctrl.text));
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

  const ConformButton({
    super.key,
    required this.onConform,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(secretListOpProvider, (p, n) => _listenOpChange(context, p, n));
    final taskValue = ref.watch(secretListOpProvider);
    return TextButton(
      onPressed: () {
        _hideKey(context);
        onConform(ref);
      },
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

  void _hideKey(BuildContext context){
    final FocusScopeNode focusScope = FocusScope.of(context);
    if (focusScope.hasFocus) {
      focusScope.unfocus();
    }
  }

  void _listenOpChange(
    BuildContext context,
    AsyncValue<SecretListOpState?>? previous,
    AsyncValue<SecretListOpState?> next,
  ) {
    if ((previous?.isLoading ?? true) && next.hasError) {
      /// 发生异常
      _handleError(context,next.error.toString());
      return;
    }

    if (previous?.value?.op is NoneOp && next.value?.op is AddOp) {
      /// 添加成功
      Object? secret = next.value?.data;
      if (secret is Secret) {
        _whenAddSuccess(context,secret);
      }
    }
  }

  void _handleError(BuildContext context,String error){
    context.error(error);
  }

  void _whenAddSuccess(BuildContext context,Secret secret){
    Navigator.pop(context);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => SecretGenPage(secret: secret),
      ),
    );
  }
}
