import 'package:flutter/material.dart';
import 'package:rise_pathway/config/constants/package_export.dart';
import 'package:rise_pathway/config/helpers/helpers.dart';
import 'package:rise_pathway/config/utils/colors.dart';
import 'package:rise_pathway/src/views/widget/gradient_border_card.dart';

class ChallengesCard extends StatelessWidget {
  final String title;
  final String description;
  final double height;
  final EdgeInsets? margin;
  final Function()? onTap;
  final bool isCompleted;
  const ChallengesCard({
    super.key,
    required this.title,
    required this.description,
    this.margin,
    required this.height,
    this.onTap,
    required this.isCompleted,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: onTap,
      child: GradientBorderCard(
        height: height,
        margin: margin ?? EdgeInsets.symmetric(vertical: 1.h),
        children: Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.all(2),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(36),
            border: Border.all(
              width: 2,
              color: AppColors.blue.withOpacity(0),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.topRight,
                children: [
                  SizedBox(
                    height: 12.h,
                    width: 100.w,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: Image.asset(
                        'assets/imgs/callenges.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    height: 4.h,
                    width: isCompleted ? 30.w : 35.w,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(24),
                        bottomLeft: Radius.circular(10),
                      ),
                      gradient: isCompleted
                          ? AppColorsGredients.quizYesButton
                          : AppColorsGredients.quizNoButton,
                    ),
                    child: RiseText(
                      isCompleted ? 'Completed' : 'Not Completed',
                      style: theme.labelSmall!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 2.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RiseText(
                    title,
                    style: theme.titleMedium!.copyWith(
                      color: AppColors.darkSkyBlue,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 50.w,
                        child: RiseText(
                          description,
                          style: theme.labelSmall!.copyWith(
                            color: AppColors.challengesCardSubtitle,
                            // fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward,
                        color: AppColors.skyBlue,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
