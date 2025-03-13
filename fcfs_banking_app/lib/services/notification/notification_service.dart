import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();

  factory NotificationService() {
    return _instance;
  }

  NotificationService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    // Request notification permission on Android 13+ and iOS
    if (await Permission.notification.isDenied) {
      await Permission.notification.request();
    }

    // iOS initialization
    DarwinInitializationSettings initializationSettingsIOS =
        const DarwinInitializationSettings(
            requestSoundPermission: true,
            requestBadgePermission: true,
            requestAlertPermission: true);

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    // Initialize local notifications
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) async {
        final payload = response.payload;
        if (payload != null) {
          _handleMessageRedirect(payload);
        }
      },
    );

    // Subscribe to foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _showNotification(message);
    });

    // Handle notification click when the app is in the background or terminated
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _handleMessageRedirect(jsonEncode(message.data));
    });

    // Handle notification click when the app is opened from a terminated state
    final RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      _handleMessageRedirect(jsonEncode(initialMessage.data));
    }
  }

  // Subscribe to a topic
  Future<void> subscribeToTopic(String topic) async {
    await FirebaseMessaging.instance.subscribeToTopic(topic);
  }

  // Unsubscribe from a topic
  Future<void> unsubscribeFromTopic(String topic) async {
    await FirebaseMessaging.instance.unsubscribeFromTopic(topic);
  }

  // Show a notification with optional image handling
  Future<void> _showNotification(RemoteMessage message) async {
    final String? imageUrl = message.data['imageUrl'];

    // If an image URL is provided, handle the image
    if (imageUrl != null) {
      try {
        final Uri? uri = Uri.tryParse(imageUrl);
        if (uri != null && uri.isAbsolute) {
          final Dio dio = Dio();
          final response = await dio.get<Uint8List>(
            imageUrl,
            options: Options(responseType: ResponseType.bytes),
          );

          final Uint8List imageBytes = response.data!;
          final BigPictureStyleInformation bigPictureStyleInformation =
              BigPictureStyleInformation(
            ByteArrayAndroidBitmap(imageBytes),
            largeIcon: ByteArrayAndroidBitmap(imageBytes),
            contentTitle: message.notification?.title ?? 'No Title',
            summaryText: message.notification?.body ?? 'No Body',
            htmlFormatContent: true,
            htmlFormatSummaryText: true,
          );

          final AndroidNotificationDetails androidPlatformChannelSpecifics =
              AndroidNotificationDetails(
            'your_channel_id', // Create unique channel ID
            'your_channel_name',
            importance: Importance.max,
            priority: Priority.high,
            styleInformation: bigPictureStyleInformation,
          );

          final DarwinNotificationDetails darwinPlatformChannelSpecifics =
              DarwinNotificationDetails(
            attachments: [
              DarwinNotificationAttachment(
                imageUrl,
                hideThumbnail: false,
                // thumbnailClippingRect: DarwinNotificationAttachmentThumbnailClippingRect(x: x, y: y, width: width, height: height)
                // You can specify additional parameters if needed
              ),
            ],
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          );

          final NotificationDetails platformChannelSpecifics =
              NotificationDetails(
                  android: androidPlatformChannelSpecifics,
                  iOS: darwinPlatformChannelSpecifics);

          await flutterLocalNotificationsPlugin.show(
            0,
            message.notification?.title ?? 'No Title',
            message.notification?.body ?? 'No Body',
            platformChannelSpecifics,
            payload: jsonEncode(message.data),
          );
        } else {
          debugPrint("Image is not a valid URL: $imageUrl");
        }
      } catch (e) {
        debugPrint("Failed to download image: $e");
      }
    } else {
      // Show notification without an image
      await flutterLocalNotificationsPlugin.show(
        0,
        message.notification?.title ?? 'No Title',
        message.notification?.body ?? 'No Body',
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'your_channel_id', // Unique channel ID
            'your_channel_name',
            importance: Importance.max,
            priority: Priority.high,
          ),
        ),
        payload: jsonEncode(message.data),
      );
    }
  }

  // Handle message redirection based on the notification payload
  void _handleMessageRedirect(String payload) async {
    debugPrint("Notification payload: $payload");

    final productId = jsonDecode(payload)['productId'] ?? 0;
    if (productId != null) {
      Future.delayed(const Duration(milliseconds: 500), () {
        // router.pushNamed(
        //   RoutesName.productdetails,
        //   pathParameters: {
        //     'productId': productId.toString(),
        //   },
        // );
      });
    } else {
      debugPrint("Product ID not found in noti fication payload");
    }
  }
}
