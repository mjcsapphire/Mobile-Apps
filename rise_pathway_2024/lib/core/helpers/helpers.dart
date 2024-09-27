import 'dart:math';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:rise_pathway/core/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

const deviceWidth = 360;
const deviceHeight = 800;

var logger = Logger(
    printer: PrettyPrinter(
  methodCount: 2,
  errorMethodCount: 8,
  lineLength: 50,
  colors: true,
  printEmojis: true,
));

enum RequestType { get, post, delete }

enum LoggerType { d, e, i, w }

List<String> moods = [
  'happy',
  'sad',
  'angry',
  'neutral',
  'confused',
  'laughing',
  'scared',
  'wink',
  'cry',
  'sick',
  'fear',
  'surprise',
  'enjoyment',
];

class Helpers {
  static final calendarDecoration = BoxDecoration(
    color: AppColors.white,
    borderRadius: BorderRadius.circular(8),
    shape: BoxShape.rectangle,
  );

  static Future<String?> getString({required String key}) async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    final str = sharedPref.getString(key);
    return str;
  }

  static setString({required String key, required String value}) async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    await sharedPref.setString(key, value);
  }

  ///[Random Color]
  static Color getColorFromName(String name) {
    final hash = name.hashCode;
    final random = Random(hash);
    final r = 200 + random.nextInt(60);
    final g = 200 + random.nextInt(60);
    final b = 200 + random.nextInt(60);
    return Color.fromARGB(255, r, g, b);
  }

  ///[Divider's]
  static Container customDivider({
    required double thickness,
    required double secondThickness,
  }) {
    return Container(
      width: 90.w,
      margin: EdgeInsets.symmetric(vertical: 1.h),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: thickness,
            width: 50.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColors.lighterGrey,
            ),
          ),
          Container(
            height: secondThickness,
            width: 25.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColors.lighterGrey,
            ),
          ),
        ],
      ),
    );
  }

  /// [Validator's]
  static String? validateEmail({required String text}) {
    RegExp emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    bool isValid = emailRegExp.hasMatch(text);

    if (text.isEmpty) {
      return 'Email is required!';
    }

    if (!isValid) {
      return 'Please enter a valid email!';
    }
    return null;
  }

  static String? validatePassword({required String text}) {
    RegExp passwordRegExp =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$');
    bool isValid = passwordRegExp.hasMatch(text);

    if (text.isEmpty) {
      return 'Please enter a password!';
    }

    if (text.length < 8) {
      return 'Password must be at least 8 characters!';
    }

    if (!text.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>\-_=+\/]'))) {
      return 'at least one symbol!';
    }

    if (!text.contains(RegExp(r'[A-Z]'))) {
      return 'at least one uppercase letter!';
    }

    if (!text.contains(RegExp(r'[a-z]'))) {
      return 'at least one lowercase letter!';
    }
    if (!text.contains(RegExp(r'[0-9]'))) {
      return 'at least one number!';
    }

    if (!isValid) {
      return 'Password must contain at least one uppercase letter, one lowercase letter, and one number!';
    }

    return null;
  }
}

class RiseText extends StatelessWidget {
  const RiseText(
    this.data, {
    super.key,
    this.textAlign,
    this.style,
    this.maxLines,
    this.width,
    this.textDecoration,
    this.overflow,
  });
  final String data;
  final TextAlign? textAlign;
  final TextStyle? style;
  final int? maxLines;
  final double? width;
  final TextOverflow? overflow;
  final TextDecoration? textDecoration;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Text(
        data,
        textScaler: TextScaler.noScaling,
        overflow: overflow,
        textAlign: textAlign,
        maxLines: maxLines,
        style: style,
      ),
    );
  }
}
