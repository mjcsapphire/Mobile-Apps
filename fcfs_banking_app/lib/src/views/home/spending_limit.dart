import 'package:fcfs_banking_app/core/theme/colors.dart';
import 'package:fcfs_banking_app/src/controllers/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class SpendingLimitCard extends StatelessWidget {
  final double limit;
  final double remaining;
  final VoidCallback onTap;

  SpendingLimitCard(
      {super.key,
      required this.limit,
      required this.remaining,
      required this.onTap,});

  final themeController = Get.find<ThemeController>();
  @override
  Widget build(BuildContext context) {
    double spent = limit - remaining;
    double percentage = (spent / limit).clamp(0.0, 1.0);

    return Container(
      padding: const EdgeInsets.all(15.0),
      width: 90.w,
      decoration: BoxDecoration(
        color: AppColors.transparent,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$${limit.toStringAsFixed(0)} Monthly limit | \$${remaining.toStringAsFixed(0)} left',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              GestureDetector(
                onTap: onTap,
                child: const Icon(
                  Icons.info_outline,
                  color: Colors.white70,
                  size: 20,
                ),
              ),
            ],
          ),
          SizedBox(height: 1.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: percentage,
              backgroundColor: AppColors.white,
              valueColor: AlwaysStoppedAnimation<Color>(
                themeController.themeMode == ThemeMode.dark
                    ? AppColors.darkTransferBgColor1
                    : const Color(0xFFFF6F61),
              ),
              minHeight: 8,
            ),
          ),
        ],
      ),
    );
  }
}
