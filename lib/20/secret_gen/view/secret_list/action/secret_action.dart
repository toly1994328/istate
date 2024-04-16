import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../river/secret_list/secret_list_river_op.dart';
import '../../../river/secret_list/state/secrets_state.dart';

/// 临时步骤，已被 [secret_op_action.dart] 优化处理
class SecretOpAction<T> extends ConsumerWidget {
  final String conformText;
  final ValueChanged<WidgetRef> onConform;
  final ValueChanged<String>? onListenError;
  final ValueChanged<Object?>? onListenSuccess;

  const SecretOpAction({
    super.key,
    required this.onConform,
    required this.conformText,
    required this.onListenError,
    required this.onListenSuccess,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (onListenError != null || onListenSuccess != null) {
      ref.listen(secretListOpProvider, (p, n) => _listenOpChange(context, p, n));
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

    Widget child = taskValue.when(
      data: (v) => _buildCommon(),
      error: (error, __) => _buildError(error.toString()),
      loading: () => _buildLoading(),
    );

    return TextButton(onPressed: action, child: child);
  }

  Widget _buildCommon() {
    return Text(conformText);
  }

  Widget _buildError(String msg) {
    Widget child = _buildCommon();
    if (SecretListOp.lastErrorOp is T) {
      const Icon error = Icon(Icons.error, color: Colors.red, size: 12);
      child = Tooltip(
        message: msg,
        child: Wrap(
          spacing: 2,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [child,error],
        ),
      );
    }
    return child;
  }

  Widget _buildLoading() {
    return const PopScope(
      canPop: false,
      child: CupertinoActivityIndicator(),
    );
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
