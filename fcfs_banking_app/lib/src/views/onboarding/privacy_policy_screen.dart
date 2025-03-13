import 'package:fcfs_banking_app/core/theme/colors.dart';
import 'package:fcfs_banking_app/core/theme/radialBg.dart';
import 'package:fcfs_banking_app/core/utils/constant/app_string.dart';
import 'package:fcfs_banking_app/src/controllers/theme_controller.dart';
import 'package:fcfs_banking_app/src/views/widget/custom_app_bar.dart';
import 'package:fcfs_banking_app/src/views/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  final ThemeController themeController = Get.find<ThemeController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Privacy Policy",
        showMoreVertIcon: true,
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
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: SingleChildScrollView(
                    child: Text(
                      AppString.privacyPolicy,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(fontSize: 15.sp),
                    ),
                  ),
                ),
                const Spacer(),
                CustomButtonWidget(
                  onTap: () {},
                  width: MediaQuery.of(context).size.width * 0.9,
                  text: "Agree",
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
                  text: "Disagree",
                  fontSize: 18.sp,
                  isIconAvailable: false,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
