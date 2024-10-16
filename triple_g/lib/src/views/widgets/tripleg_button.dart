import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/helpers/helpers.dart';
import '../../../core/utils/colors.dart';

class TripleButton extends StatefulWidget {
  final String title;
  final Function() onTap;
  final double? width;
  final double? height;
  final Color? color;
  final Color? textColor;
  final double? borderRadius;
  final FontWeight? fontWeight;
  final double? fontSize;
  const TripleButton({
    super.key,
    required this.title,
    required this.onTap,
    this.width,
    this.height,
    this.color,
    this.textColor,
    this.borderRadius,
    this.fontWeight,
    this.fontSize,
  });

  @override
  State<TripleButton> createState() => _TripleButtonState();
}

class _TripleButtonState extends State<TripleButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width ?? 100.w,
      height: widget.height ?? 6.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: widget.color ?? AppColors.secondaryColor,
        borderRadius: BorderRadius.circular(widget.borderRadius ?? 10),
        // gradient: GGredients.buttonGredient,
      ),
      child: GestureDetector(
        onTap: widget.onTap,
        child: GText(
          widget.title,
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: widget.textColor ?? AppColors.primaryColor,
                fontWeight: widget.fontWeight ?? FontWeight.bold,
                fontSize: widget.fontSize ?? 14.sp,
              ),
        ),
      ),
    );
  }
}
