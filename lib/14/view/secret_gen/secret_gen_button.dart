import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../components/error_icon_wrapper.dart';
import '../../river/secret_gen/secret_gen_river.dart';

class SecretGenButton extends ConsumerWidget {
  const SecretGenButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<String> taskValue = ref.watch(secretGenProvider);
    refresh() => ref.read(secretGenProvider.notifier).gen();

    // (Widget, VoidCallback?) child = taskValue.when(
    //     skipLoadingOnRefresh: false,
    //     data: (int value) => (const Icon(Icons.refresh), refresh),
    //     error: (e, _) => (const Icon(Icons.error), refresh),
    //     loading: () => (const CupertinoActivityIndicator(), null));

    return IconButton(
      onPressed: taskValue.when(
        data: (v) => refresh,
        error: (_, __) => refresh,
        loading: () => null,
      ),
      icon: taskValue.when(
        data: (v) => const Icon(
          Icons.refresh,
          color: Color(0xff59a869),
        ),
        error: (error, __) => ErrorIconWrapper(
          enable: SecretGen.op == OperationType.gen,
          error: error.toString(),
          child: const Icon(
            Icons.refresh,
            color: Color(0xff59a869),
          ),
        ),
        loading: () => SecretGen.op == OperationType.gen
            ? const CupertinoActivityIndicator()
            : const Icon(Icons.refresh, color: Colors.grey),
      ),
    );
  }
}
