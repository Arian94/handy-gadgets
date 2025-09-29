import 'package:flutter/material.dart';

/// A CustomPainter class to draw a triangle with a gradient stroke and transparent fill.
class TrianglePainter extends CustomPainter {
  static final _gradient = LinearGradient(
    colors: [Colors.blue.shade200, Colors.blue.shade400, Colors.blue.shade500],
    // The gradient runs from top-center to bottom-center of the bounding box
    begin: Alignment.topRight,
    end: Alignment.bottomCenter,
  );

  @override
  void paint(Canvas canvas, Size size) {
    // 1. Define the path (the shape of the triangle)
    final path = Path();

    path.lineTo(size.width, 0);
    path.lineTo(size.width / 2, size.height);

    // path.moveTo(size.width / 2, 0);
    // path.lineTo(size.width, size.height);
    // path.lineTo(0, size.height);

    // Close the path back to the starting point
    path.close();

    // 2. Create the Paint object for the border style
    final Paint paint = Paint()
      // Crucial: Use PaintingStyle.stroke to ensure the interior is transparent
      ..style = PaintingStyle.stroke
      // Define the thickness of the border
      ..strokeWidth = 6.0
      // 3. Apply the gradient using createShader
      ..shader = _gradient.createShader(
        // The shader needs the full bounds of the CustomPaint area
        Rect.fromLTWH(0, 0, size.width, size.height),
      )
      // Optional: smooth the corners
      ..strokeJoin = StrokeJoin.round;

    // 4. Draw the path with the gradient stroke
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // No need to repaint as the style and shape are static
    return false;
  }
}
