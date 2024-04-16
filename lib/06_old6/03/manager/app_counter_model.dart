import 'package:flutter/material.dart';

class AppCountModel with ChangeNotifier {
  int _counter = 0;
  int _step = 1;

  int get counter => _counter;

  int get step => _step;

  void increment() {
    _counter += _step;
    notifyListeners();
  }

  void reset() {
    _counter = 0;
    notifyListeners();
  }

  set step(int value) {
    _step = value;
    notifyListeners();
  }
}
