import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../../data/secret_list/model/secret.dart';
import '../../data/secret_list/secret_list_river.dart';
import '../secret_gen/secret_gen_page.dart';
import 'add_secret_dialog.dart';

class SecretsPage extends ConsumerWidget {
  const SecretsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        title: const Text("秘钥列表"),
        actions: [
          IconButton(
            onPressed: () => _showAddDialog(context),
            icon: const Icon(Icons.add),
          ),
          const SizedBox(width: 8)
        ],
      ),
      body: const Center(child: SecretsContent()),
    );
  }

  void _showAddDialog(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      context: context,
      builder: (_) => const AddSecretDialog(),
    );
  }

}

class SecretsContent extends ConsumerWidget {
  const SecretsContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(secretListProvider).when(
        skipLoadingOnReload:true,
        data: (state) => ListView.builder(
            itemCount: state.secrets.length,
            itemBuilder: (_, i) => _buildItem(ref,context,state.secrets[i]),
          ),
        error: (error, __) => Text("error:$error"),
        loading: () => const CupertinoActivityIndicator());
  }

  Widget _buildItem(WidgetRef ref, BuildContext context, Secret secret){
    const TextStyle tailStyle = TextStyle(color: Colors.grey);
    return ListTile(
      onTap: () => _onSelect(ref, context, secret),
      title: Text(secret.title),
      subtitle: Text(secret.secretStr),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('创建:${secret.createStr}', style: tailStyle),
          Text('更新:${secret.updateStr}', style: tailStyle)
        ],
      ),
    );
  }

  void _onSelect(WidgetRef ref, BuildContext context, Secret secret) {
    ref.read(secretListProvider.notifier).active(secret);
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => SecretGenPage(secret: secret)),
    );
  }
}
