import 'package:fcfs_banking_app/core/theme/colors.dart';
import 'package:fcfs_banking_app/core/theme/radialBg.dart';
import 'package:fcfs_banking_app/core/utils/constant/app_assets_constant.dart';
import 'package:fcfs_banking_app/src/controllers/direct_debit_controller.dart';
import 'package:fcfs_banking_app/src/controllers/theme_controller.dart';
import 'package:fcfs_banking_app/src/controllers/user_controller.dart';
import 'package:fcfs_banking_app/src/views/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class BusinessRequestDashboard extends StatelessWidget {
  final DirectDebitController controller = Get.find<DirectDebitController>();
  final UserController userController = Get.find<UserController>();
  final ThemeController themeController = Get.find<ThemeController>();

  BusinessRequestDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final user = userController.user.value;
    final theme = Theme.of(context);

    controller.fetchRequests(user!.uid, 'business');

    return Scaffold(
      appBar: CustomAppBar(
        title: "Direct Debit Requests",
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
          Column(
            children: [
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: themeController.themeMode == ThemeMode.dark
                            ? AppColors.white
                            : AppColors.pinkColor,
                      ),
                    );
                  }
                  if (controller.requests.isEmpty) {
                    return Center(
                      child: Text(
                        "No Direct Debit Requests",
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: controller.requests.length,
                    itemBuilder: (context, index) {
                      final request = controller.requests[index];
                      final status = request['status'];
                      final statusColor = getStatusColor(status);

                      return Card(
                        margin: EdgeInsets.symmetric(
                            horizontal: 2.w,
                            vertical: 1.h), // Add slight margins
                        color: AppColors.white.withOpacity(0.5),
                        child: FutureBuilder<String>(
                          future: userController
                              .fetchUserName(request['personalUserId']),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              // Shimmer Effect while loading
                              return Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: ListTile(
                                  title: Container(
                                    height: 2.h,
                                    color: Colors.grey,
                                  ),
                                  subtitle: Container(
                                    height: 2.h,
                                    color: Colors.grey,
                                  ),
                                ),
                              );
                            } else {
                              final businessName =
                                  snapshot.data ?? 'Unknown User';

                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 1.h), // Compact padding
                                child: ListTile(
                                  title: Text(
                                    "From: $businessName",
                                    style:
                                        theme.textTheme.displayMedium?.copyWith(
                                      fontFamily: "Montserrat",
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 0.6.h),
                                      Text(
                                        "Amount: \$${request['amount']}",
                                        style: theme.textTheme.displayMedium
                                            ?.copyWith(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 0.6.h),
                                      Text(
                                        "Status: $status",
                                        style: TextStyle(
                                          color: statusColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.sp,
                                        ),
                                      ),
                                      if (status == 'Approved' &&
                                          request
                                              .containsKey('nextPaymentDate'))
                                        Text(
                                          "Receive next payment on : ${DateFormat('dd-MM-yyyy').format(DateTime.parse(request['nextPaymentDate']))}",
                                          style: theme.textTheme.displayMedium
                                              ?.copyWith(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                    ],
                                  ),
                                  trailing: status == 'Pending'
                                      ? Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            IconButton(
                                              icon: Image.asset(
                                                  AppAssetsConstant
                                                      .paymentSuccess),
                                              onPressed: () => controller
                                                  .updateRequestStatus(
                                                      request['id'],
                                                      'Approved'),
                                            ),
                                            IconButton(
                                              icon: Image.asset(
                                                  AppAssetsConstant
                                                      .paymentFailed),
                                              onPressed: () => controller
                                                  .updateRequestStatus(
                                                      request['id'],
                                                      'Rejected'),
                                            ),
                                          ],
                                        )
                                      : null,
                                ),
                              );
                            }
                          },
                        ),
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color getStatusColor(String status) {
    switch (status) {
      case 'Approved':
        return Colors.green;
      case 'Rejected':
        return Colors.red;
      default:
        return Colors.orange;
    }
  }
}
