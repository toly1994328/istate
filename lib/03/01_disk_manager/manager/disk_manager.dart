import 'package:flutter/material.dart';

enum NotifyStatus {
  log, // 记录磁盘的使用
  threshold, // 磁盘达到阈值，无法使用
  full, // 磁盘已满，无法使用
}


class DiskEventMessage with ChangeNotifier {
  String _msg = '';
  NotifyStatus _status = NotifyStatus.log;

  String get msg => _msg;
  NotifyStatus get status => _status;

  void change(NotifyStatus status, String msg) {
    _msg = msg;
    _status = status;
    notifyListeners();
  }
}


class DiskManager{
  int total;
  final double notifyThreshold;
  final DiskEventMessage notify;

  DiskManager(
    this.total, {
    this.notifyThreshold = 0.8,
    required this.notify,
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
      notify.change(NotifyStatus.full, message);
      return;
    }
    _usage += size;
    String message = '[磁盘使用]:$size , [用量: $_usage/$total]';
    notify.change(NotifyStatus.log, message);
    if (_usage > total * notifyThreshold) {
      String message = '[磁盘警告]: 磁盘容量已超过:${(notifyThreshold * 100).toStringAsFixed(1)}% [用量: $_usage/$total]';
      notify.change(NotifyStatus.threshold, message);
    }
  }
}
