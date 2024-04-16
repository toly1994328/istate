import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../manager/app_counter_model.dart';
import 'counter_step_dialog.dart';

class CounterToolBar extends StatelessWidget {
  const CounterToolBar({super.key});

  Widget _buildCounterStep() {
    return Selector<AppCountModel, int>(
      selector: (_, model) => model.step,
      builder: (ctx, int step, __) {
        return GestureDetector(
          onTap: () => _showStepDialog(ctx),
          child: Text(
            '步长 +$step',
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        );
      },
    );
  }

  void _showStepDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => const CounterStepDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    Color divColor = Theme.of(context).dividerTheme.color ?? Colors.black;
    double divSpace = Theme.of(context).dividerTheme.space ?? 1;
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    Color? bgColor = isDark ? Colors.black : const Color(0xffF2F2F2);

    const Widget vDiv = SizedBox(height: 24, child: VerticalDivider(width: 1));
    return DecoratedBox(
      decoration: BoxDecoration(
          color: bgColor,
          border: Border(bottom: BorderSide(color: divColor, width: divSpace))),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: _buildCounterStep(),
          ),
          vDiv,
          const ResetTopButton(),
          vDiv
        ],
      ),
    );
  }
}

class ResetTopButton extends StatelessWidget {
  const ResetTopButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: context.read<AppCountModel>().reset,
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Wrap(
          spacing: 2,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Icon(Icons.refresh,size: 16,color: Colors.grey),
            Text('重置',style: TextStyle(fontSize: 12, color: Colors.grey),),
          ],
        ),
      ),
    );
  }
}
