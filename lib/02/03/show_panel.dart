import 'package:flutter/material.dart';

class ShowPanel extends StatelessWidget {
  final String desc;
  final String value;

  const ShowPanel({super.key, required this.desc, required this.value});

  @override
  Widget build(BuildContext context) {
    const TextStyle valueStyle = TextStyle(fontSize: 28);
    const TextStyle descStyle = TextStyle(color: Colors.grey);
    return Column(
      children: [
        Text(desc, style: descStyle),
        Text(value, style: valueStyle),
      ],
    );
  }
}

// class ShowPanelPlus extends StatelessWidget {
//   final String desc;
//   final String value;
//
//   const ShowPanelPlus({
//     super.key,
//     required this.desc,
//     required this.value,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     const TextStyle valueStyle = TextStyle(fontSize: 28, shadows: [
//       Shadow(
//           color: Colors.purpleAccent,
//           offset: Offset(0.5, 0.5),
//           blurRadius: 1
//       )
//     ]);
//     const TextStyle descStyle = TextStyle(color: Colors.grey);
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: DecoratedBox(
//         decoration: BoxDecoration(
//           color: Color(0xffe7ffff),
//           // border: Border.all(),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.lightBlueAccent.withOpacity(0.2),
//                 blurRadius: 4,
//                 offset: Offset(2,2)
//               ),
//               BoxShadow(
//                   color: Colors.purple.withOpacity(0.2),
//                   blurRadius: 2,
//                   offset: Offset(1,1)
//               )
//             ],
//           borderRadius: BorderRadius.circular(8)
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(desc,style: descStyle,),
//               Text(value, style: valueStyle),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
