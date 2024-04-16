import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../river/secret_search/search_history.dart';

class ClearHistoryConformDialog extends StatelessWidget {
  const ClearHistoryConformDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _messageText(context, "是否确认清除所有搜索记录，清除后不可恢复"),
          DeleteActionButton(
            hasBorder: false,
            text: '确定',
            onTap: (ref) {
              ref.read(searchHistoryProvider.notifier).clearAllHistory();
              Navigator.of(context).pop();
            },
          ),
          Container(
              color: const Color(0xffE5E3E4).withOpacity(0.3), height: 10),
          buildCancel(context)
        ],
      ),
    );
  }

  Widget buildCancel(BuildContext context) {
    const TextStyle style = TextStyle(fontSize: 16, color: Colors.black);
    return InkWell(
      onTap: Navigator.of(context).maybePop,
      child: Ink(
        height: 50,
        color: Colors.white,
        child: const Center(
          child: Text('取消', style: style),
        ),
      ),
    );
  }

  Widget _messageText(BuildContext context, String? message) {
    double px1 = 1 / PlatformDispatcher.instance.views.first.devicePixelRatio;
    Color borderColor = Colors.grey.withOpacity(0.2);
    BorderSide px1Border = BorderSide(color: borderColor, width: px1);
    const TextStyle style = TextStyle(fontSize: 14, color: Colors.grey);
    return Container(
      alignment: Alignment.center,
      constraints: const BoxConstraints(maxHeight: 52),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(border: Border(bottom: px1Border)),
      child: Text('$message', style: style),
    );
  }
}

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
    return InkWell(
        onTap: () => onTap(ref),
        child: Ink(
          height: 52,
          decoration: BoxDecoration(
              color: Colors.white, border: Border(bottom: border)),
          child: Center(child: Text(text, style: style)),
        ));
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



  BorderSide get px1Border {
    double px1 = 1 / PlatformDispatcher.instance.views.first.devicePixelRatio;
    Color borderColor = Colors.grey.withOpacity(0.2);
    return BorderSide(color: borderColor, width: px1);
  }
}
