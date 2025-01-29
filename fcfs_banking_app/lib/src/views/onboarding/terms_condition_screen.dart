import 'package:fcfs_banking_app/core/theme/colors.dart';
import 'package:fcfs_banking_app/core/theme/radialBg.dart';
import 'package:fcfs_banking_app/core/utils/constant/app_string.dart';
import 'package:fcfs_banking_app/services/router/routes_name.dart';
import 'package:fcfs_banking_app/src/controllers/theme_controller.dart';
import 'package:fcfs_banking_app/src/views/widget/custom_app_bar.dart';
import 'package:fcfs_banking_app/src/views/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

class TermsCondition extends StatefulWidget {
  const TermsCondition({super.key});

  @override
  State<TermsCondition> createState() => _TermsConditionState();
}

class _TermsConditionState extends State<TermsCondition> {
  final ThemeController themeController = Get.find<ThemeController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Terms & Conditions",
        showMoreVertIcon: false,
        showNotificationIcon: false,
        showProfilePic: false,
        onMoreVertTap: () {},
      ),
      body: Stack(
        children: [
            CustomPaint(
              size: Size(
                MediaQuery.of(context).size.width,
                MediaQuery.of(context).size.height,
              ),
              painter: themeController.themeMode == ThemeMode.dark
                  ? DarkGradientBackgroundPainter()
                  : GradientBackgroundPainter(),
            ),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
           
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.67,
                    child: SingleChildScrollView(
                      child: Text(
                        AppString.termsCondition,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(fontSize: 15.sp),
                      ),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        context.pushNamed(RoutesName.privacyPolicyScreen);
                      },
                      child: Text(
                        "Privacy Policy",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: AppColors.pinkColor, fontSize: 15.sp),
                      )),
                  CustomButtonWidget(
                    onTap: () {},
                    width: MediaQuery.of(context).size.width * 0.9,
                    text: "Accept",
                    color: themeController.themeMode == ThemeMode.dark
                        ? AppColors.darkBorderColor
                        : AppColors.purple,
                    borderColor: themeController.themeMode == ThemeMode.dark
                        ? AppColors.darkBorderColor
                        : AppColors.purple,
                    textColor: AppColors.white,
                    fontSize: 18.sp,
                    isIconAvailable: false,
                  ),
                  SizedBox(height: 1.h),
                  CustomButtonWidget(
                    onTap: () {},
                    width: MediaQuery.of(context).size.width * 0.9,
                    text: "Maybe later",
                    fontSize: 18.sp,
                    isIconAvailable: false,
                  ),
                  SizedBox(height: 0.5.h),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
