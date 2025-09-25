import 'dart:math';

import 'package:flutter/material.dart';

class CircularFlowDelegate extends FlowDelegate {
  final double radius;

  CircularFlowDelegate({this.radius = 100});

  @override
  void paintChildren(FlowPaintingContext context) {
    final count = context.childCount;
    final centerX = context.size.width / 2;
    final centerY = context.size.height / 2;
    final angleStep = 2 * pi / count;
    final startAngle = -pi / 2; // Start at left

    for (int i = 0; i < count; i++) {
      final angle = startAngle + i * angleStep;
      final x =
          centerX + radius * cos(angle) - context.getChildSize(i)!.width / 2;
      final y =
          centerY + radius * sin(angle) - context.getChildSize(i)!.height / 2;
      context.paintChild(i, transform: Matrix4.translationValues(x, y, 0));
    }
  }

  @override
  bool shouldRepaint(CircularFlowDelegate oldDelegate) =>
      radius != oldDelegate.radius;
}
