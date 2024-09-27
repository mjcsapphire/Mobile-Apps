import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:rise_pathway/core/constants/package_export.dart';
import 'package:rise_pathway/core/constants/strings.dart';
import 'package:rise_pathway/core/helpers/helpers.dart';
import 'package:rise_pathway/core/utils/colors.dart';
import 'package:rise_pathway/src/models/challenges/challenges_response.dart';
import 'package:rise_pathway/src/views/widget/app_bar.dart';
import 'package:rise_pathway/src/views/widget/gradient_border_card.dart';
import 'package:rise_pathway/src/views/widget/rise_button.dart';

class ChallengePage extends StatefulWidget {
  final ChallengesResponse challenge;
  const ChallengePage({super.key, required this.challenge});

  @override
  State<ChallengePage> createState() => _ChallengePageState();
}

class _ChallengePageState extends State<ChallengePage> {
  final cardSwiperController = AppinioSwiperController().obs;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: RiseAppBar.riseAppBar(
        title: widget.challenge.name,
        onTap: () => context.pop(),
        theme: theme,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            GradientBorderCard(
              height: 22.h,
              margin: EdgeInsets.zero,
              borderRadius: BorderRadius.circular(20),
              children: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    margin: const EdgeInsets.all(1),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            widget.challenge.image,
                            width: 100.w,
                            height: 100.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            height: 20.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.black.withOpacity(0.8),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: 60.w,
                      height: 10.h,
                      padding: EdgeInsets.symmetric(horizontal: 3.h),
                      margin: const EdgeInsets.only(bottom: 1.5),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                        gradient: AppColorsGredients.primaryRightToLeft,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 2.h,
                            width: 20.w,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: AppColors.white,
                            ),
                            child: RiseText(
                              'Challenge',
                              style: theme.bodySmall!.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 8.sp,
                                color: AppColors.blue600,
                              ),
                            ),
                          ),
                          SizedBox(height: 1.h),
                          RiseText(
                            widget.challenge.name,
                            overflow: TextOverflow.ellipsis,
                            style: theme.titleMedium!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 10.h),
            _buildSwipeCard(theme, widget.challenge.toJson()),
            SizedBox(height: 5.h),
            RiseButton(
              title: widget.challenge.status != 'Not completed'
                  ? r"I've Completed This"
                  : "I've Not Completed This",
              onTap: () {},
              gradient: widget.challenge.status != 'Not completed'
                  ? AppColorsGredients.challengeCompletedBtn
                  : AppColorsGredients.challengeNotCompletedBtn,
              preffix: true,
              svgPath: 'assets/svg/success_complete.svg',
            )
          ],
        ),
      ),
    );
  }

  _buildSwipeCard(TextTheme theme, Map<String, dynamic> challenge) {
    // print("This is new Challenges card:: $challenge");
    return SizedBox(
      height: 36.h,
      child: AppinioSwiper(
        controller: cardSwiperController.value,
        backgroundCardOffset: const Offset(0, -30),
        loop: true,
        backgroundCardCount: 3,
        backgroundCardScale: 0.9,
        onEnd: () => context.pop(),
        allowUnSwipe: false,
        swipeOptions: const SwipeOptions.only(
          left: true,
          right: true,
          up: false,
          down: false,
        ),
        cardBuilder: (BuildContext context, int index) {
          return Obx(() {
            final activeIndex = cardSwiperController.value.cardIndex ?? 0;
            return Container(
              width: 100.w,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xFF08477D)
                        .withOpacity(activeIndex == index ? 1 : 0.3),
                    const Color(0xFF0F81E3),
                  ],
                ),
              ),
              child: Column(
                children: [
                  RiseText(
                    challengeTitleList[index].capitalize.toString(),
                    style: theme.titleMedium!.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Expanded(
                    child: HtmlWidget(
                      challenge[challengeTitleList[index]],
                      textStyle: theme.bodySmall!.copyWith(
                        color: AppColors.white,
                        fontSize: 10.sp,
                      ),
                    ),
                  )
                ],
              ),
            );
          });
        },
        cardCount: challengeTitleList.length,
      ),
    );
  }
}
