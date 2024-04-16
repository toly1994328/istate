import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'state.dart';

part 'app_start.g.dart';

@riverpod
class AppStart extends _$AppStart {
  AppStart({
    this.minStartDurationMs = 200,
  }) {
    startApp();
  }

  @override
  AppStatus build() => const AppStarting();

  late SharedPreferences _sp;

  SharedPreferences get sp => _sp;

  final int minStartDurationMs;

  int _timeRecord = 0;

  void startApp() async {
    _timeRecord = DateTime.now().millisecondsSinceEpoch;

    try {
      /// 处理初始化异步任务
      _sp = await SharedPreferences.getInstance();
      // throw '这是一段在初始化时错误的错误异常';
    } catch (e) {
      state = AppStartFailed(e.toString());
      return;
    }

    /// 计算初始化的耗时时长
    int cost = DateTime.now().millisecondsSinceEpoch - _timeRecord;
    int waitTime = minStartDurationMs - cost;
    if (waitTime > 0) {
      /// 说明启动时间小于 [minStartDurationMs], 等待时间差
      state = AppLoadDone(cost);
      await Future.delayed(Duration(milliseconds: waitTime));
    } else {
      /// 说明启动时间超过 [minStartDurationMs],给一点预加载的时间
      state = AppLoadDone(cost);
      await Future.delayed(const Duration(milliseconds: 50));
    }
    state = const AppStartSuccess();
  }
}
