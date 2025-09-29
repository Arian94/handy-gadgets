import 'package:flutter/material.dart';

class TriangleBorder extends OutlinedBorder {
  const TriangleBorder({super.side});

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    final curve = 4.0; // Very small curve for all vertices
    final bottom = Offset(rect.width / 2, rect.height);
    final left = Offset(0, 0);
    final right = Offset(rect.width, 0);

    final path = Path();
    // Start at bottom vertex (point)
    path.moveTo(bottom.dx - curve, bottom.dy - curve);
    path.quadraticBezierTo(
      bottom.dx,
      bottom.dy,
      bottom.dx + curve,
      bottom.dy - curve,
    );
    // Right side (top right corner)
    path.lineTo(right.dx - curve, right.dy + curve);
    path.quadraticBezierTo(right.dx, right.dy, right.dx - curve, right.dy);
    // Left side (top left corner)
    path.lineTo(left.dx + curve, left.dy);
    path.quadraticBezierTo(left.dx, left.dy, left.dx + curve, left.dy + curve);
    // Back to bottom
    path.lineTo(bottom.dx - curve, bottom.dy - curve);
    path.close();
    return path;
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    if (side == BorderSide.none || side.width == 0) return;
    final path = getOuterPath(rect, textDirection: textDirection);
    canvas.drawPath(path, side.toPaint());
  }

  @override
  ShapeBorder scale(double t) => TriangleBorder(side: side.scale(t));

  @override
  OutlinedBorder copyWith({BorderSide? side}) {
    return TriangleBorder(side: side ?? this.side);
  }

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    // The inner path is a slightly smaller triangle inside the outer triangle
    // We'll inset the triangle by a fixed amount (e.g., 4.0 pixels)
    const inset = 4.0;
    final width = rect.width - 2 * inset;
    final height = rect.height - 2 * inset;
    final innerRect = Rect.fromLTWH(
      rect.left + inset,
      rect.top + inset,
      width,
      height,
    );

    return Path()
      ..moveTo(innerRect.left + innerRect.width / 2, innerRect.top)
      ..lineTo(innerRect.right, innerRect.bottom)
      ..lineTo(innerRect.left, innerRect.bottom)
      ..close();
  }
}
