import 'package:fcfs_banking_app/core/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomListTile extends StatelessWidget {
  final Widget? leading;
  final String title;
  final TextStyle? titleStyle;
  final String? subtitle;
  final TextStyle? subtitleStyle;
  final IconData? trailingIcon;
  final Widget? trailingWidget;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? contentPadding;
  final Color? tileColor;
  final BorderRadius? borderRadius;
  final BoxBorder? border;

  const CustomListTile({
    super.key,
    this.leading,
    required this.title,
    this.titleStyle,
    this.subtitle,
    this.subtitleStyle,
    this.trailingIcon,
    this.trailingWidget,
    this.onTap,
    this.contentPadding,
    this.tileColor,
    this.borderRadius,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: tileColor ?? AppColors.transparent,
        borderRadius: borderRadius ?? BorderRadius.circular(10),
        border: border ?? Border.all(color: AppColors.textGreyColor, width: 1),
      ),
      child: ListTile(
        leading: leading,
        title: Text(
          title,
          style: titleStyle ??
              Theme.of(context).textTheme.displaySmall!.copyWith(
                  color: AppColors.white.withOpacity(0.9), fontSize: 16.sp),
        ),
        subtitle: subtitle != null
            ? Text(
                subtitle!,
                style: subtitleStyle ??
                    const TextStyle(
                      color: AppColors.textGreyColor,
                      fontSize: 16,
                    ),
              )
            : null,
        trailing: trailingWidget ??
            (trailingIcon != null
                ? Icon(
                    trailingIcon,
                    color: AppColors.white.withOpacity(0.5),
                  )
                : null),
        contentPadding:
            contentPadding ?? const EdgeInsets.symmetric(horizontal: 16.0),
        onTap: onTap,
      ),
    );
  }
}

class NotificationCustomListTile extends StatelessWidget {
  final Widget? leading;
  final String readStatus;
  final String day;
  final TextStyle? titleStyle;
  final String? subtitle;
  final TextStyle? subtitleStyle;
  final IconData? trailingIcon;
  final Widget? trailingWidget;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? contentPadding;
  final Color? tileColor;
  final BorderRadius? borderRadius;
  final BoxBorder? border;
  final Color textColor;

  const NotificationCustomListTile({
    super.key,
    this.leading,
    required this.readStatus,
    required this.day,
    this.titleStyle,
    this.subtitle,
    this.subtitleStyle,
    this.trailingIcon,
    this.trailingWidget,
    this.onTap,
    this.contentPadding,
    this.tileColor,
    this.borderRadius,
    this.border,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: tileColor ?? AppColors.transparent,
        borderRadius: borderRadius ?? BorderRadius.circular(10),
        border: border ?? Border.all(color: AppColors.textGreyColor, width: 1),
      ),
      child: ListTile(
        // leading: leading,
        title: Row(
          children: [
            Text(
              readStatus,
              style: titleStyle ??
                  Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(color: textColor, fontSize: 16.sp),
            ),
            const Spacer(),
            Text(
              day,
              style: titleStyle ??
                  Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(color: textColor, fontSize: 16.sp),
            ),
          ],
        ),
        subtitle: subtitle != null
            ? Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(subtitle!,
                    textAlign: TextAlign.center,
                    style: subtitleStyle ??
                        Theme.of(context).textTheme.displaySmall!.copyWith(
                            color: textColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600)),
              )
            : null,
        trailing: trailingWidget ??
            (trailingIcon != null
                ? Icon(
                    trailingIcon,
                    color: AppColors.white.withOpacity(0.5),
                  )
                : null),
        contentPadding: contentPadding ??
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
        onTap: onTap,
      ),
    );
  }
}
