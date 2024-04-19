import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../manager/app_counter_model.dart';
import 'counter_step_dialog.dart';

class CounterToolBar extends StatelessWidget {
  const CounterToolBar({super.key});

  Widget _buildCounterStep() {
    return Consumer<AppCountModel>(
      builder: (ctx, AppCountModel model, __) {
        debugPrint("======_buildCounterStep:${model.step}==========");
        return GestureDetector(
          onTap: ()=>_showStepDialog(ctx),
          child: Text(
            '步长 +${model.step}',
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        );
      },
    );
  }

  void _showStepDialog(BuildContext context){
    showModalBottomSheet(
      context: context,
      builder: (_) => const CounterStepDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    Color divColor = Theme.of(context).dividerTheme.color??Colors.black;
    double divSpace = Theme.of(context).dividerTheme.space ?? 1;
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    Color? bgColor =  isDark?Colors.black:const Color(0xffF2F2F2);

    return DecoratedBox(
      decoration: BoxDecoration(
          color: bgColor,
          border: Border(bottom: BorderSide(color: divColor, width: divSpace))
      ),
      child: Row(
        children: [
          Padding(
            padding:
            const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: _buildCounterStep(),
          ),
          const SizedBox(height: 24, child: VerticalDivider(width: 1))
        ],
      ),
    );
  }
}