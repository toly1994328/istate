
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StreamTestBloc extends Cubit<SignalState> {
  final Stream<SignalState> _stream;
  StreamSubscription<SignalState>?  _subscription;
  StreamTestBloc(this._stream) : super(SignalState(counter: 10, type: SignalType.denial)) {
    _subscription = _stream.listen(_onChange);
  }

  void _onChange(SignalState state) {
    emit(state);
  }

  @override
  Future<void> close() {
    print("::close::");
    _subscription?.cancel();
    return super.close();
  }
}

const int _kAllowMaxCount = 10;
const int _kWaitMaxCount = 3;
const int _kDenialMaxCount = 10;

class SignalState {
  final int counter;
  final SignalType type;

  SignalState({
    required this.counter,
    required this.type,
  });

  SignalState next() {
    if (counter > 1) {
      return SignalState(type: type, counter: counter - 1);
    } else {
      switch (type) {
        case SignalType.allow:
          return SignalState(type: SignalType.denial, counter: _kDenialMaxCount);
        case SignalType.denial:
          return SignalState(type: SignalType.wait, counter: _kWaitMaxCount);
        case SignalType.wait:
          return SignalState(type: SignalType.allow, counter: _kAllowMaxCount);
      }
    }
  }
}

enum SignalType {
  allow, // 允许 - 绿灯
  denial, // 拒绝 - 红灯
  wait, // 等待 - 黄灯
}

class SignalStream{
  SignalState _signalState = SignalState(counter: 10, type: SignalType.denial);

  Stream<SignalState> createStream({int count = 100}) async*{
    for(int i = 0 ; i < count; i++){
      await Future.delayed(const Duration(seconds: 1));
      _signalState = _signalState.next();
      yield _signalState;
    }
  }
}


class StreamTestItem extends StatelessWidget {
  const StreamTestItem({super.key});

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    const TextStyle subStyle = TextStyle(fontSize: 12, color: Colors.grey);
    const TextStyle titleStyle = TextStyle(fontSize: 16);
    return ListTile(
        leading: Icon(Icons.transfer_within_a_station, color: primaryColor),
        title: const Text('Stream 测试', style: titleStyle),
        subtitle: const Text('红绿灯信号流不断变化', style: subStyle),
        trailing: BlocBuilder<StreamTestBloc,SignalState>(
          builder: (ctx, SignalState state){
            return SignalLamp(
              state: state,
              size: 70,
            );
          },
        )
    );
  }
}

class SignalLampBox extends StatelessWidget {
  const SignalLampBox ({super.key});

  @override
  Widget build(BuildContext context) {
    SignalState state = context.watch<SignalState>();
    return SignalLamp(
      state: state,
      size: 70,
    );
  }
}


class SignalLamp extends StatelessWidget {
  final SignalState state;
  final double size;

  const SignalLamp({Key? key, required this.state, required this.size}) : super(key: key);

  Color get activeColor {
    switch (state.type) {
      case SignalType.allow:
        return Colors.green;
      case SignalType.denial:
        return Colors.red;
      case SignalType.wait:
        return Colors.amber;
    }
  }

  @override
  Widget build(BuildContext context) {
    double ph = size/8;
    double pv = size/12;
    double radius = (size-ph*2)/3;
    return Column(
      children: [
        Container(
          padding:  EdgeInsets.symmetric(horizontal: ph, vertical: pv),
          decoration: BoxDecoration(
            color: Colors.black, borderRadius: BorderRadius.circular(16),),
          child: Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: ph,
            children: [
              Lamp(color: state.type == SignalType.denial ? activeColor : null,size: radius,),
              Lamp(color: state.type == SignalType.wait ? activeColor : null,size: radius),
              Lamp(color: state.type == SignalType.allow ? activeColor : null,size: radius),
            ],
          ),
        ),
        Text(
          state.counter.toString(),
          style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: size/4, color: activeColor,
          ),
        )
      ],
    );
  }
}

class Lamp extends StatelessWidget {
  final Color? color;
  final double size;

  const Lamp({Key? key, required this.color, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color ?? Colors.grey.withOpacity(0.8),
        shape: BoxShape.circle,
      ),
    );
  }
}
