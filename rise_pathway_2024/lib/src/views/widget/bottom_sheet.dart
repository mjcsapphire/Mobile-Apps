import 'package:flutter/material.dart';
import 'package:rise_pathway/config/constants/package_export.dart';
import 'package:rise_pathway/config/helpers/helpers.dart';
import 'package:rise_pathway/config/utils/colors.dart';

class RiseBottomSheet extends StatelessWidget {
  const RiseBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Container(
      width: 100.w,
      height: 40.h,
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: 76,
            height: 76,
            decoration: const BoxDecoration(
              gradient: AppColorsGredients.quizYesButton,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.lighterGrey,
                  spreadRadius: 0.5,
                  blurRadius: 10,
                  offset: Offset(2, 2),
                )
              ],
            ),
            child: const Icon(
              Icons.check,
              color: AppColors.white,
            ),
          ),
          Column(
            children: [
              ShaderMask(
                shaderCallback: (bounds) =>
                    AppColorsGredients.primaryRightToLeft.createShader(bounds),
                blendMode: BlendMode.srcIn,
                child: RiseText(
                  'Success!',
                  style: theme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.w500,
                    decorationColor: ColorEffect.neutralValue,
                  ),
                ),
              ),
              SizedBox(height: 1.h),
              RiseText(
                'Your password has been changed Successfully!',
                textAlign: TextAlign.center,
                style: theme.labelLarge!.copyWith(
                  decorationColor: ColorEffect.neutralValue,
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
        ],
      ),
    );
  }
}
