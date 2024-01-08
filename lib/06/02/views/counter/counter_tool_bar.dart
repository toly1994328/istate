import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../manager/app_counter_bloc.dart';
import 'counter_step_dialog.dart';

class CounterToolBar extends StatelessWidget {
  const CounterToolBar({super.key});

  Widget _buildCounterStep(BuildContext context) {
    const TextStyle style =  TextStyle(fontSize: 12, color: Colors.grey);
    return GestureDetector(
      onTap: () => _showStepDialog(context),
      child: BlocBuilder<AppCounterBloc, CounterState>(
        buildWhen: (p, n) => p.step != n.step,
        builder: (ctx, state) {
          return Text('步长 +${state.step}', style: style);
        },
      ),
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
            child: _buildCounterStep(context),
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
      onTap: context.read<AppCounterBloc>().reset,
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
