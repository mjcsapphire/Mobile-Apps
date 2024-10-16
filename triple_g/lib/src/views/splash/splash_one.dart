import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:triple_g/core/helpers/helpers.dart';
import 'package:triple_g/core/routes/routes.dart';
import 'package:triple_g/core/utils/colors.dart';

import '../widgets/tripleg_button.dart';

class SplashOne extends StatefulWidget {
  const SplashOne({super.key});

  @override
  State<SplashOne> createState() => _SplashOneState();
}

class _SplashOneState extends State<SplashOne> {
  final PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: Stack(
        children: [
          Container(
            height: 60.h,
            width: 100.w,
            decoration: BoxDecoration(
              gradient: GGredients.splashGredient,
            ),
          ),
          Container(
            width: 100.w,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            margin: EdgeInsets.only(top: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset(
                  "assets/png/one.png",
                  height: 35.h,
                ),
                SizedBox(height: 2.h),
                Column(
                  children: [
                    GText(
                      "Find your church",
                      style: textTheme.headlineMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GText(
                      "Get connected to your church, leave donations, listen to sermons and so much more",
                      textAlign: TextAlign.center,
                      style: textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
                // SizedBox(
                //   height: 20.h,
                //   child: PageView.builder(
                //     itemCount: 4,
                //     itemBuilder: (context, index) => Container(),
                //     controller: _pageController,
                //   ),
                // ),
                SizedBox(height: 2.h),
                SmoothPageIndicator(
                  controller: _pageController,
                  count: 4,
                  effect: ExpandingDotsEffect(
                    activeDotColor: AppColors.primaryColor,
                    dotHeight: 0.5.h,
                    dotWidth: 16.w,
                    expansionFactor: 1.8,
                    // strokeWidth: 2,
                    dotColor: AppColors.white,
                  ),
                ),
                SizedBox(height: 2.h),
                TripleButton(
                  title: "Next",
                  onTap: () => context.go(splashTwo),
                ),
                TripleButton(
                  title: "Skip",
                  onTap: () {},
                  color: AppColors.buttonBackground,
                  textColor: AppColors.secondaryColor.withOpacity(0.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
