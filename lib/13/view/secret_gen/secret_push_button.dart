import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:istate/utils/toast.dart';
import '../../components/error_icon_wrapper.dart';
import '../../river/river.dart';
import '../../data/data.dart';

class SecretPushButton extends ConsumerWidget {
  const SecretPushButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(secretListOpProvider, (p, n) => _listenOpChange(context, p, n));
    AsyncValue<SecretListOpState> taskValue = ref.watch(secretListOpProvider);
    String? newSecret = ref.watch(secretGenProvider).value;
    SecretsState? state = ref.read(secretListProvider).value;

    String? oldSecret = state?.activeSecret?.secret;
    String? activeTitle = state?.activeSecret?.title;

    void push() {
      if (newSecret == oldSecret) {
        context.warning('当前领域秘钥未修改，无需提交');
        return;
      }
      if (activeTitle == null || newSecret == null) return;
      ref.read(secretListOpProvider.notifier).pushSecret(PushOp(newSecret));
    }

    return IconButton(
      onPressed: taskValue.when(
        data: (_) => push,
        error: (_, __) => push,
        loading: () => null,
      ),
      icon: taskValue.when(
          data: (_) => _buildSuccessIcon(oldSecret, newSecret),
          error: (error, __) => _buildError(error.toString()),
          loading: () => _buildLoading(newSecret)),
    );
  }

  Widget _buildSuccessIcon(String? oldSecret, String? newSecret) {
    return Badge(
      isLabelVisible: oldSecret != newSecret,
      alignment: Alignment.bottomRight,
      child: Icon(
        Icons.call_made,
        color: newSecret == null ? Colors.grey : const Color(0xff59a869),
      ),
    );
  }

  Widget _buildError(String error) {
    return ErrorIconWrapper(
      enable: SecretListOp.lastErrorOp is PushOp,
      error: error,
      child: const Icon(Icons.call_made, color: Color(0xff59a869)),
    );
  }

  Widget _buildLoading(String? newSecret) {
    return newSecret != null
        ? const CupertinoActivityIndicator()
        : const Icon(Icons.call_received, color: Colors.grey);
  }

  void _listenOpChange(
    BuildContext context,
    AsyncValue<SecretListOpState?>? previous,
    AsyncValue<SecretListOpState?> next,
  ) {
    if ((previous?.isLoading ?? true) && next.hasError) {
      /// 发生异常
      context.error("提交失败!\n${next.error.toString()}");
      return;
    }

    if (previous?.value?.op is NoneOp && next.value?.op is PushOp) {
      /// 添加成功
      Object? secret = next.value?.data;
      if (secret is Secret) {
        context.success("提交成功!");
      }
    }
  }
}
