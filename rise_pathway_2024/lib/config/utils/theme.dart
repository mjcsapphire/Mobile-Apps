// ignore_for_file: dangling_library_doc_comments

import 'package:flutter/material.dart';
import 'package:rise_pathway/config/constants/package_export.dart';
import 'package:rise_pathway/config/utils/colors.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.white,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      iconTheme: IconThemeData(
        color: AppColors.primaryColor,
      ),
      color: AppColors.white,
    ),
    fontFamily: 'Urbanist',
    textTheme: TextTheme(
      displayLarge: TextStyle(
        fontSize: 57.sp,
        fontWeight: FontWeight.w400,
        letterSpacing: -0.25,
        fontFamily: 'Urbanist',
      ),
      displayMedium: TextStyle(
        fontSize: 45.sp,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        fontFamily: 'Urbanist',
      ),
      displaySmall: TextStyle(
        fontSize: 36.sp,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        fontFamily: 'Urbanist',
      ),
      headlineLarge: TextStyle(
        fontSize: 32.sp,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.15,
        fontFamily: 'Urbanist',
      ),
      headlineMedium: TextStyle(
        fontSize: 28.sp,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.15,
        fontFamily: 'Urbanist',
      ),
      headlineSmall: TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.15,
        fontFamily: 'Urbanist',
      ),
      titleLarge: TextStyle(
        fontSize: 22.sp,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.15,
        fontFamily: 'Urbanist',
      ),
      titleMedium: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.15,
        fontFamily: 'Urbanist',
      ),
      titleSmall: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.1,
        fontFamily: 'Urbanist',
      ),
      labelLarge: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.1,
        fontFamily: 'Urbanist',
      ),
      labelMedium: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
        fontFamily: 'Urbanist',
      ),
      labelSmall: TextStyle(
        fontSize: 11.sp,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
        fontFamily: 'Urbanist',
      ),
      bodyLarge: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
        fontFamily: 'Urbanist',
      ),
      bodyMedium: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
        fontFamily: 'Urbanist',
      ),
      bodySmall: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
        fontFamily: 'Urbanist',
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
