import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/secret_gen_river.dart';

class SecretGenButton extends ConsumerWidget {
  const SecretGenButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<int> taskValue = ref.watch(secretGenProvider);
    refresh() => ref.read(secretGenProvider.notifier).gen();

    return FloatingActionButton(
      onPressed: taskValue.when(
        data: (v) =>  refresh,
        error: (_, __) => refresh,
        loading: () => null,
      ),
      child: taskValue.when(
        data: (v) =>  const Icon(Icons.refresh),
        error: (_, __) => const Icon(
          Icons.refresh,
          color: Colors.red,
        ),
        loading: () => const CupertinoActivityIndicator()
      ),
    );
  }
}
