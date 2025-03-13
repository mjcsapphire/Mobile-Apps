import 'package:flutter/material.dart';
import 'package:rise_pathway/core/constants/package_export.dart';
import 'package:rise_pathway/core/helpers/helpers.dart';

class SmallCards {
  static Widget smallCards(
    TextTheme theme,
    BuildContext context,
    String title,
    String subTitle,
    String emoji,
    Color backgroundColor,
  ) {
    return Row(
      children: [
        Image.asset(
          'assets/icons/$emoji.png',
          scale: 0.7.w * 2,
        ),
        SizedBox(width: 1.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RiseText(
              title,
              maxLines: 1,
              style: theme.labelSmall!.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 0.5.h),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 1.h,
                vertical: 0.5.h,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: backgroundColor.withOpacity(0.2),
              ),
              child: RiseText(
                subTitle,
                style: theme.labelSmall!.copyWith(
                  color: backgroundColor,
                  fontSize: 6.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
