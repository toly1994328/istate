import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'count_bloc.dart';

class SettingPage extends StatelessWidget {

  const SettingPage({Key? key}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('设置界面'),
      ),
      body: Container(
        height: 54,
        color: Colors.white,
        child: Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            BlocBuilder<CountBloc,CountState>(
              builder: _buildCounterByState,
            ),
            const Spacer(),
            ElevatedButton(
              child: const Text('重置'),
              onPressed: ()=>_onReset(context),
            ),
            const SizedBox(
              width: 10,
            )
          ],
        ),
      ),
    );
  }

  void _onReset(BuildContext context) {
    BlocProvider.of<CountBloc>(context).add(CountEvent.reset);
  }

  Widget _buildCounterByState(BuildContext context, CountState state) {
    return Text(
      '当前计数为: ${state.value}',
    );
  }
}
