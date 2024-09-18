import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rise_pathway/config/constants/package_export.dart';
import 'package:rise_pathway/config/helpers/helpers.dart';
import 'package:rise_pathway/config/routes/routes.dart';
import 'package:rise_pathway/config/utils/colors.dart';
import 'package:rise_pathway/config/utils/widget.dart';
import 'package:rise_pathway/src/controllers/home_controller.dart';
import 'package:rise_pathway/src/views/widget/challenges_card.dart';
import 'package:rise_pathway/src/views/widget/gradient_border_card.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final homeController = Get.find<HomeController>();
  final _dailyChallengePageController = PageController();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: AppColors.primaryColor,
      ),
      body: Scaffold(
        body: SafeArea(
          child: Obx(
            () => SingleChildScrollView(
              padding: EdgeInsets.only(
                bottom: homeController.isPlayerVisible.value ? 18.h : 10.h,
              ),
              child: Column(
                children: [
                  BuildHomeAppBar(theme: theme),
                  BuildAnalysisAndCoachDetails(
                    theme: theme,
                    homeController: homeController,
                  ),
                  BuildDailyCallengesList(
                    theme: theme,
                    dailyChallengePageController: _dailyChallengePageController,
                    homeController: homeController,
                  ),
                  SizedBox(height: 2.h),
                  SmoothPageIndicator(
                    controller: _dailyChallengePageController,
                    count: 5,
                    effect: const ExpandingDotsEffect(
                      dotHeight: 10,
                      dotWidth: 10,
                      dotColor: AppColors.lightSkyBlue,
                      activeDotColor: AppColors.primaryColor,
                    ),
                    onDotClicked: (index) {},
                    axisDirection: Axis.horizontal,
                  ),
                  SizedBox(height: 2.h),
                  BuildRisePathwayList(
                    theme: theme,
                  ),
                  SizedBox(height: 5.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BuildDailyCallengesList extends StatelessWidget {
  const BuildDailyCallengesList({
    super.key,
    required this.theme,
    required PageController dailyChallengePageController,
    required this.homeController,
  }) : _dailyChallengePageController = dailyChallengePageController;

  final TextTheme theme;
  final PageController _dailyChallengePageController;
  final HomeController homeController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            homeController.navIndex.value = 1;
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                RiseText(
                  'Daily Challenges',
                  style: theme.titleMedium!.copyWith(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                RiseText(
                  'See All (10)',
                  style: theme.labelSmall!.copyWith(
                    color: AppColors.darkGrey,
                    fontSize: 9.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 0.5.h),
                const Icon(
                  Icons.arrow_forward,
                  color: AppColors.primaryColor,
                )
              ],
            ),
          ),
        ),
        SizedBox(height: 1.h),
        Container(
          height: 29.h,
          width: 100.w,
          padding: EdgeInsets.symmetric(horizontal: 1.h),
          child: PageView.builder(
            itemCount: 5,
            controller: _dailyChallengePageController,
            itemBuilder: (context, index) {
              return ChallengesCard(
                height: 28.h,
                title: 'Talk to people',
                description: 'The beautiful talk of life is always...',
                margin: EdgeInsets.symmetric(
                  horizontal: 1.h,
                  vertical: 2.w,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class BuildHomeAppBar extends StatelessWidget {
  const BuildHomeAppBar({
    super.key,
    required this.theme,
  });

  final TextTheme theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(6.h),
          bottomRight: Radius.circular(6.h),
        ),
        gradient: AppColorsGredients.primaryTopToBottom,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RiseText(
                    "Hello There,",
                    style: theme.bodySmall!.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                  RiseText(
                    "Adarsh Gachha",
                    style: theme.titleMedium!.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () => context.go(profilePage),
                child: Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      width: 2,
                      color: AppColors.white,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Image.network(
                      'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cG9ydHJhaXR8ZW58MHx8MHx8fDA%3D',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              )
            ],
          ),
          GradientBorderCard(
            height: 22.h,
            width: 90.w,
            margin: EdgeInsets.only(top: 2.h),
            children: Container(
              margin: const EdgeInsets.all(2),
              padding: EdgeInsets.all(2.h),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(35),
                border: Border.all(
                  width: 2,
                  color: AppColors.white,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SmallCards.smallCards(
                        theme,
                        context,
                        'Anxious',
                        'Grief',
                        'anxious',
                        AppColors.error,
                      ),
                      Image.asset(
                        'assets/icons/arrow.png',
                        scale: 10,
                      ),
                      SmallCards.smallCards(
                        theme,
                        context,
                        'Excited',
                        'Joyous',
                        'excited',
                        AppColors.success,
                      ),
                    ],
                  ),
                  SizedBox(height: 1.5.h),
                  Container(
                    height: 5.h,
                    width: 100.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      gradient: AppColorsGredients.primaryRightToLeft,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: RiseText(
                      'Now I’m feeling excited',
                      style: theme.bodySmall!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 1.5.h),
                  GestureDetector(
                    onTap: () => context.go(splash),
                    child: RiseText(
                      'Change Mood',
                      style: theme.labelSmall!.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BuildAnalysisAndCoachDetails extends StatelessWidget {
  const BuildAnalysisAndCoachDetails({
    super.key,
    required this.theme,
    required this.homeController,
  });

  final TextTheme theme;
  final HomeController homeController;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 20.h,
          width: 32.w,
          alignment: Alignment.center,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                  width: 16.w,
                  height: 16.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: AppColors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: 1,
                        color: AppColors.black.withOpacity(0.1),
                      )),
                  child: RiseText(
                    'Your Reflection',
                    style: theme.labelSmall!.copyWith(fontSize: 5.sp),
                  )),
              GestureDetector(
                onTap: () => homeController.navIndex.value = 3,
                child: PieChart(
                  PieChartData(
                    centerSpaceRadius: 40,
                    sections: [
                      PieChartSectionData(
                        color: const Color(0xff0293ee),
                        gradient: AppColorsGredients.pieChartGradient3,
                        value: 40,
                        title: '35%',
                        radius: 17,
                        showTitle: false,
                        titleStyle: theme.bodySmall!.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 9.sp,
                          color: AppColors.white,
                        ),
                      ),
                      PieChartSectionData(
                        color: const Color(0xfff8b250),
                        gradient: AppColorsGredients.pieChartGradient1,
                        value: 40,
                        title: '40%',
                        showTitle: false,
                        radius: 20,
                        titleStyle: theme.bodySmall!.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 9.sp,
                          color: AppColors.white,
                        ),
                        badgePositionPercentageOffset: 1.8,
                      ),
                      PieChartSectionData(
                        color: const Color(0xfff8b250),
                        gradient: AppColorsGredients.pieChartGradient2,
                        value: 25,
                        title: '25%',
                        showTitle: false,
                        radius: 12,
                        titleStyle: theme.bodySmall!.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 9.sp,
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 2.w),
        Container(
          width: 60.w,
          height: 16.h,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: const BorderRadius.all(
              Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                spreadRadius: 0.5.h,
                blurRadius: 1.5.h,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 15.w,
                    decoration: const BoxDecoration(
                      gradient: AppColorsGredients.primaryBottomToTop,
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      'assets/icons/person.png',
                      scale: 2,
                    ),
                  ),
                  SizedBox(height: 1.w),
                  RiseText(
                    'Coach',
                    style: theme.bodySmall!.copyWith(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  RiseText(
                    'Stephen Allen',
                    style: theme.titleSmall!.copyWith(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.5.w),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => context.go(schedulePage),
                        child: Image.asset(
                          'assets/icons/solar_calendar.png',
                          scale: 3,
                        ),
                      ),
                      SizedBox(width: 2.w),
                      GestureDetector(
                        onTap: () => context.go(chatPage),
                        child: Image.asset(
                          'assets/icons/messaging.png',
                          scale: 3,
                        ),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}

class BuildRisePathwayList extends StatelessWidget {
  const BuildRisePathwayList({
    super.key,
    required this.theme,
  });

  final TextTheme theme;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            children: [
              RiseText(
                'Rise Pathways',
                style: theme.titleMedium!.copyWith(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () => context.go(risePathway),
                child: Row(
                  children: [
                    RiseText(
                      'See All (10)',
                      style: theme.labelSmall!.copyWith(
                        color: AppColors.darkGrey,
                        fontSize: 9.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 0.5.h),
                    const Icon(Icons.arrow_forward)
                  ],
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 2.h),
        Container(
          height: 60.w,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: ListView.builder(
            itemCount: 5,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () => context.go(quizPage, extra: {
                'title': 'Communication',
              }),
              child: RisepathwayCard(
                theme: theme,
                isAttempted: index % 2 == 0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class RisepathwayCard extends StatelessWidget {
  const RisepathwayCard({
    super.key,
    required this.theme,
    required this.isAttempted,
  });

  final TextTheme theme;
  final bool isAttempted;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 65.w,
      height: 60.w,
      margin: const EdgeInsets.only(left: 12),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: isAttempted
            ? AppColorsGredients.primaryLeftToRight
            : AppColorsGredients.quizYesButton,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Stack(
        children: [
          if (isAttempted) ...{
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 29.w,
                          height: 30.w,
                          child: CircularProgressIndicator(
                            backgroundColor: AppColors.white,
                            value: Random().nextDouble(),
                            strokeWidth: 12,
                            color: AppColors.secondryColor,
                            semanticsLabel: '0.78',
                            semanticsValue: '0.78',
                            strokeCap: StrokeCap.round,
                          ),
                        ),
                        Container(
                          width: 22.w,
                          height: 22.w,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            color: AppColors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RiseText(
                                "9/10",
                                style: theme.bodySmall!.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              RiseText(
                                "Score",
                                style: theme.bodySmall!.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    const Icon(
                      Icons.trending_up,
                      color: AppColors.white,
                      size: 36,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/icons/risepathway_1.png',
                      scale: 3,
                    ),
                    SizedBox(width: 2.w),
                    RiseText(
                      'Relation Development',
                      style: theme.labelSmall!.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
              ],
            )
          } else ...{
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SvgPicture.asset(
                  'assets/svg/heart_doctor.svg',
                ),
                RiseText(
                  'Health & Wellbeing',
                  style: theme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                ),
                Container(
                  width: 80.w,
                  height: 6.h,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RiseText(
                        'Start Quiz',
                        style: theme.bodySmall!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.green,
                        ),
                      ),
                      SizedBox(width: 1.h),
                      const Icon(
                        Icons.trending_up,
                        color: AppColors.green,
                        size: 20,
                      )
                    ],
                  ),
                ),
              ],
            )
          },
        ],
      ),
    );
  }
}
