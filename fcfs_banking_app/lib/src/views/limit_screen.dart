import 'package:fcfs_banking_app/core/theme/colors.dart';
import 'package:fcfs_banking_app/src/controllers/theme_controller.dart';
import 'package:fcfs_banking_app/src/controllers/transaction_controller.dart';
import 'package:fcfs_banking_app/src/controllers/user_controller.dart';
import 'package:fcfs_banking_app/src/views/widget/slider_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

class TransferLimitScreen extends StatelessWidget {
  TransferLimitScreen({super.key});

  final themeController = Get.find<ThemeController>();
  final transactionController = Get.find<TransactionController>();
  final userController = Get.find<UserController>();

  final RxDouble dailyLimit = 5000.0.obs; // Default value
  final RxDouble monthlyLimit = 8000.0.obs; // Default value

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: themeController.themeMode == ThemeMode.dark
                  ? AppColors.darkAppBarGradient
                  : AppColors.background,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 5.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: AppColors.white,
                      ),
                      onPressed: () {
                        context.pop();
                      },
                    ),
                    Text('Set transfer limits',
                        style: theme.textTheme.displayMedium),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                  ],
                ),
                SizedBox(height: 3.h),
                TransferLimitCard(
                  title: 'PER TRANSFER',
                  minValue: 100,
                  maxValue: 10000,
                  initialRange: const RangeValues(100, 5000),
                  onRangeChanged: (value) {
                    dailyLimit.value = value.end;
                  },
                ),
                SizedBox(height: 3.h),
                TransferLimitCard(
                  title: 'MONTHLY',
                  minValue: 100,
                  maxValue: 10000,
                  initialRange: const RangeValues(100, 8000),
                  onRangeChanged: (value) {
                    monthlyLimit.value = value.end;
                  },
                ),
                const Spacer(),
                SlideButton(onPanEnd: (position) {
                  transactionController.setDailyLimit(
                      dailyLimit.value, userController);
                  transactionController.setMonthlyLimit(
                      monthlyLimit.value, userController);
                }),
                SizedBox(height: 5.h)
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TransferLimitCard extends StatelessWidget {
  final String title;
  final double minValue;
  final double maxValue;
  final RangeValues initialRange;
  final Function(RangeValues) onRangeChanged;

  TransferLimitCard({
    required this.title,
    required this.minValue,
    required this.maxValue,
    required this.initialRange,
    required this.onRangeChanged,
    super.key,
  });

  final Rx<RangeValues> _rangeValues =
      Rx<RangeValues>(const RangeValues(100, 10000));

  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    _rangeValues.value = initialRange;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: themeController.themeMode == ThemeMode.dark
            ? AppColors.darkStackContainerBackground
            : AppColors.stackContainerBackground,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(title, style: theme.textTheme.displayMedium),
          const SizedBox(height: 10),
          Obx(
            () => Text(
              '\$${_rangeValues.value.end.toStringAsFixed(0)}',
              style: theme.textTheme.displayMedium,
            ),
          ),
          const SizedBox(height: 10),
          Obx(
            () => RangeSlider(
              values: _rangeValues.value,
              min: minValue,
              max: maxValue,
              activeColor: Colors.blue,
              inactiveColor: Colors.white54,
              divisions: 100,
              onChanged: (RangeValues values) {
                _rangeValues.value = values;
                onRangeChanged(values);
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('\$$minValue', style: theme.textTheme.displayMedium),
              Text('\$$maxValue', style: theme.textTheme.displayMedium),
            ],
          ),
        ],
      ),
    );
  }
}
