import 'package:fcfs_banking_app/core/theme/colors.dart';
import 'package:fcfs_banking_app/core/theme/radialBg.dart';
import 'package:fcfs_banking_app/services/router/routes_name.dart';
import 'package:fcfs_banking_app/src/controllers/direct_debit_controller.dart';
import 'package:fcfs_banking_app/src/controllers/theme_controller.dart';
import 'package:fcfs_banking_app/src/controllers/user_controller.dart';
import 'package:fcfs_banking_app/src/views/widget/custom_app_bar.dart';
import 'package:fcfs_banking_app/src/views/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class PersonalDirectDebitDashboard extends StatelessWidget {
  final DirectDebitController controller = Get.put(DirectDebitController());
  final UserController userController = Get.find<UserController>();
  final ThemeController themeController = Get.find<ThemeController>();

  PersonalDirectDebitDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final user = userController.user.value;
    final theme = Theme.of(context);

    // Fetch requests on dashboard load
    controller.fetchRequests(user!.uid, 'personal');

    return Scaffold(
      appBar: CustomAppBar(
        title: "Direct Debit",
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
                    return const Center(
                      child: Text(
                        "No Direct Debit Requests",
                        style: TextStyle(color: AppColors.white),
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
                              .fetchUserName(request['businessUserId']),
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
                                padding: EdgeInsets.symmetric(vertical: 1.h),
                                child: ListTile(
                                  title: Text(
                                    "To: $businessName",
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
                                        "Type: ${request['requestType']}",
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
                                          "Next due on : ${DateFormat('dd-MM-yyyy').format(DateTime.parse(request['nextPaymentDate']))}",
                                          style: theme.textTheme.displayMedium
                                              ?.copyWith(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                    ],
                                  ),
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
              SizedBox(height: 1.h),
              CustomButtonWidget(
                onTap: () {
                  context.pushNamed(RoutesName.newDirectDebitRequestScreen);
                },
                width: MediaQuery.of(context).size.width * 0.9,
                text: user.role == 'Personal'
                    ? "Request new standing order"
                    : "Request new direct debit",
                fontSize: 18.sp,
                isIconAvailable: false,
                color: themeController.themeMode == ThemeMode.dark
                    ? AppColors.darkBorderColor
                    : AppColors.red,
                borderColor: themeController.themeMode == ThemeMode.dark
                    ? AppColors.darkBorderColor
                    : AppColors.red,
                radius: 8,
              ),
              SizedBox(height: 1.h),
            ],
          ),
        ],
      ),
    );
  }

  /// Helper function to determine status color
  Color getStatusColor(String status) {
    switch (status) {
      case 'Approved':
        return Colors.green;
      case 'Rejected':
        return Colors.red;
      default:
        return Colors.orange; // Pending
    }
  }
}
