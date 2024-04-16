import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../river/river.dart';
import 'dialog/delete_conform_dialog.dart';
import 'dialog/edit_secret_page.dart';
import 'secrets_list_view.dart';
import '../secret_gen/secret_gen_page.dart';
import 'secrets_top_bar.dart';

class SecretsPage extends ConsumerWidget {
  const SecretsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      appBar: SecretsTopBar(),
      body: Center(child: SecretsContent()),
    );
  }
}

class SecretsContent extends ConsumerWidget {
  const SecretsContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void onOp(BuildContext context, ListOpType op) {
      if (op is JumpOp) {
        ref.read(secretListProvider.notifier).active(op.secret);
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => SecretGenPage(secret: op.secret)),
        );
      }

      if (op is DeleteOp) {
        showCupertinoModalPopup(
          context: context,
          builder: (_) => DeleteConformDialog(op: op),
        );
      }
      if (op is EditOp) {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => EditSecretPage(op: op)),
        );
      }
    }

    return ref.watch(secretListProvider).when(
          skipLoadingOnReload: true,
          data: (state) => SecretsListView(state: state, onOp: onOp),
          error: (error, __) => Text("error:$error"),
          loading: () => const CupertinoActivityIndicator(),
        );
  }
}
