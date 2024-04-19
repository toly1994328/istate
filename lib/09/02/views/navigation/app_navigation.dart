import 'package:flutter/material.dart';
import '../../counter/view/counter_page.dart';
import '../user/user_page.dart';

class AppNavigation extends StatefulWidget {
  const AppNavigation({super.key});

  @override
  State<AppNavigation> createState() => _AppNavigationState();
}

class _AppNavigationState extends State<AppNavigation> {
  final PageController _ctrl = PageController();
  int _activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        currentIndex: _activeIndex,
        onTap: _onSelectItem,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.plus_one), label: '计数器'),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: '我的'),
        ],
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _ctrl,
        children: const [
          CounterPage(),
          UserPage(),
        ],
      ),
    );
  }

  void _onSelectItem(int value) {
    setState(() {
      _activeIndex = value;
    });
    _ctrl.jumpToPage(value);
  }
}
