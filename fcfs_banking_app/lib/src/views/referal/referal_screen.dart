import 'package:fcfs_banking_app/core/theme/colors.dart';
import 'package:fcfs_banking_app/core/theme/radialBg.dart';
import 'package:fcfs_banking_app/core/utils/app_helpers.dart';
import 'package:fcfs_banking_app/core/utils/constant/app_assets_constant.dart';
import 'package:fcfs_banking_app/src/controllers/referral_controller.dart';
import 'package:fcfs_banking_app/src/controllers/theme_controller.dart';
import 'package:fcfs_banking_app/src/controllers/user_controller.dart';
import 'package:fcfs_banking_app/src/views/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class ReferralScreen extends StatefulWidget {
  const ReferralScreen({super.key});

  @override
  State<ReferralScreen> createState() => _ReferralScreenState();
}

class _ReferralScreenState extends State<ReferralScreen> {
  TextEditingController copiedTextController = TextEditingController();
  final ReferralController _referralController = Get.find<ReferralController>();
  UserController userController = Get.find<UserController>();
  final themeController = Get.find<ThemeController>();

  @override
  void initState() {
    super.initState();
    _referralController.fetchUserReferralCode(userController.user.value!.uid);
    if (_referralController.userReferralCode.value.isEmpty) {
      _referralController.initializeReferral(userController.user.value!.uid);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Refer & Earn",
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
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 6.h),
                Image.asset(
                  AppAssetsConstant.referalBg,
                ),
                Center(
                  child: Text(
                    "Get Free £5 ",
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(fontFamily: "Montserrat"),
                  ),
                ),
                SizedBox(height: 1.h),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 56),
                  child: Text(
                    "You and your friends earn cash reward when they signup and save with your referral link or code.",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ),
                const Spacer(),
                Text("Here is your referral code",
                    style: Theme.of(context).textTheme.displayMedium),
                SizedBox(height: 2.h),
                Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      decoration: BoxDecoration(
                        color: themeController.themeMode == ThemeMode.dark
                            ? AppColors.darkBorderColor
                            : AppColors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 12),
                            child: Obx(() {
                              final referralCode =
                                  _referralController.userReferralCode.value;
                              return Text(
                                referralCode.isEmpty
                                    ? "Loading..."
                                    : referralCode,
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium
                                    ?.copyWith(fontFamily: "Montserrat"),
                              );
                            }),
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () {
                              final referralCode =
                                  _referralController.userReferralCode.value;
                              if (referralCode.isNotEmpty) {
                                copiedTextController.text = referralCode;
                                Clipboard.setData(
                                    ClipboardData(text: referralCode));
                                AppHelpers.toast("Referral code copied");
                              }
                            },
                            icon: const Icon(
                              Icons.copy,
                              color: AppColors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      height: 5.7.h,
                      width: 30.w,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(
                              themeController.themeMode == ThemeMode.dark
                                  ? AppColors.darkBorderColor
                                  : AppColors.red),
                          shape: WidgetStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        onPressed: () {},
                        child: Text(
                          "  Invite      ",
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium
                              ?.copyWith(fontFamily: "Montserrat"),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
