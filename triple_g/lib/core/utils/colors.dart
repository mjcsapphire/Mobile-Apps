import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Color(0xFFF8B918);
  static const Color secondaryColor = Color(0xFF333333);
  static const Color tertiaryColor = Color(0xFF282828);
  static const Color quaternaryColor = Color(0xFFFF3939);
  static const Color quinternaryColor = Color(0xFFFFFFFF);

  static const Color lightPrimaryColor = Color(0xFFffed8f);
  static const Color buttonBackground = Color(0xFFffe76c);

  static const Color scaffoldColor = Color(0xFFF2F2F2);
  static const Color labelColor = Color(0xFF9d9d9d);

  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color grey = Color(0xFF9E9E9E);

  static const Color red = Color(0xFFE53935);
  static const Color green = Color(0xFF43A047);
  static const Color transparent = Color(0x00000000);

  static const Color darkGrey = Color(0xFF333333);
  static const Color lightGrey = Color(0xFFE6E6E6);
  static const Color darkBlue = Color(0xFF0D47A1);

  static const Color lightBlueteal = Color.fromARGB(255, 168, 239, 255);
  static const Color lightBlueteal2 = Color.fromARGB(255, 57, 219, 255);
}

class GGredients {
  static LinearGradient splashGredient = const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      AppColors.lightPrimaryColor,
      AppColors.scaffoldColor,
    ],
  );
  static LinearGradient socialPostCardGradient(
          Color color, Alignment alignmentBegin, Alignment alignmentEnd) =>
      LinearGradient(
        begin: alignmentBegin,
        end: alignmentEnd,
        colors: [
          color,
          AppColors.white,
          AppColors.white,
          AppColors.white,
          AppColors.white,
        ],
      );
}
