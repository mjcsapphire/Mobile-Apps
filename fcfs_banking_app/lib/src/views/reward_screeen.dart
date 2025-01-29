import 'package:fcfs_banking_app/core/theme/colors.dart';
import 'package:fcfs_banking_app/core/theme/radialBg.dart';
import 'package:fcfs_banking_app/src/controllers/referral_controller.dart';
import 'package:fcfs_banking_app/src/controllers/theme_controller.dart';
import 'package:fcfs_banking_app/src/controllers/user_controller.dart';
import 'package:fcfs_banking_app/src/views/widget/custom_app_bar.dart';
import 'package:fcfs_banking_app/src/views/widget/custom_button.dart';
import 'package:fcfs_banking_app/src/views/widget/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class RewardScreeen extends StatefulWidget {
  const RewardScreeen({super.key});

  @override
  State<RewardScreeen> createState() => _RewardScreeenState();
}

class _RewardScreeenState extends State<RewardScreeen> {
  TextEditingController rewardCouponController = TextEditingController();
  UserController userController = Get.find<UserController>();
  ReferralController referralController = Get.find<ReferralController>();
  final ThemeController themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final user = userController.user.value;
    return Scaffold(
      appBar: CustomAppBar(
        title: "Rewards",
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 2.h),
                  Text(
                    "Do you have referral code?",
                    style: theme.textTheme.displayMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 19.sp,
                    ),
                  ),
                  SizedBox(height: 0.4.h),
                  Text(
                    "You will receive \$5 credits if you use referral code",
                    style: theme.textTheme.displaySmall!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.white.withOpacity(0.7),
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    "Refferal Code",
                    style: theme.textTheme.displayMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 18.sp,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  TextfieldWidget(
                    label: "Refferal Code",
                    keyboardType: TextInputType.name,
                    controller: rewardCouponController,
                  ),
                  SizedBox(height: 2.h),
                  CustomButtonWidget(
                    onTap: () {
                      String referralCode = rewardCouponController.text.trim();
                      if (referralCode.isNotEmpty) {
                        referralController.redeemReferralCode(
                            user!.uid, referralCode);
                      } else {
                        // AppHelpers.toast("");
                      }
                    },
                    width: MediaQuery.of(context).size.width,
                    text: "Redeem",
                    isIconAvailable: false,
                    color: themeController.themeMode == ThemeMode.dark
                        ? AppColors.darkBorderColor
                        : AppColors.red,
                    borderColor: themeController.themeMode == ThemeMode.dark
                        ? AppColors.darkBorderColor
                        : AppColors.red,
                    textColor: AppColors.white,
                    radius: 10,
                    fontSize: 18.sp,
                  ),
                  SizedBox(height: 20.h),
                  Center(
                    child: Text(
                      "More Rewards coming soon ...",
                      style: theme.textTheme.displayMedium!.copyWith(
                        fontWeight: FontWeight.w300,
                        fontSize: 17.sp,
                        color: AppColors.white.withOpacity(0.7),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
