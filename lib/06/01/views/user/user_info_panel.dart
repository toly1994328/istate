import 'package:flutter/material.dart';

class UserInfoPanel extends StatelessWidget {
  const UserInfoPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundImage: AssetImage('assets/images/icon_head.webp'),
        ),
        SizedBox(
          width: 18,
        ),
        Wrap(
          direction: Axis.vertical,
          children: [
            Text(
              '张风捷特烈',
              style:
              TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text('万花过尽知无物@编程之王',style: TextStyle(color: Colors.grey),),
          ],
        )
      ],
    );
  }
}
