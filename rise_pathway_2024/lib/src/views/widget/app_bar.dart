import 'package:flutter/material.dart';
import 'package:rise_pathway/core/constants/package_export.dart';
import 'package:rise_pathway/core/helpers/helpers.dart';
import 'package:rise_pathway/core/utils/colors.dart';

class RiseAppBar {
  static PreferredSizeWidget riseAppBar({
    required TextTheme theme,
    required String title,
    bool chatPage = false,
    bool isLogin = false,
    Widget? child,
    bool isAdd = false,
    required Function() onTap,
    IconData? suffixIcon,
    Function()? suffixOnTap,
    Color? backgroundColor = AppColors.white,
    Color? iconColor = AppColors.primaryColor,
  }) {
    return AppBar(
      toolbarHeight: 10.h,
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: backgroundColor,
      leading: Padding(
        padding: EdgeInsets.only(left: chatPage ? 16 : 30),
        child: isLogin
            ? const SizedBox()
            : Container(
                width: 24.w,
                height: 10.h,
                decoration: chatPage
                    ? const BoxDecoration()
                    : BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: iconColor ?? AppColors.primaryColor,
                        ),
                      ),
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 16.sp,
                  ),
                  color: iconColor,
                  onPressed: onTap,
                ),
              ),
      ),
      leadingWidth: chatPage ? 14.w : 20.w,
      title: chatPage
          ? child
          : Center(
              child: RiseText(
                title,
                style: theme.titleSmall!.copyWith(
                  color: iconColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
      actions: [
        if (isAdd) ...{
          SizedBox(
            width: 14.w,
            child: SvgPicture.asset(
              'assets/svg/edit_icon.svg',
              width: 20.w,
              height: 20.w,
            ),
          ),
          SizedBox(width: 2.w)
        } else ...{
          if (suffixIcon == null) ...{
            SizedBox(width: 20.w),
          } else ...{
            IconButton(
              onPressed: suffixOnTap,
              icon: Icon(
                suffixIcon,
                color: AppColors.error,
                size: 12.w,
              ),
            ),
            SizedBox(width: 3.w)
          }
        }
      ],
    );
  }
}
