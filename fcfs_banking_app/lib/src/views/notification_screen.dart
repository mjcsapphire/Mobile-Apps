import 'package:fcfs_banking_app/core/theme/colors.dart';
import 'package:fcfs_banking_app/core/theme/radialBg.dart';
import 'package:fcfs_banking_app/core/utils/constant/app_assets_constant.dart';
import 'package:fcfs_banking_app/services/router/routes_name.dart';
import 'package:fcfs_banking_app/src/controllers/notification_data_controller.dart';
import 'package:fcfs_banking_app/src/controllers/theme_controller.dart';
import 'package:fcfs_banking_app/src/controllers/user_controller.dart';
import 'package:fcfs_banking_app/src/models/notification_model.dart';
import 'package:fcfs_banking_app/src/views/widget/custom_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import 'package:timeago/timeago.dart' as timeago;

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final NotificationDataController _controller =
      Get.find<NotificationDataController>();
  final UserController userController = Get.find<UserController>();
  final themeController = Get.find<ThemeController>();

  @override
  void initState() {
    super.initState();
    _controller.fetchNotification();
  }

  @override
  Widget build(BuildContext context) {
    String currentUserId = userController.user.value!.uid;

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
          SizedBox(
            height: MediaQuery.of(context).size.height,
            // decoration: BoxDecoration(
            //   gradient: AppColors.background2,
            // ),
            child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                margin: EdgeInsets.only(top: 7.h),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  gradient: themeController.themeMode == ThemeMode.dark
                      ? AppColors.darkNotificationBg
                      : AppColors.notificationBg,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.15),
                        Image.asset(
                          AppAssetsConstant.notification2,
                          height: 5.h,
                          width: 5.w,
                          color: AppColors.white,
                        ),
                        TextButton(
                          onPressed: () {
                            context.pop();
                          },
                          child: Text(
                            "close",
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium
                                ?.copyWith(
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                    Obx(() {
                      if (_controller.isLoading.value) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.pinkColor,
                          ),
                        );
                      }

                      // Filter notifications for the current user
                      final filteredNotifications = _controller.notifications
                          .where((notification) =>
                              notification.receiverId == currentUserId)
                          .toList();

                      if (filteredNotifications.isEmpty) {
                        return Expanded(
                          child: Center(
                              child: Text(
                            "No notifications available.",
                            style: Theme.of(context).textTheme.displayMedium,
                          )),
                        );
                      }
                      return Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.all(8.0),
                          itemCount: filteredNotifications.length,
                          itemBuilder: (context, index) {
                            NotificationModel notification =
                                filteredNotifications[index];

                            return GestureDetector(
                              onTap: () async {
                                // Mark as read on the backend
                                await _controller
                                    .markNotificationAsRead(notification.id);

                                // Re-fetch notifications for real-time update
                                await _controller.fetchNotification();

                                // Navigate to transaction screen
                                context.pushNamed(RoutesName.transactionScreen);
                              },
                              child: themeController.themeMode ==
                                      ThemeMode.light
                                  ? NotificationCustomListTile(
                                      readStatus: notification.readStatus
                                          ? "Read"
                                          : "Unread",
                                      border: Border.all(
                                        color: notification.readStatus
                                            ? AppColors.transparent
                                            : AppColors.white.withOpacity(0.5),
                                        width: 1,
                                      ),
                                      tileColor: notification.readStatus
                                          ? AppColors.white
                                          : AppColors.pinkColor,
                                      day: timeago
                                          .format(notification.timestamp),
                                      subtitle: notification.message,
                                      textColor: notification.readStatus
                                          ? AppColors.purple
                                          : AppColors.white,
                                    )
                                  : NotificationCustomListTile(
                                      readStatus: notification.readStatus
                                          ? "Read"
                                          : "Unread",
                                      border: Border.all(
                                        color: notification.readStatus
                                            ? AppColors.white.withOpacity(0.5)
                                            : AppColors.darkBorderColor,
                                        width:
                                            notification.readStatus ? 0.8 : 2,
                                      ),
                                      tileColor: notification.readStatus
                                          ? AppColors.transparent
                                          : AppColors.darkBgColor1,
                                      day: timeago
                                          .format(notification.timestamp),
                                      subtitle: notification.message,
                                      textColor: notification.readStatus
                                          ? AppColors.white
                                          : AppColors.white,
                                    ),
                            );
                          },
                        ),
                      );
                    }),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
