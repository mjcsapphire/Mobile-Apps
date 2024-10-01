import 'package:flutter/material.dart';
import 'package:rise_pathway/core/constants/package_export.dart';
import 'package:rise_pathway/core/utils/colors.dart';

class GradientBorderCard extends StatelessWidget {
  final Widget children;
  final double height;
  final double? width;
  final EdgeInsets? margin;
  final BorderRadius? borderRadius;
  const GradientBorderCard({
    super.key,
    required this.children,
    required this.height,
    this.borderRadius,
    this.width,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin: margin ?? const EdgeInsets.all(10),
      child: Stack(
        alignment: Alignment.center,
        children: [
          ShaderMask(
            shaderCallback: (Rect bounds) {
              return AppColorsGredients.gradientForBorder.createShader(bounds);
            },
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    spreadRadius: 0.5.h,
                    blurRadius: 1.h,
                    offset: const Offset(0, 0),
                  )
                ],
                border: Border.all(
                  color: Colors.white,
                  width: 1.5,
                ),
                borderRadius: borderRadius ?? BorderRadius.circular(37),
              ),
            ),
          ),
          children
        ],
      ),
    );
  }
}
