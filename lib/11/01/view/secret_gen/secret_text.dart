import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/secret_gen_river.dart';

class SecretText extends ConsumerWidget {
  const SecretText({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {


    return ref.watch(secretGenProvider).when(
        skipLoadingOnReload: true,
        data: (String value) => Text(value,
                style: Theme.of(context).textTheme.headlineMedium),
        error: (e, _) =>
            Text(e.toString(), style: const TextStyle(color: Colors.red)),
        loading: () => _loadingWidget());
  }

  Widget _loadingWidget() {
    return const Padding(
        padding: EdgeInsets.all(8.0), child: CupertinoActivityIndicator());
  }
}
