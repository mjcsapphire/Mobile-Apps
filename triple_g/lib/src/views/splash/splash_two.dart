import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import 'package:triple_g/core/helpers/helpers.dart';
import 'package:triple_g/core/routes/routes.dart';
import 'package:triple_g/core/utils/colors.dart';

import '../widgets/tripleg_button.dart';

class SplashTwo extends StatefulWidget {
  const SplashTwo({super.key});

  @override
  State<SplashTwo> createState() => _SplashTwoState();
}

class _SplashTwoState extends State<SplashTwo> {
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
            margin: EdgeInsets.only(top: 12.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  "assets/png/two.png",
                  height: 40.h,
                ),
                SizedBox(height: 2.h),
                Column(
                  children: [
                    GText(
                      "Join your church",
                      style: textTheme.headlineMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GText(
                      "Either scan a QR code or find a church near you to get started",
                      textAlign: TextAlign.center,
                      style: textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2.h),
                Column(
                  children: [
                    TripleButton(
                      title: "Scan QR Code",
                      onTap: () => context.go(splashThree),
                    ),
                    SizedBox(height: 0.5.h),
                    GText(
                      'or',
                      style: textTheme.bodyMedium!.copyWith(
                        color: AppColors.primaryColor,
                      ),
                    ),
                    SizedBox(height: 0.5.h),
                    TripleButton(
                      title: "Find near me",
                      onTap: () {},
                    ),
                  ],
                ),
                SizedBox(height: 5.h),
                TextButton(
                  onPressed: () {},
                  child: GText(
                    "Need help?",
                    textAlign: TextAlign.center,
                    style: textTheme.bodySmall!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
