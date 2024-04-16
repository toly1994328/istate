import 'dart:async';

enum Status {
  none,
  loading,
  error,
}

class CounterLogic {
  int _state = 0;
  Status _status = Status.none;

  int get state => _state;

  Status get status => _status;

  final StreamController<Status> _statusCtrl = StreamController();

  Stream<Status> get stream => _statusCtrl.stream;

  void emit() async {
    _status = Status.loading;
    _statusCtrl.add(_status);
    try {
      _state = await doAsyncTask();
      _status = Status.none;
      _statusCtrl.add(_status);
    } catch (e) {
      _status = Status.error;
      _statusCtrl.add(_status);
    }
  }

  Future<int> doAsyncTask() async{
    await Future.delayed(const Duration(seconds: 3));
    // throw "测试异常情况";
    return state+1;
  }

  void close() {
    _statusCtrl.close();
  }
}
