import 'package:flutter/material.dart';

class DiagonalTriangle extends StatelessWidget {
  final Color color;
  final double width;
  final double height;

  const DiagonalTriangle(
      {super.key,
      required this.color,
      required this.width,
      required this.height});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: TriangleClipper(),
      child: Container(
        color: color,
        width: width,
        height: height,
      ),
    );
  }
}

class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path()
      ..moveTo(size.width, size.height)
      ..lineTo(0, 0)
      ..lineTo(size.width, 0)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
