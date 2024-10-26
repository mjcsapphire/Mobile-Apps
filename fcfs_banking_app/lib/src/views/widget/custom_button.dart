import 'package:fcfs_banking_app/core/theme/colors.dart';
import 'package:flutter/material.dart';

class CustomButtonWidget extends StatelessWidget {
  final VoidCallback onTap;
  final double width;
  final String text;
  final Icon? icon;
  final double? fontSize;
  final bool isIconAvailable;
  final Color? color;
  final Color borderColor;
  final Color? textColor;
  final String? fontFamily;

  const CustomButtonWidget({
    super.key,
    required this.onTap,
    required this.width,
    required this.text,
    this.icon,
    this.fontSize,
    required this.isIconAvailable,
    this.color,
    this.textColor,
    this.borderColor = AppColors.white,
    this.fontFamily,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: borderColor,
            width: 0.6,
          ),
        ),
        child: Row(
          mainAxisAlignment: isIconAvailable
              ? MainAxisAlignment.spaceBetween
              : MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  fontSize: fontSize, color: textColor, fontFamily: fontFamily),
            ),
            icon ?? const SizedBox(),
          ],
        ),
      ),
    );
  }
}
