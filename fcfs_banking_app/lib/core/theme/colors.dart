import 'package:flutter/material.dart';

class AppColors {
  // new theme colors
  static const Color red = Color(0xFFE62F19);
  static const Color yellow = Color(0xFFFFBC55);
  static const Color white = Color(0xFFF3E9EE);
  static const Color secondaryColor = Color(0xFF336600);
  static const Color purple = Color(0xFFa4325e);
  static const Color grey = Color(0xFFCED5D2);
  static Color beidge = const Color(0xFC6B6B6a);
  static Color textEditingBoxColor = const Color(0xFFCED5D2).withOpacity(0.2);
  static Color notificatipnReadColor = const Color(0xFFFFFFFF).withOpacity(2.5);
  static Color notificatipnUnreadColor = const Color(0xFFE62F19);
  static Color whiteChat = const Color(0xFFf3e9ee);

  static Color stackContainerColor1 = const Color(0xFFFF648B);
  static Color stackContainerColor2 = const Color(0xFFFFBC80);

  static Color bgColor1 = const Color(0xFF51121E);
  static Color bgColor2 = const Color(0xFF92430C);
  static Color bgColor3 = const Color(0xFF4C0215);
  static Color bgColor4 = const Color(0xFFA4325E);

  // old theme colors
  static const Color lightRed = Color.fromARGB(255, 255, 115, 115);
  static const Color backgroundColor = Colors.white;
  static const Color textBlackColor = Colors.black;
  static const Color textGreyColor = Color(0xFF4A4A4A);
  static const Color textWhiteColor = Colors.white;
  static const Color pinkColor = Color.fromARGB(255, 231, 118, 118);
  static const Color blueDark = Color.fromARGB(255, 0, 63, 114);
  static const Color black = Colors.black;
  static const Color transparent = Colors.transparent;
  static Color buttonColor = const Color(0xFF2f3737);
  // new ui colors
  static Color redOrange = const Color.fromARGB(255, 153, 59, 8);
  static Color darkRust = const Color(0xFF7C2E04);
  static Color rustyRose = const Color(0xFF974C49);
  static Color pinkGrey = const Color(0xFFC9A8A0);
  static Color burgundy = const Color(0xFF672E3D);
  static Color peachOrange = const Color(0xFFFAA081);
  static Color darkMauve = const Color.fromARGB(255, 130, 23, 80);

  static LinearGradient background2 = const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFFF5F6D),
      Color(0xFFFFC371),
    ],
  );
  static LinearGradient stackContainerBackground = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [
      stackContainerColor2,
      stackContainerColor1,
    ],
  );

  static LinearGradient stackContainerBackground3 = const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFFF9A144), // Orange-like color at the top
      Color(0xFF94497A),
    ],
  );
  static LinearGradient stackContainerBackground2 = const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFFE18240),
      Color(0xFFC971A3),
    ],
    stops: [0.0, 1.0],
    transform: GradientRotation(0.60),
  );
  static LinearGradient transactionBg = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [
      const Color(0xFFFFBC55).withOpacity(0.6),
      bgColor4.withOpacity(0.9),
    ],
  );
  static LinearGradient notificationBg = const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFFFF8F8F),
      Color(0xFF7C004B),
    ],
    stops: [0.0, 1.0],
  );

  static LinearGradient background = const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF51121E),
      Color(0xFF92430C),
      Color(0xFFA4325E),
    ],
    stops: [0.0, 0.3, 0.7],
  );

  /* dark theme Colors and Gradients */

  static Color darkStackContainerColor1 = const Color(0xFF020819);
  static Color darkStackContainerColor2 = const Color(0xFF020819);
  static const darkBgColor1 = Color(0xFF020819);
  static const darkBgColor2 = Color(0xFF20245c);
  static const darkBgColor3 = Color(0xFF2e0055);
  static const darkTransferBgColor1 = Color(0xFF000036);
  static const darkTransferBgColor2 = Color(0xFFa3a3a7);
  static const darkBorderColor = Color(0xFF3633a3);
  static const darkTileColor = Color.fromARGB(255, 130, 125, 181);

  static LinearGradient darkAppBarGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      AppColors.darkStackContainerColor1,
      AppColors.darkStackContainerColor2,
    ],
  );
  static LinearGradient darkStackContainerBackground = const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      darkTransferBgColor1,
      darkBgColor2,
    ],
  );

  static LinearGradient dakStackContainerBackground2 = const LinearGradient(
    tileMode: TileMode.decal,
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color.fromARGB(255, 116, 116, 133),
      Color.fromARGB(255, 49, 52, 95),
    ],
    stops: [0.3, 0.7],
    // transform: GradientRotation(0.70),
  );

  static LinearGradient darkBackground = const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF20245c), // bgColor1
      Color(0xFF2e0055), // bgColor2
      Color(0xFF020819), // bgColor3
      // Color(0xFFA4325E), // bgColor4
      // bgColor4,
    ],
    // stops: [0.0, 0.33, 0.55, 1.0],
    stops: [0.0, 0.33, 1.0],
    transform: GradientRotation(0.15),
  );

  static LinearGradient darkNotificationBg = const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      darkBgColor2,
      darkTransferBgColor1,
    ],
    stops: [0.0, 1.0],
  );

  static LinearGradient darkTransactionBg = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [
      darkBgColor2.withOpacity(0.3),
      darkBgColor3.withOpacity(0.6),
    ],
  );
}
