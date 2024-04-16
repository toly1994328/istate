import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/secret_gen_river.dart';

class SecretFetchButton extends ConsumerWidget {
  const SecretFetchButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<int> taskValue = ref.watch(secretGenProvider);
    refresh() => ref.read(secretGenProvider.notifier).fetch();

    return IconButton(
      onPressed: taskValue.when(
        data: (_) =>  refresh,
        error: (_, __) => refresh,
        loading: () => null,
      ),
      icon: taskValue.when(
        data: (_) =>  const Icon(Icons.call_received,color: Colors.blue,),
        error: (_, __) => const Icon(
          Icons.call_received,
          color: Colors.red,
        ),
        loading: () =>const CupertinoActivityIndicator()
      ),
    );
  }
}
