import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:istate/utils/toast.dart';

import '../../../data/model/secret.dart';
import '../../../river/river.dart';
import '../action/custom_secret_op_action.dart';
import '../action/secret_delete_action.dart';

class DeleteConformDialog extends StatelessWidget {
  final DeleteOp op;

  const DeleteConformDialog({super.key, required this.op});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _messageText(context, "是否确认删除领域，删除后不可恢复"),
          DeleteActionButton(
            hasBorder: false,
            text: '确定',
            onTap: (ref) {
              ref.read(secretListOpProvider.notifier).delete(op);
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
