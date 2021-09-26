import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedVoice extends StatefulWidget {
  const AnimatedVoice({Key? key}) : super(key: key);

  @override
  _AnimatedVoiceState createState() => _AnimatedVoiceState();
}

class _AnimatedVoiceState extends State<AnimatedVoice> {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: VoicePainter(),
      size: const Size(100, 100),
    );
  }
}

class VoicePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
        Offset.zero & size, Paint()..color = Colors.black.withAlpha(11));
    canvas.translate(size.width / 2, size.height);
    double bottomLen = 12;
    double strokeWidth = 4;
    double centerHeight = 8;
    double radius = 16;
    // canvas.drawCircle(Offset.zero, 10 , Paint());
    // Path path = Path();
    // path
    //   ..relativeLineTo(36, 0)
    //   ..relativeArcToPoint(Offset(0, -6),
    //       radius: Radius.circular(3), clockwise: false)
    //   ..relativeLineTo(-30, 0)
    // ..relativeLineTo(0, -10)
    // ;
    Paint paint = Paint()..strokeWidth=strokeWidth..strokeCap=StrokeCap.round..color=Colors.grey..style=PaintingStyle.stroke;
    canvas.translate(0, -paint.strokeWidth/2);
    canvas.drawLine(Offset(-bottomLen, 0), Offset(bottomLen, 0),paint) ;
    canvas.drawLine(Offset.zero, Offset(0, -centerHeight),paint) ;
    canvas.drawArc(Rect.fromCenter(center: Offset(0,-centerHeight-radius), width: radius*2, height: radius*2), 0, pi, false, paint);
    canvas.drawRRect(RRect.fromRectXY(Rect.fromCenter(center:Offset(0,-centerHeight-radius-10), width: 18, height: 40  ), 9, 9), paint);

    // canvas.drawPath(path, Paint()..style = PaintingStyle.stroke);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
