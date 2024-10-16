import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../core/helpers/helpers.dart';
import '../../../core/utils/colors.dart';

class NewsEventsCard extends StatelessWidget {
  const NewsEventsCard({super.key, this.margin, this.isAdd, this.onTap});
  final Function()? onTap;
  final EdgeInsets? margin;
  final bool? isAdd;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: margin ?? const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.primaryColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const GText(
                  'News And Events',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                SmoothPageIndicator(
                  controller: PageController(),
                  count: 5,
                  effect: SlideEffect(
                    dotHeight: 6,
                    dotWidth: 6,
                    activeDotColor: AppColors.secondaryColor,
                    dotColor: Colors.white.withOpacity(0.5),
                  ),
                ),
                SizedBox(width: 5.w),
                GText(
                  "1/5",
                  style: textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            GText(
              "5th January",
              style: textTheme.bodySmall!.copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.w300,
              ),
            ),
            SizedBox(height: 2.w),
            GText(
              "Donations for the local school, st Nicolas primary school. We are collecting money and school suplies which will enable the pupils to learn.",
              style: textTheme.bodySmall!.copyWith(
                color: AppColors.black,
                fontWeight: FontWeight.w300,
                fontSize: 11.sp,
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {},
                child: GText(
                  "View",
                  style: textTheme.bodySmall!.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
