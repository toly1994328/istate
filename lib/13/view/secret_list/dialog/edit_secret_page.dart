import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:istate/utils/toast.dart';

import '../../../components/input/simple_input.dart';
import '../../../data/model/secret.dart';
import '../../../river/secret_list/secret_list_river_op.dart';
import '../../../river/secret_list/state/secrets_state.dart';
import '../action/secret_action.dart';

class EditSecretPage extends StatefulWidget {
  final EditOp op;

  const EditSecretPage({Key? key, required this.op}) : super(key: key);

  @override
  State<EditSecretPage> createState() => _EditSecretPageState();
}

class _EditSecretPageState extends State<EditSecretPage> {
  late final TextEditingController _titleCtrl =
      TextEditingController(text: widget.op.secret.title);

  @override
  void dispose() {
    _titleCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color? bgColor = Theme.of(context).appBarTheme.backgroundColor;
    Color? sbgColor = Theme.of(context).scaffoldBackgroundColor;
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? null : bgColor,
      appBar: AppBar(
        backgroundColor: isDark ? null : sbgColor,
        centerTitle: true,
        title: const Text('修改领域', style: TextStyle(fontSize: 16)),
        actions: [
          SecretOpAction<EditOp>(
            onConform: _onConform,
            conformText: '保存',
            onListenError: context.error,
            onListenSuccess: (data) {
              if (data is (Secret,Secret)) {
                Navigator.pop(context);
              }
            },
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: SimpleInput(
              radius: 6,
              controller: _titleCtrl,
              keyboardType: TextInputType.number,
              label: '',
              hint: "请输入新的领域名",
              info: '你需要秘钥校验的领域名称',
            ),
          ),
        ],
      ),
    );
  }

  void _onConform(WidgetRef ref) {
    ref.read(secretListOpProvider.notifier).editSecret(
          widget.op,
          UpdateSecretPayload(title: _titleCtrl.text),
        );
  }
}

