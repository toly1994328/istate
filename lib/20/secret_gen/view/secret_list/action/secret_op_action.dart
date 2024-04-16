import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../river/secret_list/secret_list_river_op.dart';
import '../../../river/secret_list/state/secrets_state.dart';
import 'custom_secret_op_action.dart';

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
    return CustomOpAction<T>(
      onConform: onConform,
      builder: (_, AsyncValue<SecretListOpState?> asyncValue, VoidCallback? action) {
        Widget child = asyncValue.when(
          data: (v) => _buildCommon(),
          error: (error, __) => _buildError(error.toString()),
          loading: () => _buildLoading(),
        );
        return TextButton(onPressed: action, child: child);
      },
      onListenError: onListenError,
      onListenSuccess: onListenSuccess,
    );
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
          children: [child, error],
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
}
