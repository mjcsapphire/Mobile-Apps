// ignore_for_file: dangling_library_doc_comments

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'colors.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.white,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      iconTheme: IconThemeData(
        color: AppColors.primaryColor,
      ),
      color: AppColors.white,
    ),
    fontFamily: 'Inter',
    textTheme: TextTheme(
      displayLarge: TextStyle(
        fontSize: 57.sp,
        fontWeight: FontWeight.w400,
        letterSpacing: -0.25,
        fontFamily: 'Inter',
      ),
      displayMedium: TextStyle(
        fontSize: 45.sp,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        fontFamily: 'Inter',
      ),
      displaySmall: TextStyle(
        fontSize: 36.sp,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        fontFamily: 'Inter',
      ),
      headlineLarge: TextStyle(
        fontSize: 32.sp,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.15,
        fontFamily: 'Inter',
      ),
      headlineMedium: TextStyle(
        fontSize: 28.sp,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.15,
        fontFamily: 'Inter',
      ),
      headlineSmall: TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.15,
        fontFamily: 'Inter',
      ),
      titleLarge: TextStyle(
        fontSize: 22.sp,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.15,
        fontFamily: 'Inter',
      ),
      titleMedium: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.15,
        fontFamily: 'Inter',
      ),
      titleSmall: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.1,
        fontFamily: 'Inter',
      ),
      labelLarge: TextStyle(
        fontSize: 10.sp,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.1,
        fontFamily: 'Inter',
      ),
      labelMedium: TextStyle(
        fontSize: 8.sp,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
        fontFamily: 'Inter',
      ),
      labelSmall: TextStyle(
        fontSize: 6.sp,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
        fontFamily: 'Inter',
      ),
      bodyLarge: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
        fontFamily: 'Inter',
      ),
      bodyMedium: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
        fontFamily: 'Inter',
      ),
      bodySmall: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
        fontFamily: 'Inter',
      ),
    ),
  );
}

/// [Display Large]
// Size: 57sp - Very large, used for splash screens or main headings.

/// [Display Medium]
// Size: 45sp - Slightly smaller, used for featured text or large headings.

/// [Display Small]
// Size: 36sp - Ideal for medium-large text, such as section headings.

/// [Headline Large]
// Size: 32sp - For prominent headlines, still large but less attention-grabbing than display sizes.

/// [Headline Medium]
// Size: 28sp - For medium-sized headlines or titles in content sections.

/// [Headline Small]
// Size: 24sp - A good size for smaller headlines or sub-sections.

/// [Title Large]
// Size: 22sp - Used for large titles, such as card titles or important text elements.

/// [Title Medium]
// Size: 16sp - Standard for medium titles, such as in smaller cards or section labels.

/// [Title Small]
// Size: 14sp - Typically used for small titles, perhaps in secondary or tertiary UI elements.

/// [Label Large]
// Size: 12sp - Larger form labels or buttons that need extra emphasis.

/// [Label Medium]
// Size: 11sp - Medium labels, ideal for less important buttons or input fields.

/// [Label Small]
// Size: 10sp - Smallest labels, great for tags or minimal buttons.

/// [Body Large]
// Size: 16sp - Used for main body content, ensuring readability across the app.

/// [Body Medium]
// Size: 14sp - Standard body text, perfect for paragraphs or general content.

/// [Body Small]
// Size: 12sp - Smaller body text for secondary information or disclaimers.
