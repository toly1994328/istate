import 'package:get/get.dart';

class CounterCtrl extends GetxController {
  int count = 0;

  void increment() {
    count++;
    update();
  }
}

