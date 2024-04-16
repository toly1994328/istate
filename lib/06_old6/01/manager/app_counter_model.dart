import 'package:flutter/material.dart';

class AppCountModel with ChangeNotifier{
  int _counter =0;
  int get counter => _counter;

  void increment(){
    _counter++;
    notifyListeners();
  }

  void reset() {
    _counter=0;
    notifyListeners();
  }
}
