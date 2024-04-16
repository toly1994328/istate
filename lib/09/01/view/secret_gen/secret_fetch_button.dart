import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../components/error_icon_wrapper.dart';
import '../../data/secret_gen_river.dart';

class SecretFetchButton extends ConsumerWidget {
  const SecretFetchButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<String> taskValue = ref.watch(secretGenProvider);
    refresh() => ref.read(secretGenProvider.notifier).fetch();

    return IconButton(
      onPressed: taskValue.when(
        data: (_) => refresh,
        error: (_, __) => refresh,
        loading: () => null,
      ),
      icon: taskValue.when(
          data: (_) => const Icon(
                Icons.call_received,
                color: Colors.blue,
              ),
          error: (error, __) => ErrorIconWrapper(
                enable: SecretGen.op == OperationType.fetch,
                error: error.toString(),
                child: const Icon(Icons.call_received, color: Colors.blue),
              ),

          // SecretGen.op == OperationType.fetch
          //     ? const Icon(
          //         Icons.call_received,
          //         color: Colors.red,
          //       )
          //     : const Icon(
          //         Icons.call_received,
          //         color: Colors.blue,
          //       ),
          loading: () => SecretGen.op == OperationType.fetch
              ? const CupertinoActivityIndicator()
              : const Icon(Icons.call_received, color: Colors.grey)),
    );
  }
}
