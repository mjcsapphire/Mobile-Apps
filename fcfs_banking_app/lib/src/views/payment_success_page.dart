import 'dart:async';

import 'package:fcfs_banking_app/core/theme/colors.dart';
import 'package:fcfs_banking_app/core/theme/radialBg.dart';
import 'package:fcfs_banking_app/core/utils/constant/app_assets_constant.dart';
import 'package:fcfs_banking_app/src/controllers/theme_controller.dart';
import 'package:fcfs_banking_app/src/views/bottom_nav_page.dart';
import 'package:fcfs_banking_app/src/views/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class PaymentConfirmation extends StatefulWidget {
  const PaymentConfirmation({
    super.key,
  });

  @override
  _PaymentConfirmationState createState() => _PaymentConfirmationState();
}

class _PaymentConfirmationState extends State<PaymentConfirmation> {
  final themeController = Get.find<ThemeController>();
  int _countdown = 6;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countdown > 1) {
        setState(() {
          _countdown--;
        });
      } else {
        _navigateToMainPage();
        timer.cancel();
      }
    });
  }

  void _navigateToMainPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const MainPage(initialIndex: 0),
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  AppAssetsConstant.applogo,
                  width: MediaQuery.of(context).size.width * 0.6,
                  color: themeController.themeMode == ThemeMode.dark
                      ? AppColors.white
                      : AppColors.red,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 3.h),
                Text(
                  "Transaction Successful",
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: themeController.themeMode == ThemeMode.dark
                            ? AppColors.white
                            : AppColors.white,
                      ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 2.h),
                Text(
                  "Redirecting in $_countdown seconds...",
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: themeController.themeMode == ThemeMode.dark
                        ? AppColors.white
                        : AppColors.white,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 5.h),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: CustomButtonWidget(
                onTap: _navigateToMainPage,
                width: 88.w,
                text: "Done",
                isIconAvailable: false,
                radius: 8,
                color: themeController.themeMode == ThemeMode.dark
                    ? AppColors.darkBorderColor
                    : AppColors.red,
                borderColor: themeController.themeMode == ThemeMode.dark
                    ? AppColors.darkBorderColor
                    : AppColors.red,
                fontSize: 18.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
