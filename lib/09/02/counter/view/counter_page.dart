import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/counter_event.dart';
import '../../app/bloc/app_theme_bloc.dart';
import '../bloc/counter_bloc.dart';
import '../bloc/counter_state.dart';
import 'counter_tool_bar.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  Widget _buildSwitch(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Switch(
      value: isDark,
      inactiveTrackColor: Colors.white,
      trackOutlineColor: MaterialStateProperty.all(Colors.transparent),
      thumbIcon: MaterialStateProperty.all(
          isDark ? const Icon(Icons.dark_mode) : const Icon(Icons.light_mode)),
      onChanged: context.read<AppThemeBloc>().switchTheme,
    );
  }

  Widget _buildCounter() {
    return BlocBuilder<AppCounterBloc, CounterState>(
      buildWhen: (p, n) => p.counter != n.counter,
      builder: (ctx, state) {
        TextStyle? style  = Theme.of(ctx).textTheme.headlineMedium;
        return Text('${state.counter}', style: style);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        actions: [_buildSwitch(context)],
        title: const Text('计数器'),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(24),
          child: CounterToolBar(),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('下面是你点击按钮的次数:'),
            _buildCounter(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=>context.read<AppCounterBloc>().add(const IncreaseEvent()),
        tooltip: '增加',
        child: const Icon(Icons.add),
      ),
    );
  }
}
