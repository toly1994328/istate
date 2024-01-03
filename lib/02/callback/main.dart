

void main() {
  SmsSystem smsSystem = SmsSystem();
  DiskManager manager = DiskManager(1024,callback: (String msg){
    smsSystem.sendSms('18715079377', msg);
  });
  manager.use(100);
  manager.use(200);
  manager.use(300);
  manager.use(250);
}



class SmsSystem{
  void sendSms(String phone,String message){
    print('向 ${phone} 发送： $message');
  }
}

typedef DiskNotifyCallback = void Function(String message);

class DiskManager {
  int total;
  final double notifyThreshold;
  final DiskNotifyCallback? callback;

  DiskManager(
    this.total, {
    this.notifyThreshold = 0.8,
    this.callback,
  });

  /// 用量
  int _usage = 0;

  void use(int size) {
    _usage += size;
    if(_usage>total*notifyThreshold){
      /// 通知监听
      String message = '[磁盘警告]: 磁盘容量已超过:${(notifyThreshold*100).toStringAsFixed(1)}% [用量: $_usage/$total]';
      callback?.call(message);
    }
  }
}


