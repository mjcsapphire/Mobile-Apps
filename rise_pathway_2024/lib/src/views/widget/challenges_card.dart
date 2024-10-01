import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:rise_pathway/core/constants/package_export.dart';
import 'package:rise_pathway/core/helpers/helpers.dart';
import 'package:rise_pathway/core/utils/colors.dart';
import 'package:rise_pathway/src/models/challenges/challenges_response.dart';
import 'package:rise_pathway/src/views/widget/gradient_border_card.dart';

class ChallengesCard extends StatelessWidget {
  final double height;
  final EdgeInsets? margin;
  final Function()? onTap;
  final ChallengesResponse challenge;
  const ChallengesCard({
    super.key,
    this.margin,
    this.onTap,
    required this.height,
    required this.challenge,
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
                  Container(
                    height: 12.h,
                    width: 100.w,
                    decoration: BoxDecoration(
                      color: AppColors.black.withOpacity(0.02),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: Image.network(
                        challenge.image,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Container(
                    height: 4.h,
                    width: challenge.status == "Completed" ? 30.w : 35.w,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(24),
                        bottomLeft: Radius.circular(10),
                      ),
                      gradient: challenge.status == "Completed"
                          ? AppColorsGredients.quizYesButton
                          : AppColorsGredients.quizNoButton,
                    ),
                    child: RiseText(
                      challenge.status == "Completed"
                          ? 'Completed'
                          : 'Not Completed',
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
                    challenge.name,
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
                        height: 5.h,
                        child: HtmlWidget(
                          challenge.pathwayName,
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
