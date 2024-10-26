import 'package:fcfs_banking_app/core/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.backgroundColor,
    splashColor: Colors.black,
    colorScheme: const ColorScheme.light(),
    iconTheme: const IconThemeData(color: AppColors.black),
    fontFamily: 'Roboto',
    appBarTheme: AppBarTheme(
      elevation: 0.5,
      backgroundColor: AppColors.backgroundColor,
      surfaceTintColor: Colors.transparent,
      iconTheme: IconThemeData(color: AppColors.white, size: 3.5.h),
      titleTextStyle: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 18.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.white,
      ),
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: AppColors.black,
      selectionColor: AppColors.primaryColor,
    ),
    textTheme: TextTheme(
      displayLarge: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.white,
      ),
      displayMedium: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 18.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.white,
      ),
      displaySmall: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.white,
      ),
      headlineLarge: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 24.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.white,
      ),
      headlineMedium: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 22.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.white,
      ),
      headlineSmall: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 20.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.white,
      ),
      titleLarge: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.white,
      ),
      titleMedium: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 11.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.white,
      ),
      titleSmall: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 10.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.white,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 10.sp,
        fontWeight: FontWeight.normal,
        color: AppColors.white,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 9.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.white,
      ),
      bodySmall: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 8.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.white,
      ),
      labelLarge: TextStyle(
        fontFamily: 'Roboto',
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
    fontFamily: 'Roboto',
    appBarTheme: AppBarTheme(
      elevation: 0.5,
      backgroundColor: AppColors.black,
      surfaceTintColor: Colors.transparent,
      iconTheme: IconThemeData(color: AppColors.white, size: 3.5.h),
      titleTextStyle: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 18.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.white,
      ),
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: AppColors.white,
      selectionColor: AppColors.blueDark,
    ),
    textTheme: TextTheme(
      displayLarge: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.white,
      ),
      displayMedium: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 18.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.white,
      ),
      displaySmall: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.white,
      ),
      headlineLarge: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 24.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.white,
      ),
      headlineMedium: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 22.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.white,
      ),
      headlineSmall: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 20.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.white,
      ),
      titleLarge: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 12.5.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.white,
      ),
      titleMedium: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 11.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.white,
      ),
      titleSmall: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 10.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.white,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 10.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.white,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 9.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.white,
      ),
      bodySmall: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 8.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.white,
      ),
      labelLarge: TextStyle(
        fontFamily: 'Roboto',
        color: AppColors.white,
        fontSize: 12.sp,
      ),
    ),
  );
}
