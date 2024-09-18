import 'package:flutter/material.dart';
import 'package:rise_pathway/config/constants/package_export.dart';
import 'package:rise_pathway/config/helpers/helpers.dart';
import 'package:rise_pathway/config/utils/colors.dart';
import 'package:rise_pathway/src/views/home/home.dart';
import 'package:rise_pathway/src/views/widget/app_bar.dart';

class QuizSummary extends StatefulWidget {
  const QuizSummary({super.key});

  @override
  State<QuizSummary> createState() => _QuizSummaryState();
}

class _QuizSummaryState extends State<QuizSummary> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: RiseAppBar.riseAppBar(
        theme: theme,
        title: 'Quiz Summary',
        iconColor: AppColors.white,
        onTap: () => context.pop(),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            top: -500,
            bottom: 60.h,
            left: -500,
            right: -500,
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: AppColorsGredients.quizSummary,
              ),
            ),
          ),
          SizedBox(
            width: 100.w,
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Container(height: 38.h),
                    Container(
                      width: 100.w,
                      height: 25.h,
                      margin: EdgeInsets.only(top: 8.h, left: 24, right: 24),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                            color: AppColors.lighterGrey,
                            blurRadius: 5,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          RiseText(
                            'Congratulations !',
                            style: theme.titleLarge!.copyWith(
                              color: AppColors.blue700,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Container(
                            width: 100.w,
                            height: 1,
                            color: AppColors.lightGrey,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      RiseText(
                                        'Q',
                                        textAlign: TextAlign.center,
                                        style: theme.bodyLarge!.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.blue700,
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      RiseText(
                                        '10',
                                        textAlign: TextAlign.center,
                                        style: theme.bodyMedium!.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  RiseText(
                                    'Totol Que',
                                    textAlign: TextAlign.center,
                                    style: theme.labelSmall!.copyWith(),
                                  ),
                                ],
                              ),
                              Container(
                                width: 1,
                                height: 70,
                                color: AppColors.lightGrey,
                              ),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      ShaderMask(
                                          blendMode: BlendMode.srcIn,
                                          shaderCallback: (bound) =>
                                              AppColorsGredients.quizYesButton
                                                  .createShader(bound),
                                          child: const Icon(
                                              Icons.check_circle_rounded)),
                                      const SizedBox(width: 5),
                                      RiseText(
                                        '10',
                                        textAlign: TextAlign.center,
                                        style: theme.bodyMedium!.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  RiseText(
                                    'Correct',
                                    textAlign: TextAlign.center,
                                    style: theme.labelSmall!.copyWith(),
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Image.asset(
                      'assets/png/trophy.png',
                      scale: 1.5,
                    ),
                  ],
                ),
                BuildRisePathwayList(
                  theme: theme,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
