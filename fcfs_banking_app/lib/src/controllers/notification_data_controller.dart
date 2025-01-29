import 'package:fcfs_banking_app/core/utils/app_helpers.dart';
import 'package:fcfs_banking_app/services/firebase/notification_data_service.dart';
import 'package:fcfs_banking_app/src/models/notification_model.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class NotificationDataController extends GetxController {
  final NotificationDataService _service = NotificationDataService();
  var logger = Logger();
  RxBool isLoading = false.obs;
  var notifications = <NotificationModel>[].obs;

  // Fetch all notifications
  Future<void> fetchNotification() async {
    isLoading.value = true;
    try {
      _service.fetchNotifications().listen((notificationList) {
        notifications.value = notificationList;
      });
    } catch (e) {
      logger.e('Error fetching notifications: $e');
      AppHelpers.toast("Error fetching notifications: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // Mark notification as read
  Future<void> markNotificationAsRead(String notificationId) async {
    try {
      await _service.updateNotificationReadStatus(notificationId);
      // Update local state
      int index = notifications.indexWhere((n) => n.id == notificationId);
      if (index != -1) {
        notifications[index] = notifications[index].copyWith(readStatus: true);
        notifications.refresh();
      }
    } catch (e) {
      logger.e('Error updating notification status: $e');
      AppHelpers.toast("Error updating notification status: $e");
    }
  }
}
