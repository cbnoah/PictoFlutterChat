import 'package:flutter/material.dart';

class HorizontalLinesBackgroundPainter extends CustomPainter {
  final double spacing;
  final double lineWidth;
  final Color lineColor;

  HorizontalLinesBackgroundPainter({
    this.spacing = 24,
    this.lineWidth = 1,
    this.lineColor = Colors.white,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = lineColor
      ..strokeWidth = lineWidth;

    double y = 0;
    while (y <= size.height) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
      y += spacing;
    }
  }

  @override
  bool shouldRepaint(covariant HorizontalLinesBackgroundPainter oldDelegate) {
    return oldDelegate.spacing != spacing ||
        oldDelegate.lineWidth != lineWidth ||
        oldDelegate.lineColor != lineColor;
  }
}
