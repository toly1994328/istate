import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:istate/utils/toast.dart';

import '../../../data/model/secret.dart';
import '../../../river/river.dart';
import 'custom_secret_op_action.dart';

class DeleteActionButton extends ConsumerWidget {
  final bool hasBorder;
  final ValueChanged<WidgetRef> onTap;
  final String text;

  const DeleteActionButton({
    super.key,
    required this.hasBorder,
    required this.onTap,
    required this.text,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    BorderSide border = hasBorder ? px1Border : BorderSide.none;
    const TextStyle style = TextStyle(fontSize: 16, color: Colors.redAccent);
    BoxDecoration d = BoxDecoration(color: Colors.white, border: Border(bottom: border));
    return CustomOpAction<DeleteOp>(
      onConform: onTap,
      builder: (_, value, action) {
        Widget? child = value.when(
          data: (_) => Text(text, style: style),
          error: (e, __) => _buildError(e.toString()),
          loading: () => _buildLoading(),
        );
        return InkWell(
            onTap: action,
            child: Ink(height: 52, decoration: d, child: Center(child: child)));
      },
      onListenError: context.error,
      onListenSuccess: (Object? secret) {
        if (secret is Secret) {
          Navigator.of(context).pop();
          context.success("删除[${secret.title}] 成功!");
        }
      },
    );
  }

  Widget _buildError(String error) {
    const TextStyle style = TextStyle(fontSize: 16, color: Colors.redAccent);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text("点击重试", style: style),
            Icon(
              Icons.refresh,
              color: Colors.redAccent,
              size: 16,
            )
          ],
        ),
        Text(error, style: style.copyWith(fontSize: 12)),
      ],
    );
  }

  Widget _buildLoading() {
    const TextStyle loadingStyle = TextStyle(fontSize: 16, color: Colors.grey);
    return PopScope(
      canPop: false,
      child: Wrap(
        spacing: 6,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text(text, style: loadingStyle),
          const CupertinoActivityIndicator(radius: 6)
        ],
      ),
    );
  }

  BorderSide get px1Border {
    double px1 = 1 / PlatformDispatcher.instance.views.first.devicePixelRatio;
    Color borderColor = Colors.grey.withOpacity(0.2);
    return BorderSide(color: borderColor, width: px1);
  }
}
