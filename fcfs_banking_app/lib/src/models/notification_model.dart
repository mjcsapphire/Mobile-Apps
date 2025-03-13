import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  final String id;
  final String senderId;
  final String receiverId;
  final String senderName;
  final String receiverName;
  final String message;
  final bool readStatus;
  final DateTime timestamp;

  NotificationModel({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.senderName,
    required this.receiverName,
    required this.message,
    required this.timestamp,
    this.readStatus = false,
  });

  factory NotificationModel.fromMap(Map<String, dynamic> data, String id) {
    try {
      return NotificationModel(
          id: id,
          senderId: data['senderId'] ?? '',
          receiverId: data['receiverid'] ?? '',
          senderName: data['senderName'] ?? '',
          receiverName: data['receiverName'] ?? '',
          message: data['message'] ?? '',
          readStatus: data['readStatus'] ?? false,
          timestamp: (data['timestamp'] as Timestamp).toDate());
    } catch (e) {
      throw Exception("Error parsing notification data: $e\nData: $data");
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'senderName': senderName,
      'receiverName': receiverName,
      'message': message,
      'readStatus': readStatus,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  // Copy method
  NotificationModel copyWith({
    String? id,
    String? senderId,
    String? receiverId,
    String? senderName,
    String? receiverName,
    String? message,
    bool? readStatus,
    DateTime? timestamp,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      senderId: senderId ?? this.senderId,
      receiverId: receiverId ?? this.receiverId,
      senderName: senderName ?? this.senderName,
      receiverName: receiverName ?? this.receiverName,
      message: message ?? this.message,
      readStatus: readStatus ?? this.readStatus,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}
