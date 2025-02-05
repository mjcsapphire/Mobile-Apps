import 'package:fcfs_banking_app/core/theme/colors.dart';
import 'package:fcfs_banking_app/core/theme/radialBg.dart';
import 'package:fcfs_banking_app/core/utils/app_helpers.dart';
import 'package:fcfs_banking_app/services/router/routes_name.dart';
import 'package:fcfs_banking_app/src/controllers/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:sizer/sizer.dart';

class ChoosePaymentMethod extends StatefulWidget {
  const ChoosePaymentMethod({super.key});

  @override
  State<ChoosePaymentMethod> createState() => _ChoosePaymentMethodState();
}

class _ChoosePaymentMethodState extends State<ChoosePaymentMethod> {
  final themeController = Get.find<ThemeController>();

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
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ChooseBillingMethod(
                  title: 'Tap card on phone',
                  onTap: () {
                    AppHelpers.toast("please check your phone for payment");
                  },
                ),
                SizedBox(height: 3.h),
                ChooseBillingMethod(
                  title: 'Send to terminal ',
                  onTap: () {
                    context.pushNamed(RoutesName.externalTermialPayment);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChooseBillingMethod extends StatelessWidget {
  ChooseBillingMethod({
    required this.title,
    required this.onTap,
    super.key,
  });

  final String title;
  final VoidCallback onTap;
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: themeController.themeMode == ThemeMode.dark
              ? AppColors.darkStackContainerBackground
              : AppColors.stackContainerBackground2,
          borderRadius: BorderRadius.circular(8),
          border: themeController.themeMode == ThemeMode.dark ?  const GradientBoxBorder(
                      gradient: LinearGradient(
                        colors: [AppColors.darkBgColor2, AppColors.purple],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      width: 2,
                    ) :  const GradientBoxBorder(
            gradient: LinearGradient(
              colors: [AppColors.white, AppColors.red],
              end: Alignment.topLeft,
              begin: Alignment.bottomRight,
            ),
            width: 2,
          ),
        ),
        child: Text(
          title,
          style: theme.textTheme.displayMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
