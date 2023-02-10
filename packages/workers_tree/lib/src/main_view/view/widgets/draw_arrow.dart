import 'dart:math';

import 'package:flutter/material.dart';

class ArrowPainter extends CustomPainter {
  final Offset p1;
  final Offset p2;
  final Color color;

  const ArrowPainter({required this.p1,required this.p2, this.color = Colors.black});
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2;
    final dX = p2.dx - p1.dx;
    final dY = p2.dy - p1.dy;
    final angle = atan2(dY, dX);
    const arrowSize = 15;
    const arrowAngle = 25 * pi / 180;
    final path = Path()
      ..moveTo(
        p2.dx - arrowSize * cos(angle - arrowAngle),
        p2.dy - arrowSize * sin(angle - arrowAngle),
      )
      ..lineTo(p2.dx, p2.dy)
      ..lineTo(
        p2.dx - arrowSize * cos(angle + arrowAngle),
        p2.dy - arrowSize * sin(angle + arrowAngle),
      )
      ..close();
    canvas
      ..drawPath(path, paint)
      ..drawLine(p1, p2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
