import 'package:flutter/material.dart';
import 'package:rise_pathway/core/constants/package_export.dart';
import 'package:rise_pathway/core/utils/colors.dart';

import '../../../core/helpers/helpers.dart';

class RiseButton extends StatefulWidget {
  final String title;
  final Function onTap;
  final Gradient? gradient;
  final double? width;
  final double? height;
  final bool? preffix;
  final String? svgPath;
  final Color? color;
  final Color? textColor;
  const RiseButton({
    super.key,
    required this.title,
    required this.onTap,
    this.textColor,
    this.color,
    this.height,
    this.gradient,
    this.width,
    this.preffix,
    this.svgPath,
  });

  @override
  State<RiseButton> createState() => _RiseButtonState();
}

class _RiseButtonState extends State<RiseButton> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () => widget.onTap(),
      child: Container(
        width: widget.width ?? 100.w,
        height: widget.height ?? 6.4.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: widget.color,
          gradient: widget.color != null
              ? null
              : widget.gradient ?? AppColorsGredients.primaryRightToLeft,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.preffix ?? false)
              SvgPicture.asset(
                widget.svgPath ?? 'assets/svg/success_complete.svg',
              ),
            RiseText(
              widget.title,
              style: theme.bodyMedium!.copyWith(
                color: widget.textColor ?? AppColors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
