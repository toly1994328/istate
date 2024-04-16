import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../river/secret_list/secret_list_river_op.dart';
import '../../../river/secret_list/state/secrets_state.dart';

// sealed class TaskStatus{
//   const TaskStatus();
// }
//
// class TaskLoading extends TaskStatus{
//   const TaskLoading();
// }
//
// class TaskError extends TaskStatus{
//   const TaskError();
// }

typedef AsyncValueWidgetBuilder = Function(
  BuildContext context,
  AsyncValue<SecretListOpState?> asyncValue,
  VoidCallback? action,
);

class CustomOpAction<T> extends ConsumerWidget {
  final ValueChanged<WidgetRef> onConform;
  final AsyncValueWidgetBuilder builder;
  final ValueChanged<String>? onListenError;
  final ValueChanged<Object?>? onListenSuccess;

  const CustomOpAction({
    super.key,
    required this.onConform,
    required this.builder,
    required this.onListenError,
    required this.onListenSuccess,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (onListenError != null || onListenSuccess != null) {
      ref.listen(
          secretListOpProvider, (p, n) => _listenOpChange(context, p, n));
    }
    final taskValue = ref.watch(secretListOpProvider);

    void handle() {
      if (T is EditOp || T is AddOp) {
        _hideKeyboard(context);
      }
      onConform(ref);
    }

    VoidCallback? action = taskValue.when(
      data: (v) => handle,
      error: (error, __) => handle,
      loading: () => null,
    );
    return builder(context, taskValue, action);
  }

  void _hideKeyboard(BuildContext context) {
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
      onListenError?.call(next.error.toString());
      return;
    }

    if (previous?.value?.op is NoneOp && next.value?.op is T) {
      Object? data = next.value?.data;
      onListenSuccess?.call(data);
    }
  }
}
