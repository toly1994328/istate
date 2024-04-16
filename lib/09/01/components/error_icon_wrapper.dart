import 'package:flutter/material.dart';

class ErrorIconWrapper extends StatelessWidget {
  final Widget child;
  final bool enable;
  final String error;

  const ErrorIconWrapper({
    super.key,
    required this.child,
    required this.enable,
    required this.error,
  });

  @override
  Widget build(BuildContext context) {
    if (!enable) return child;

    return Tooltip(
      message: error,
      child: Badge(
        alignment: Alignment.bottomRight,
        offset: const Offset(4, 0),
        backgroundColor: Colors.transparent,
        label: const Icon(Icons.error, color: Colors.red, size: 14),
        child: child,
      ),
    );
  }
}
