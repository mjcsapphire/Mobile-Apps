import 'package:fcfs_banking_app/core/theme/colors.dart';
import 'package:fcfs_banking_app/core/theme/radialBg.dart';
import 'package:fcfs_banking_app/core/utils/constant/app_assets_constant.dart';
import 'package:fcfs_banking_app/services/router/routes_name.dart';
import 'package:fcfs_banking_app/src/controllers/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:sizer/sizer.dart';

class InitialTerminalPayment extends StatefulWidget {
  const InitialTerminalPayment({super.key});

  @override
  State<InitialTerminalPayment> createState() => _InitialTerminalPaymentState();
}

class _InitialTerminalPaymentState extends State<InitialTerminalPayment> {
  final themeController = Get.find<ThemeController>();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
                Text('Payment via external terminal',
                    style: theme.textTheme.displayMedium),
                SizedBox(height: 6.h),
                ExternalTermialBox(
                  title: 'Tap card on phone',
                  onTap: () {},
                  subtitle: 'Processing payment...',
                ),
                SizedBox(height: 5.h),
                TextButton(
                  onPressed: () {
                    context.pop();
                  },
                  child: Text(
                    'Cancel transaction',
                    style: theme.textTheme.displayMedium,
                  ),
                ),
                // TextButton(
                //   onPressed: () {
                //     context.pushNamed(RoutesName.paymentReceiptStatus);
                //   },
                //   child: Text(
                //     'Check payemt',
                //     style: theme.textTheme.displayMedium,
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ExternalTermialBox extends StatefulWidget {
  const ExternalTermialBox({
    required this.title,
    required this.subtitle,
    required this.onTap,
    super.key,
  });

  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  State<ExternalTermialBox> createState() => _ExternalTermialBoxState();
}

class _ExternalTermialBoxState extends State<ExternalTermialBox> {
  final themeController = Get.find<ThemeController>();
  // Initially, show "Tap card on phone"
  bool showTitle = true;

  @override
  void initState() {
    super.initState();
    // After 5 seconds, hide "Tap card on phone"
    Future.delayed(const Duration(seconds: 6), () {
      if (mounted) {
        setState(() {
          showTitle = false;
        });
      }

      Future.delayed(const Duration(seconds: 5), () {
        if (mounted) {
          context.pushNamed(RoutesName.paymentReceiptStatus);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: themeController.themeMode == ThemeMode.dark
              ? AppColors.transparent
              : AppColors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: themeController.themeMode == ThemeMode.dark
              ? const GradientBoxBorder(
                  gradient: LinearGradient(
                    colors: [AppColors.darkBgColor2, AppColors.purple],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  width: 2,
                )
              : const GradientBoxBorder(
                  gradient: LinearGradient(
                    colors: [AppColors.white, AppColors.red],
                    end: Alignment.topLeft,
                    begin: Alignment.bottomRight,
                  ),
                  width: 2,
                ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (showTitle)
              Text(
                widget.title,
                style: theme.textTheme.displayMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            SizedBox(height: 1.h),
            Image(
              image: const AssetImage(AppAssetsConstant.applogo),
              height: 20.h,
              color: themeController.themeMode == ThemeMode.dark
                  ? AppColors.white
                  : AppColors.red,
            ),
            SizedBox(height: 1.h),
            if (!showTitle)
              Text(
                widget.subtitle,
                style: theme.textTheme.displayMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
          ],
        ),
      ),
    );
  }
}
