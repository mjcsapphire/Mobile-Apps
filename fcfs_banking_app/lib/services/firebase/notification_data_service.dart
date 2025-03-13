import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcfs_banking_app/src/models/notification_model.dart';

class NotificationDataService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fetch notifications
  Stream<List<NotificationModel>> fetchNotifications() {
    return _firestore
        .collection('notifications')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return NotificationModel.fromMap(doc.data(), doc.id); // Pass doc.id
      }).toList();
    });
  }

  // Update notification read status
  Future<void> updateNotificationReadStatus(String notificationId) async {
    try {
      await _firestore
          .collection('notifications')
          .doc(notificationId)
          .update({'readStatus': true});
    } catch (e) {
      throw Exception('Failed to update notification read status: $e');
    }
  }
}
