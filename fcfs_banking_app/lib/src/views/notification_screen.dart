import 'package:fcfs_banking_app/core/theme/colors.dart';
import 'package:fcfs_banking_app/core/utils/constant/app_assets_constant.dart';
import 'package:fcfs_banking_app/src/views/widget/custom_app_bar.dart';
import 'package:fcfs_banking_app/src/views/widget/custom_list_tile.dart';
import 'package:fcfs_banking_app/src/views/widget/dummy/notification_data.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  Map<String, List<Map<String, dynamic>>> groupNotificationsByDate() {
    Map<String, List<Map<String, dynamic>>> groupedNotifications = {};
    DateTime now = DateTime.now();

    for (var notification in notificationData) {
      final time = notification['time'] as DateTime;
      final difference = now.difference(time).inDays;

      String key;
      if (difference == 0) {
        key = 'Today';
      } else if (difference == 1) {
        key = 'Yesterday';
      } else {
        key = timeago.format(time);
      }

      if (!groupedNotifications.containsKey(key)) {
        groupedNotifications[key] = [];
      }
      groupedNotifications[key]!.add(notification);
    }

    return groupedNotifications;
  }

  @override
  Widget build(BuildContext context) {
    final groupedNotifications = groupNotificationsByDate();
    return Scaffold(
      appBar: CustomAppBar(
        title: "Notifications",
        showMoreVertIcon: false,
        showNotificationIcon: false,
        showProfilePic: false,
        onMoreVertTap: () {},
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppAssetsConstant.upperBackground),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: AppColors.black,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: ListView(
                      padding: const EdgeInsets.all(8.0),
                      children: groupedNotifications.entries.map((entry) {
                        return _notificationGroupWidget(entry.key, entry.value);
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _notificationGroupWidget(
      String groupTitle, List<Map<String, dynamic>> notifications) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            groupTitle,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
            
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.textGreyColor, width: 1)
            ),
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Render each notification as a ListTile within the container
                ...notifications.map((notification) {
                  return CustomListTile(
                    title:
                        "${notification['message'] + " " + notification['amount']}",
                    subtitle: timeago.format(notification['time']),
                    leading: const Icon(Icons.swap_horiz, color: Colors.orange),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
