import 'package:flutter/material.dart';
import 'package:rise_pathway/config/constants/package_export.dart';
import 'package:rise_pathway/config/helpers/helpers.dart';
import 'package:rise_pathway/config/utils/colors.dart';
import 'package:rise_pathway/src/controllers/home_controller.dart';
import 'package:rise_pathway/src/views/widget/app_bar.dart';
import 'package:rise_pathway/src/views/widget/gradient_border_card.dart';

class Reflection extends StatefulWidget {
  const Reflection({super.key});

  @override
  State<Reflection> createState() => _ReflectionState();
}

class _ReflectionState extends State<Reflection> {
  final homeController = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    List<String> emojiTitles = [
      'Sun',
      'Mon',
      'Tue',
      'Wed',
      'Thu',
      'Fri',
      'Sat',
    ];
    return Scaffold(
      appBar: RiseAppBar.riseAppBar(
        theme: theme,
        title: 'Reflection',
        onTap: () {
          homeController.navIndex.value = 0;
        },
      ),
      body: Obx(() => SingleChildScrollView(
            padding: EdgeInsets.only(
                bottom: homeController.isPlayerVisible.value ? 18.h : 10.h,
                left: 4.w,
                right: 4.w),
            child: SizedBox(
              width: 100.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 80.w,
                    height: 6.h,
                    alignment: Alignment.bottomRight,
                    child: Text(
                      'View all of your key rise information for the day, week and month',
                      textAlign: TextAlign.center,
                      textScaler: TextScaler.noScaling,
                      style: theme.bodySmall,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Container(
                    height: 25.h,
                    margin: EdgeInsets.only(left: 6.h),
                    alignment: Alignment.center,
                    child: PieChart(
                      PieChartData(
                        centerSpaceRadius: 20,
                        sections: [
                          PieChartSectionData(
                            color: const Color(0xff0293ee),
                            gradient: AppColorsGredients.pieChartGradient3,
                            value: 40,
                            title: '35%',
                            radius: (35 * 2) - 10,
                            titleStyle: theme.bodySmall!.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 9.sp,
                              color: AppColors.white,
                            ),
                            badgePositionPercentageOffset: 2,
                            badgeWidget: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/icons/puzzle_icon.png',
                                  scale: 4,
                                ),
                                SizedBox(height: 0.8.h),
                                Text(
                                  'Adaptation',
                                  textScaler: TextScaler.noScaling,
                                  style: theme.labelSmall!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 9.sp,
                                  ),
                                ),
                                SizedBox(height: 0.8.h),
                              ],
                            ),
                          ),
                          PieChartSectionData(
                            color: const Color(0xfff8b250),
                            gradient: AppColorsGredients.pieChartGradient1,
                            value: 40,
                            title: '40%',
                            radius: (40 * 2) - 10,
                            titleStyle: theme.bodySmall!.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 9.sp,
                              color: AppColors.white,
                            ),
                            badgePositionPercentageOffset: 1.9,
                            // badgePositionPercentageOffset: 0.5.w,

                            badgeWidget: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/icons/group_messaging.png',
                                  scale: 4,
                                ),
                                SizedBox(height: 0.8.h),
                                Text(
                                  'Communication',
                                  textScaler: TextScaler.noScaling,
                                  style: theme.labelSmall!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 9.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          PieChartSectionData(
                            color: const Color(0xfff8b250),
                            gradient: AppColorsGredients.pieChartGradient2,
                            value: 25,
                            title: '25%',
                            radius: (25 * 2) - 10,
                            titleStyle: theme.bodySmall!.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 9.sp,
                              color: AppColors.white,
                            ),
                            badgePositionPercentageOffset: 2.5,
                            badgeWidget: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/icons/friendship_icon.png',
                                  scale: 4,
                                ),
                                SizedBox(height: 0.8.h),
                                Text(
                                  'Relationship',
                                  textScaler: TextScaler.noScaling,
                                  style: theme.labelSmall!.copyWith(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 9.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      swapAnimationCurve: Curves.bounceIn,
                      swapAnimationDuration: const Duration(milliseconds: 150),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    'Mood Throughout the week',
                    textScaler: TextScaler.noScaling,
                    textAlign: TextAlign.center,
                    style: theme.titleSmall!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  Helpers.customDivider(thickness: 2, secondThickness: 4),
                  SizedBox(height: 1.h),
                  GradientBorderCard(
                    height: 12.h,
                    width: 90.w,
                    borderRadius: BorderRadius.circular(26),
                    children: SizedBox(
                      // width: 80.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(
                            7,
                            (index) => Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/gif/${Helpers.emojiImages[index]}',
                                      scale: 9,
                                    ),
                                    SizedBox(height: 1.h),
                                    Text(
                                      emojiTitles[index],
                                      textScaler: TextScaler.noScaling,
                                      style: theme.bodySmall!.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                )),
                      ),
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      RelectionStatusCard(
                        theme: theme,
                        title: 'Today’s Reflections',
                        firstValue: '0',
                        secondValue: '0',
                        firstTitle: 'Total Rises',
                        secondTitle: 'Challenges\nCompleted',
                      ),
                      RelectionStatusCard(
                        theme: theme,
                        title: 'This Week’s Reflections',
                        firstValue: '0',
                        secondValue: '0',
                        firstTitle: 'Total Rises',
                        secondTitle: 'Challenges\nCompleted',
                      ),
                      RelectionStatusCard(
                        theme: theme,
                        title: 'This Month’s Reflections',
                        firstValue: '0',
                        secondValue: '0',
                        firstTitle: 'Total Rises',
                        secondTitle: 'Challenges\nCompleted',
                        divider: false,
                      ),
                      SizedBox(height: 5.h)
                    ],
                  )
                ],
              ),
            ),
          )),
    );
  }
}

