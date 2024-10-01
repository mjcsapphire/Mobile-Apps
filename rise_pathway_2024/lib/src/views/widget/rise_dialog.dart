import 'package:flutter/material.dart';
import 'package:rise_pathway/core/constants/package_export.dart';
import 'package:rise_pathway/core/helpers/helpers.dart';
import 'package:rise_pathway/core/utils/colors.dart';
import 'package:rise_pathway/src/views/widget/rise_button.dart';

class RiseDialog extends StatelessWidget {
  final String? flag;
  final String buttonTextyes;
  final String buttonTextno;
  final String title;
  final Function onTapYes;
  final String image;

  const RiseDialog(
      {super.key,
      required this.buttonTextno,
      required this.buttonTextyes,
      required this.onTapYes,
      required this.image,
      required this.title,
      this.flag});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Dialog(
      backgroundColor: AppColors.white,
      surfaceTintColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          // overflow: Overflow.visible,
          // alignment: Alignment.center,
          children: <Widget>[
            Image.asset(
              image,
              height: 20.h,
            ),
            SizedBox(height: 2.h),
            RiseText(
              title,
              textAlign: TextAlign.center,
              style: textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.darkGrey,
              ),
            ),
            SizedBox(height: 2.h),
            Row(
              children: [
                Expanded(
                  child: RiseButton(
                    title: "No",
                    onTap: () => context.pop(),
                    textColor: AppColors.black,
                    color: AppColors.lightGrey,
                    height: 6.h,
                  ),
                ),
                SizedBox(width: 5.w),
                Expanded(
                  child: RiseButton(
                    title: "Yes",
                    onTap: () => onTapYes(),
                    height: 6.h,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
