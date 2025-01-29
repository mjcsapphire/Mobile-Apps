import 'package:fcfs_banking_app/core/theme/colors.dart';
import 'package:fcfs_banking_app/core/theme/radialBg.dart';
import 'package:fcfs_banking_app/core/utils/app_helpers.dart';
import 'package:fcfs_banking_app/services/router/routes_name.dart';
import 'package:fcfs_banking_app/src/controllers/theme_controller.dart';
import 'package:fcfs_banking_app/src/controllers/transaction_controller.dart';
import 'package:fcfs_banking_app/src/models/transactions_model.dart';
import 'package:fcfs_banking_app/src/views/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

class TransactionDetailsScreen extends StatefulWidget {
  final TransactionModel transaction;
  const TransactionDetailsScreen({super.key, required this.transaction});

  @override
  State<TransactionDetailsScreen> createState() =>
      _TransactionDetailsScreenState();
}

class _TransactionDetailsScreenState extends State<TransactionDetailsScreen> {
  TransactionController transactionController =
      Get.find<TransactionController>();
  final themeController = Get.find<ThemeController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Transaction Details',
        showMoreVertIcon: false,
        showNotificationIcon: true,
        showProfilePic: false,
        onNotificationTap: () {
          context.pushNamed(RoutesName.notificationScreen);
        },
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
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            // decoration: const BoxDecoration(
            //   color: AppColors.black,
            //   borderRadius: BorderRadius.only(
            //     topLeft: Radius.circular(25),
            //     topRight: Radius.circular(25),
            //   ),
            // ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 5.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.transaction.description!,
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium
                                ?.copyWith(fontWeight: FontWeight.w600)),
                        SizedBox(height: 1.h),
                        Text(AppHelpers.formatDate(widget.transaction.date),
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall
                                ?.copyWith(color: AppColors.white)),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                            '\$${widget.transaction.amount.toStringAsFixed(2)}',
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium
                                ?.copyWith(
                                    color: AppColors.white,
                                    fontWeight: FontWeight.w600)),
                        SizedBox(height: 1.h),
                        Text('${widget.transaction.type}',
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall
                                ?.copyWith(color: AppColors.white)),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Transaction Details Section
                Text('Transaction Information ',
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        fontFamily: "Montserrat", fontWeight: FontWeight.w600)),
                const SizedBox(height: 16),
                buildDetailRow('Transaction cleared date',
                    AppHelpers.formatDate(widget.transaction.date)),
                buildDetailRow('Retailer location', 'uk'),
                buildDetailRow('Business type', 'Misc'),
                buildDetailRow('Card ending', '1223'),
                buildDetailRow(
                    'Balance after transaction',
                    transactionController.totalBalance.value
                        .toStringAsFixed(2)),

                SizedBox(height: 5.h),

                // Center(
                //   child: Text('More transactions from Amazon INC',
                //       style: Theme.of(context).textTheme.displaySmall),
                // ),
                const Spacer(),
                Center(
                  child: TextButton(
                    onPressed: () {
                      context.pushNamed(RoutesName.helpSupportScreen);
                    },
                    child: Text('Help with this transaction?',
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall
                            ?.copyWith(color: AppColors.white)),
                  ),
                ),
                SizedBox(height: 2.h)
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to build rows for transaction details
  Widget buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.white.withOpacity(0.7)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title,
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      color: AppColors.white.withOpacity(0.7),
                      fontWeight: FontWeight.w600,
                      fontSize: 16.sp,
                    )),
            Text(value,
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      color: AppColors.white.withOpacity(0.7),
                      fontWeight: FontWeight.w600,
                      fontSize: 16.sp,
                    )),
          ],
        ),
      ),
    );
  }
}
