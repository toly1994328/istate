import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../secret_gen/data/storage/db_storage/app_db_storage.dart';
import 'state.dart';

class AppStartBloc extends Cubit<AppStatus> {
  late SharedPreferences _sp;
  SharedPreferences get sp =>_sp;

  final int minStartDurationMs;

  AppStartBloc({
    this.minStartDurationMs = 20,
  }) : super(const AppStarting());

  int _timeRecord = 0;

  void startApp() async {
    _timeRecord = DateTime.now().millisecondsSinceEpoch;
    emit(const AppStarting());

    try {
      /// 处理初始化异步任务
      _sp = await SharedPreferences.getInstance();
      await AppDbStorage.instance.initDb();

      // throw '这是一段在初始化时错误的错误异常';
    } catch (e) {
      emit(AppStartFailed(e.toString()));
      return;
    }
    /// 计算初始化的耗时时长
    int cost = DateTime.now().millisecondsSinceEpoch - _timeRecord;
    int waitTime = minStartDurationMs - cost;
    if (waitTime > 0) {
      /// 说明启动时间小于 [minStartDurationMs], 等待时间差
      emit(AppLoadDone(cost));
      await Future.delayed(Duration(milliseconds: waitTime));
    }else{
      /// 说明启动时间超过 [minStartDurationMs],给一点预加载的时间
      emit(AppLoadDone(cost));
      await Future.delayed(const Duration(milliseconds: 50));
    }
    emit(const AppStartSuccess());
  }
}

