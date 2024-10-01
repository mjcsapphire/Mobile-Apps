import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rise_pathway/core/constants/package_export.dart';
import 'package:rise_pathway/core/helpers/helpers.dart';
import 'package:rise_pathway/core/routes/routes.dart';
import 'package:rise_pathway/core/utils/colors.dart';
import 'package:rise_pathway/core/utils/widget.dart';
import 'package:rise_pathway/src/controllers/auth_controller.dart';
import 'package:rise_pathway/src/controllers/challenge_controller.dart';
import 'package:rise_pathway/src/controllers/home_controller.dart';
import 'package:rise_pathway/src/controllers/rise_pathway_controller.dart';
import 'package:rise_pathway/src/models/pathways/pathway_response.dart';
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
  final challengeController = Get.find<ChallengeController>();
  final risePathwayController = Get.find<RisePathwayController>();
  final _dailyChallengePageController = PageController();
  final AuthController authController = Get.find<AuthController>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final user = authController.userData.value;
      final email = user.userEmail ?? '';
      final selectMood = moods.indexOf(user.mood ?? "happy");
      homeController.emojiIndex.value = selectMood;
      await getChallenges(email: email);
      await getPathways(email: email);
    });
    super.initState();
  }

  getChallenges({required String email}) async {
    await challengeController.fetchChallenges(email: email);
  }

  getPathways({required String email}) async {
    await risePathwayController.fetchPathways(email: email);
  }

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
                  BuildHomeAppBar(
                    theme: theme,
                    authController: authController,
                  ),
                  BuildAnalysisAndCoachDetails(
                    theme: theme,
                    homeController: homeController,
                  ),
                  BuildDailyCallengesList(
                    theme: theme,
                    dailyChallengePageController: _dailyChallengePageController,
                    challengeController: challengeController,
                    homeController: homeController,
                  ),
                  SizedBox(height: 2.h),
                  if (challengeController.challenges.isNotEmpty)
                    SmoothPageIndicator(
                      controller: _dailyChallengePageController,
                      count: challengeController.challenges.length,
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
                    pathwayController: risePathwayController,
                  ),
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
    required this.challengeController,
  }) : _dailyChallengePageController = dailyChallengePageController;

  final TextTheme theme;
  final PageController _dailyChallengePageController;
  final HomeController homeController;
  final ChallengeController challengeController;

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
        Obx(() => Container(
              height: 29.h,
              width: 100.w,
              padding: EdgeInsets.symmetric(horizontal: 1.h),
              child: challengeController.challenges.isEmpty
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ),
                    )
                  : PageView.builder(
                      itemCount: challengeController.challenges.length,
                      controller: _dailyChallengePageController,
                      itemBuilder: (context, index) {
                        return ChallengesCard(
                          height: 28.h,
                          challenge: challengeController.challenges[index],
                          margin: EdgeInsets.symmetric(
                            horizontal: 1.h,
                            vertical: 2.w,
                          ),
                        );
                      },
                    ),
            )),
      ],
    );
  }
}

class BuildHomeAppBar extends StatelessWidget {
  const BuildHomeAppBar({
    super.key,
    required this.theme,
    required this.authController,
  });

  final TextTheme theme;
  final AuthController authController;

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
                    "${authController.userData.value.firstname} ${authController.userData.value.surname}",
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
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      width: 2,
                      color: AppColors.white,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Image.network(
                      authController.userData.value.mobileAppProfilePic ??
                          "https://www.pngall.com/wp-content/uploads/5/Profile-PNG-File.png",
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.network(
                          "https://www.pngall.com/wp-content/uploads/5/Profile-PNG-File.png",
                          fit: BoxFit.cover,
                        );
                      },
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
                    onTap: () => context.go(homeSelectMood),
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
  const BuildRisePathwayList(
      {super.key, required this.theme, required this.pathwayController});

  final TextTheme theme;
  final RisePathwayController pathwayController;

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
        Obx(() => Container(
              height: 60.w,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: pathwayController.pathways.isEmpty
                  ? const Center(
                      child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation(AppColors.primaryColor),
                    ))
                  : ListView.builder(
                      itemCount: pathwayController.pathways.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () => context.go(quizPage, extra: {
                          'title': 'Communication',
                        }),
                        child: RisepathwayCard(
                          theme: theme,
                          isAttempted:
                              pathwayController.pathways[index].userScore !=
                                  "0 / 10",
                          pathway: pathwayController.pathways[index],
                        ),
                      ),
                    ),
            )),
      ],
    );
  }
}

class RisepathwayCard extends StatelessWidget {
  const RisepathwayCard({
    super.key,
    required this.theme,
    required this.isAttempted,
    required this.pathway,
  });

  final TextTheme theme;
  final bool isAttempted;
  final PathwayResponse pathway;

  @override
  Widget build(BuildContext context) {
    final color = pathway.colour;
    return Container(
      width: 65.w,
      height: 60.w,
      margin: const EdgeInsets.only(left: 12),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: isAttempted
            ? LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  const Color(0xFF08477D),
                  Color(int.parse(color)),
                ],
              )
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
                                pathway.userScore,
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
                      pathway.title,
                      // textAlign: TextAlign.center,
                      style: theme.labelSmall!.copyWith(
                        color: AppColors.white,
                        fontSize: pathway.title.length > 16 ? 8.sp : 12.sp,
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
                  pathway.title,
                  textAlign: TextAlign.center,
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
