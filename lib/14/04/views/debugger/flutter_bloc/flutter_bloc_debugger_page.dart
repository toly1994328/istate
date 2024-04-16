import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'animation_test_item.dart';
import 'bloc_link_test_item.dart';
import 'counter_listen_test_item.dart';
import 'counter_test_item.dart';
import 'stream_test_item.dart';

class FlutterBlocDebuggerPage extends StatelessWidget {
  const FlutterBlocDebuggerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('flutter_bloc 功能测试'),
        // backgroundColor: Colors.white,
      ),
      body: ListView(
        children: <Widget>[
          const SizedBox(height: 15),
          BlocProvider<CountBloc>(
            create: (_) => CountBloc(),
            child: const CounterTestItem(),
          ),
          const Divider(),
          const AnimationBlocWrapper(
            child: AnimationTestItem(),
          ),
          const Divider(),
          BlocProvider<StreamTestBloc>(
            create: (_) =>
                StreamTestBloc(SignalStream().createStream(count: 1000)),
            child: const StreamTestItem(),
          ),
          const SizedBox(height: 8),
          BlocProvider<CountBloc>(
            create: (_) => CountBloc(),
            child: const CounterListenerTestItem(),
          ),
          const Divider(),
          MultiBlocProvider(providers: [
            BlocProvider<CountBloc>(
              create: (_) => CountBloc(),
            ),
            BlocProvider<ColorBloc>(
              create: (_) => ColorBloc(),
            ),
          ], child: const BlocLinkTestItem())

        ],
      ),
    );
  }
}
