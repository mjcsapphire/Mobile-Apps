import 'package:fcfs_banking_app/core/theme/colors.dart';
import 'package:fcfs_banking_app/src/controllers/theme_controller.dart';
import 'package:fcfs_banking_app/src/views/widget/slider_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

class TopUpAccountScreen extends StatefulWidget {
  const TopUpAccountScreen({super.key});

  @override
  TopUpAccountScreenState createState() => TopUpAccountScreenState();
}

class TopUpAccountScreenState extends State<TopUpAccountScreen> {
  String? _selectedFromAccount;
  String? _selectedToAccount;
  final TextEditingController _amountController = TextEditingController();
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: AppColors.darkBgColor1,
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
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
            child: SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height - 10.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 2.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back_ios),
                          onPressed: () {
                            context.pop();
                          },
                          color: Colors.white,
                        ),
                        Text(
                          'Top Up',
                          style: theme.textTheme.displayMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 10.w),
                      ],
                    ),
                    SizedBox(height: 2.h),
                    Container(
                      width: MediaQuery.of(context).size.width - 20.w,
                      decoration: BoxDecoration(
                        gradient: themeController.themeMode == ThemeMode.dark
                            ? AppColors.darkStackContainerBackground
                            : AppColors.stackContainerBackground,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text("From",
                                  style: theme.textTheme.displayMedium),
                              // SizedBox(width: 5.w),
                              _buildDropdownCard(context, 'Select Account',
                                  _selectedFromAccount, (value) {
                                setState(() {
                                  _selectedFromAccount = value;
                                });
                              }),
                            ],
                          ),
                          Divider(
                            color: AppColors.white,
                            thickness: 0.5,
                            indent: 4.w,
                            endIndent: 4.w,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text("To", style: theme.textTheme.displayMedium),
                              // SizedBox(width: 5.w),
                              _buildDropdownCard(
                                  context, 'Select Account', _selectedToAccount,
                                  (value) {
                                setState(() {
                                  _selectedToAccount = value;
                                });
                              }),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 4.h),
                    _buildAmountInput(context),
                    SizedBox(height: 4.h),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 21.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'When',
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          Text(
                            'Today',
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          Icon(
                            Icons.calendar_month,
                            color: AppColors.white,
                            size: 3.h,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 4.h),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 21.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Repeat',
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          Text(
                            'Doesn\'t repeat',
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          Text(
                            '',
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                    ),
                    // _buildSchedule(context),
                    const Spacer(),
                    SlideButton(onPanEnd: (position) {}),
                    SizedBox(height: 5.h),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownCard(BuildContext context, String title,
      String? selectedValue, Function(String?) onChanged) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: AppColors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedValue,
          dropdownColor: themeController.themeMode == ThemeMode.dark
              ? AppColors.darkBgColor1
              : AppColors.red,
          icon: const Icon(Icons.arrow_drop_down, color: AppColors.white),
          style: Theme.of(context).textTheme.displayMedium,
          items: ['Account 1', 'Account 2', 'Account 3']
              .map((String account) => DropdownMenuItem<String>(
                    value: account,
                    child: Text(account),
                  ))
              .toList(),
          onChanged: onChanged,
          hint: Text(
            title,
            style: Theme.of(context).textTheme.displayMedium,
          ),
        ),
      ),
    );
  }

  Widget _buildAmountInput(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 20.w,
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
      decoration: BoxDecoration(
        gradient: themeController.themeMode == ThemeMode.dark
            ? AppColors.darkStackContainerBackground
            : AppColors.stackContainerBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: _amountController,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headlineLarge,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: '\$0.00',
          hintStyle: Theme.of(context).textTheme.headlineLarge,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
