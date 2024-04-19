import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CountBloc extends Cubit<int>{
  CountBloc():super(0);

  void increment(){
    // if(state==6){
    //   addError("error");
    //   return;
    // }
    emit(state+1);
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    debugPrint('::onError::$error,$stackTrace',);
    super.onError(error, stackTrace);
  }

  @override
  void onChange(Change<int> change) {
    debugPrint("::onChange::(cur:${change.currentState},next:${change.nextState})");
    super.onChange(change);
  }

  @override
  Future<void> close() {
    debugPrint("::close::");
    return super.close();
  }
}


class CounterTestItem extends StatelessWidget {
  const CounterTestItem({super.key});

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    const TextStyle subStyle = TextStyle(fontSize: 12, color: Colors.grey);
    const TextStyle titleStyle = TextStyle(fontSize: 16);
    return ListTile(
      leading: Icon(Icons.transfer_within_a_station, color: primaryColor),
      title: const Text('计算器测试', style: titleStyle),
      subtitle: const Text('点击计数器增加', style: subStyle),
      trailing:  const CounterBox(),
      onTap: context.read<CountBloc>().increment,
    );
  }
}

class CounterBox extends StatelessWidget {
  const CounterBox({super.key});

  @override
  Widget build(BuildContext context) {
    int counter = context.watch<CountBloc>().state;
    const TextStyle style = TextStyle(color: Colors.white);

    BorderRadius radius = BorderRadius.circular(4);
    return Container(
      width: 36,
      height: 36,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: Colors.blue, borderRadius:radius ),
      child: Text('$counter', style: style),
    );
  }
}
