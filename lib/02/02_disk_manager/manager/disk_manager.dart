enum NotifyStatus {
  log, // 记录磁盘的使用
  threshold, // 磁盘达到阈值，无法使用
  full, // 磁盘已满，无法使用
}

typedef DiskNotifyCallback = void Function(NotifyStatus status, String message);

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

  int get usage => _usage;

  void reset(){
    _usage = 0;
  }

  void use(int size) {
    if (total - _usage < size) {
      String message = '[磁盘警告]: 磁盘已满,无法使用。 [用量: $_usage/$total]';
      callback?.call(NotifyStatus.full, message);
      return;
    }
    _usage += size;
    String message = '[磁盘使用]:$size , [用量: $_usage/$total]';
    callback?.call(NotifyStatus.log, message);
    if (_usage > total * notifyThreshold) {
      String message = '[磁盘警告]: 磁盘容量已超过:${(notifyThreshold * 100).toStringAsFixed(1)}% [用量: $_usage/$total]';
      callback?.call(NotifyStatus.threshold, message);
    }
  }
}
