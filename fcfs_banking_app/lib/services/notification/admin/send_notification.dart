import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcfs_banking_app/services/notification/admin/admin_fcm.dart';
import 'package:fcfs_banking_app/src/models/user_model.dart';
import 'package:http/http.dart';
import 'package:logger/logger.dart';

class SendNotification {
  Future<void> sendPushNotification(
      UserModel sender, UserModel receiver, String message) async {
    try {
      final body = {
        "message": {
          "token": receiver.fcmToken,
          "notification": {
            "title": "New notification from ${sender.firstName}",
            "body": message,
          },
          // data is used to send custom key value pairs
          "data": {
            "senderId": sender.uid,
            "senderName": sender.firstName,
            "recipientId": receiver.uid,
          }
        }
      };

      // print('Notification Body: $body');
      Logger().i(('Notification Body: $body'));
      const projectID = 'fantasy-banking-app';
      final bearerToken = await AdminFCMService.getToken;
      // print('Bearer Token: $bearerToken');

      if (bearerToken == null) return;

      var res = await post(
        Uri.parse(
            'https://fcm.googleapis.com/v1/projects/$projectID/messages:send'),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer $bearerToken'
        },
        body: jsonEncode(body),
      );

      print('Response status: ${res.statusCode}');
      print('Response body: ${res.body}');

      await FirebaseFirestore.instance.collection('notifications').add({
        'senderId': sender.uid,
        'senderName': sender.firstName,
        'receiverid': receiver.uid,
        'receiverName': receiver.firstName,
        'message': message,
        'readStatus': false,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      Logger().e(('Error sending notification: $e'));
    }
  }
}
