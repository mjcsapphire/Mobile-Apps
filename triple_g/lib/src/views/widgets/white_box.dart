import 'package:flutter/material.dart';

import '../../../core/utils/colors.dart';

class WhiteBox extends StatelessWidget {
  const WhiteBox({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.margin,
    this.bgColor,
    this.onTap,
    this.isBorder = true,
    this.radius,
  });
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsets? margin;
  final Color? bgColor;
  final Function()? onTap;
  final bool isBorder;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          width: width,
          height: height,
          margin: margin,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: bgColor ?? AppColors.white,
            borderRadius: BorderRadius.circular(radius ?? 16),
            border: isBorder
                ? Border.all(
                    width: 1,
                    color: AppColors.grey,
                  )
                : null,
          ),
          child: child),
    );
  }
}
