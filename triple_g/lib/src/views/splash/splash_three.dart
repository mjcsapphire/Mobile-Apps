import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import 'package:triple_g/core/helpers/helpers.dart';
import 'package:triple_g/core/utils/colors.dart';

import '../../../core/routes/routes.dart';
import '../widgets/tripleg_button.dart';

class SplashThree extends StatefulWidget {
  const SplashThree({super.key});

  @override
  State<SplashThree> createState() => _SplashThreeState();
}

class _SplashThreeState extends State<SplashThree> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: 60.h,
              width: 100.w,
              decoration: BoxDecoration(
                gradient: GGredients.splashGredient,
              ),
            ),
            SizedBox(
              width: 100.w,
              height: 100.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    "assets/png/three.png",
                    height: 350,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        Column(
                          children: [
                            GText(
                              "Create an account",
                              style: textTheme.headlineMedium!.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 0.5.h),
                            GText(
                              "Create an account to start interacting with your church and members",
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
                              title: "Sign In",
                              onTap: () {},
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
                              title: "Register",
                              onTap: () => context.go(app),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),
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
            ),
          ],
        ),
      ),
    );
  }
}