class RelectionStatusCard extends StatelessWidget {
  final String title;
  final String firstValue;
  final String secondValue;
  final String firstTitle;
  final String secondTitle;
  final bool? divider;

  const RelectionStatusCard({
    super.key,
    required this.theme,
    required this.title,
    required this.firstValue,
    required this.secondValue,
    required this.firstTitle,
    required this.secondTitle,
    this.divider,
  });

  final TextTheme theme;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              textScaler: TextScaler.noScaling,
              style: theme.titleSmall!.copyWith(
                fontWeight: FontWeight.w500,
                color: AppColors.primaryColor,
              ),
            ),
            SizedBox(height: 2.h),
            Container(
              height: 12.h,
              width: 90.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(26),
                gradient: AppColorsGredients.primaryRightToLeft,
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        firstValue,
                        textScaler: TextScaler.noScaling,
                        style: theme.displayMedium!.copyWith(
                          fontWeight: FontWeight.w500,
                          color: AppColors.white,
                        ),
                      ),
                      Text(
                        firstTitle,
                        textScaler: TextScaler.noScaling,
                        style: theme.labelSmall!.copyWith(
                          fontWeight: FontWeight.w500,
                          color: AppColors.white,
                          fontSize: 10.sp,
                        ),
                      ),
                      Container(
                        width: 0.5.w,
                        height: 6.h,
                        decoration: BoxDecoration(
                          color: AppColors.black.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(26),
                        ),
                      ),
                      Text(
                        secondValue,
                        textScaler: TextScaler.noScaling,
                        style: theme.displayMedium!.copyWith(
                          fontWeight: FontWeight.w500,
                          color: AppColors.white,
                        ),
                      ),
                      Text(
                        secondTitle,
                        textScaler: TextScaler.noScaling,
                        style: theme.labelSmall!.copyWith(
                          fontWeight: FontWeight.w500,
                          color: AppColors.white,
                          fontSize: 10.sp,
                        ),
                      ),
                    ],
                  ),
                  SvgPicture.asset(
                    'assets/svg/reflection_container.svg',
                    colorFilter: ColorFilter.mode(
                      AppColors.white.withOpacity(0.3),
                      BlendMode.srcIn,
                    ),
                    // height: 25.h,
                  ),
                ],
              ),
            ),

            if (divider ?? true) ...{
              SizedBox(height: 0.5.h),
              Helpers.customDivider(thickness: 2, secondThickness: 6),
            }
            // SizedBox()
          ],
        ),
        // ,
      ],
    );
  }
}
