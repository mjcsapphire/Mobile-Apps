import 'package:fcfs_banking_app/core/theme/colors.dart';
import 'package:fcfs_banking_app/core/utils/constant/app_assets_constant.dart';
import 'package:fcfs_banking_app/core/utils/constant/string.dart';
import 'package:fcfs_banking_app/services/router/routes_name.dart';
import 'package:fcfs_banking_app/src/views/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

import '../widget/helper_widgets.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ScaffoldHelperWidget(
      backgroundImage: AppAssetsConstant.onboardingBackground,
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20.h),
            Image.asset(
              AppAssetsConstant.cards,
            ),
            SizedBox(height: 2.h),
            Text(
              AppString.onBoardingTitle,
              style: theme.textTheme.headlineSmall!.copyWith(
                fontWeight: FontWeight.w300,
                fontFamily: "AnonymousPro",
              ),
            ),
            SizedBox(height: 0.5.h),
            SizedBox(
              width: 45.w,
              child: Text(
                AppString.onBoardingSubTitle,
                textAlign: TextAlign.center,
                style: theme.textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.w200,
                  fontSize: 14.sp,
                ),
              ),
            ),
            SizedBox(height: 2.h),
            Image.asset(
              AppAssetsConstant.slides,
              width: 18.w,
              height: 1.h,
            ),
            SizedBox(height: 3.h),
            CustomButtonWidget(
              onTap: () {
                context.pushNamed(RoutesName.registerPage);
              },
              width: MediaQuery.of(context).size.width * 0.85,
              fontSize: 16.sp,
              text: "Register",
              isIconAvailable: true,
              icon: Icon(
                Icons.arrow_forward_rounded,
                color: AppColors.white.withOpacity(0.6),
                size: 20,
              ),
            ),
            SizedBox(height: 2.5.h),
            CustomButtonWidget(
              onTap: () {
                context.pushNamed(RoutesName.loginPage);
              },
              width: MediaQuery.of(context).size.width * 0.85,
              text: "Login",
              fontSize: 16.sp,
              isIconAvailable: true,
              icon: Icon(
                Icons.arrow_forward_rounded,
                color: AppColors.white.withOpacity(0.6),
                size: 20,
              ),
            )
          ],
        ),
      ),
    );
  }
}
