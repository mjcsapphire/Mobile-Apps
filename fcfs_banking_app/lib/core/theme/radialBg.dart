import 'package:flutter/material.dart';

class GradientBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    // Define gradient colors
    const bgColor1 = Color(0xFF51121E); // Top-center-right
    const bgColor2 = Color(0xFF92430C); // Center
    const bgColor4 = Color(0xFFA4325E); // Bottom-right

    // Linear Gradient with stops
    const gradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        bgColor1,
        bgColor2,
        bgColor4,
      ],
      stops: [0.0, 0.3, 0.7],
    );

    paint.shader = gradient.createShader(
      Rect.fromLTWH(0, 5, size.width, size.height),
    );

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class DarkGradientBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    // Define gradient colors
    const bgColor1 = Color(0xFF020819);
    const bgColor2 = Color(0xFF20245c);
    const bgColor4 = Color(0xFF2e0055);

    // Linear Gradient with stops
    const gradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        bgColor1,
        bgColor2,
        bgColor4,
        bgColor1,
      ],
      stops: [0.0, 0.4, 0.7, 1],
    );

    paint.shader = gradient.createShader(
      Rect.fromLTWH(0, 5, size.width, size.height),
    );

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
