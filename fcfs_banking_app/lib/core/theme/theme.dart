import 'package:fcfs_banking_app/core/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    primaryColor: AppColors.red,
    scaffoldBackgroundColor: AppColors.backgroundColor,
    splashColor: Colors.black,
    colorScheme: const ColorScheme.light(),
    iconTheme: const IconThemeData(color: AppColors.black),
    fontFamily: 'Montserrat',
    appBarTheme: AppBarTheme(
      elevation: 0.5,
      backgroundColor: AppColors.backgroundColor,
      surfaceTintColor: Colors.transparent,
      foregroundColor: AppColors.white,
      iconTheme: IconThemeData(color: AppColors.white, size: 3.5.h),
      titleTextStyle: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 18.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.white,
      ),
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: AppColors.black,
      selectionColor: AppColors.red,
    ),
    textTheme: TextTheme(
      displayLarge: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.white,
      ),
      displayMedium: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 18.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.white,
      ),
      displaySmall: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.white,
      ),
      headlineLarge: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 24.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.white,
      ),
      headlineMedium: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 22.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.white,
      ),
      headlineSmall: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 20.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.white,
      ),
      titleLarge: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.white,
      ),
      titleMedium: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 11.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.white,
      ),
      titleSmall: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 10.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.white,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 12.sp,
        fontWeight: FontWeight.normal,
        color: AppColors.white,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 10.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.white,
      ),
      bodySmall: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 8.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.white,
      ),
      labelLarge: TextStyle(
        fontFamily: 'Montserrat',
        color: AppColors.white,
        fontSize: 12.sp,
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    primaryColor: AppColors.blueDark,
    scaffoldBackgroundColor: AppColors.black,
    colorScheme: const ColorScheme.dark(),
    iconTheme: const IconThemeData(color: AppColors.white),
    fontFamily: 'Montserrat',
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: AppColors.white,
      selectionColor: AppColors.blueDark,
    ),
    textTheme: TextTheme(
      displayLarge: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.white,
      ),
      displayMedium: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 18.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.white,
      ),
      displaySmall: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.white,
      ),
      headlineLarge: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 24.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.white,
      ),
      headlineMedium: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 22.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.white,
      ),
      headlineSmall: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 20.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.white,
      ),
      titleLarge: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 12.5.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.white,
      ),
      titleMedium: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 11.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.white,
      ),
      titleSmall: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 10.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.white,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 12.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.white,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 10.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.white,
      ),
      bodySmall: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 8.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.white,
      ),
      labelLarge: TextStyle(
        fontFamily: 'Montserrat',
        color: AppColors.white,
        fontSize: 12.sp,
      ),
    ),
  );
}
