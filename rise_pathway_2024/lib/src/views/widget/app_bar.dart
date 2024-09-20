import 'package:flutter/material.dart';
import 'package:rise_pathway/config/constants/package_export.dart';
import 'package:rise_pathway/config/helpers/helpers.dart';
import 'package:rise_pathway/config/utils/colors.dart';

class RiseAppBar {
  static PreferredSizeWidget riseAppBar({
    required TextTheme theme,
    required String title,
    bool chatPage = false,
    Widget? child,
    bool isAdd = false,
    required Function() onTap,
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
        child: Container(
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
          SizedBox(width: 20.w)
        }
      ],
    );
  }
}

class RiseMainAppBar {
  static PreferredSizeWidget riseMaiAppBar(
      {required TextTheme theme,
      required String title,
      required Function() onTap}) {
    return AppBar(
      toolbarHeight: 12.h,
      title: Container(
        decoration: const BoxDecoration(
            gradient: AppColorsGredients.primaryTopToBottom),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RiseText(
              "Hello There,",
              style: theme.titleMedium!.copyWith(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            RiseText(
              "Adarsh Gachha",
              style: theme.titleLarge!.copyWith(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      actions: [
        Container(
          width: 70,
          height: 70,
          margin: const EdgeInsets.only(right: 24),
          decoration: BoxDecoration(
            border: Border.all(
              width: 2,
              color: AppColors.white,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cG9ydHJhaXR8ZW58MHx8MHx8fDA%3D',
              fit: BoxFit.cover,
            ),
          ),
        )
      ],
    );
  }
}
