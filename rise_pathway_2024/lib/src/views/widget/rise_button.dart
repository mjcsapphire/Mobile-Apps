import 'package:flutter/material.dart';
import 'package:rise_pathway/config/constants/package_export.dart';
import 'package:rise_pathway/config/utils/colors.dart';

import '../../../config/helpers/helpers.dart';

class RiseButton extends StatefulWidget {
  final String title;
  final Function() onTap;
  final Gradient? gradient;
  final double? width;
  final bool? preffix;
  final String? svgPath;
  const RiseButton({
    super.key,
    required this.title,
    required this.onTap,
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
      onTap: widget.onTap,
      child: Container(
        width: widget.width ?? 100.w,
        height: 6.4.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: widget.gradient ?? AppColorsGredients.primaryRightToLeft,
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
                color: AppColors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
