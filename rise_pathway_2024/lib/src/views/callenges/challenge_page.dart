import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter/material.dart';
import 'package:rise_pathway/config/constants/package_export.dart';
import 'package:rise_pathway/config/utils/colors.dart';
import 'package:rise_pathway/src/views/widget/app_bar.dart';
import 'package:rise_pathway/src/views/widget/gradient_border_card.dart';
import 'package:rise_pathway/src/views/widget/rise_button.dart';

class ChallengePage extends StatefulWidget {
  const ChallengePage({super.key});

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
        title: 'Challenge',
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
                            'https://images.unsplash.com/photo-1525130413817-d45c1d127c42?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80',
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
                            child: Text(
                              'Challenge',
                              textScaler: TextScaler.noScaling,
                              style: theme.bodySmall!.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 8.sp,
                                color: AppColors.blue600,
                              ),
                            ),
                          ),
                          SizedBox(height: 1.h),
                          Text(
                            'Talk to People',
                            textScaler: TextScaler.noScaling,
                            style: theme.titleMedium!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 10.h),
            _buildSwipeCard(theme),
            SizedBox(height: 5.h),
            RiseButton(
              title: r"I've Completed This",
              onTap: () {},
              gradient: AppColorsGredients.challengeCompletedBtn,
            )
          ],
        ),
      ),
    );
  }

  _buildSwipeCard(TextTheme theme) {
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
                  Text(
                    'Introduction $index',
                    textScaler: TextScaler.noScaling,
                    style: theme.titleMedium!.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    'Today, the focus is on human connection. Social interaction is a key aspect of feeling supported, heard, and understood, even when it feels challenging. Your mood suggests that opening up to others might help boost your emotional state or even provide new perspectives.',
                    textScaler: TextScaler.noScaling,
                    strutStyle: const StrutStyle(height: 1.5),
                    style: theme.labelSmall!.copyWith(
                      color: AppColors.white,
                      fontSize: 10.sp,
                    ),
                  ),
                ],
              ),
            );
          });
        },
        cardCount: 10,
      ),
    );
  }
}
