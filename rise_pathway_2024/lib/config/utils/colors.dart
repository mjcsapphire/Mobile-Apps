import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Color(0xFF08477d);

  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color lightGrey = Color(0xFFE9E9E9);
  static const Color journalTitle = Color(0xFF646464);
  static const Color journalSubtitle = Color(0xFF818181);
  static const Color darkGrey = Color(0xFF666666);
  static const Color lighterGrey = Color(0xFFD9D9D9);
  static const Color navIconGrey = Color(0xFFB1B1B1);
  static const Color lightBlue = Color(0xFFf0f7ff);
  static const Color veryLightBlue = Color(0xFFe0effe);
  static const Color lightSkyBlue = Color(0xFFbbdffc);

  static const Color textFieldColor = Color(0xFF9796A1);
  static const Color textFieldBorderColor = Color(0xFFDADADA);

  static const Color error = Color(0xFFF44336);
  static const Color success = Color(0xFF4CAF50);

  static const Color secondryColor = Color(0xFF00B4D8);
  static const Color skyBlue = Color(0xFF7ec4fb);
  static const Color blue = Color(0xFF3aa7f6);
  static const Color chatMessageColor = Color.fromARGB(255, 47, 129, 237);
  static const Color darkSkyBlue = Color(0xFF108ce7);
  static const Color darkBlue = Color(0xFF046dc5);
  static const Color veryDarkBlue = Color(0xFF05579f);

  static const Color green = Color(0xFF5FB135);

  static const Color blackBlue = Color(0xFF0d3f6d);
  static const Color blackestBlue = Color(0xFF092848);

  static const Color challengesCardSubtitle = Color(0xFF5C5C77);

  static const Color quizProgressColor = Color(0xFFFF9051);

  static const Color blue100 = Color(0xFFF0F7FF);
  static const Color blue200 = Color(0xFFE0EFFE);
  static const Color blue300 = Color(0xFFBBDFFC);
  static const Color blue400 = Color(0xFF7EC4FB);
  static const Color blue500 = Color(0xFF3AA7F6);
  static const Color blue600 = Color(0xFF108CE7);
  static const Color blue700 = Color(0xFF046DC5);
  static const Color blue800 = Color(0xFF05579F);
  static const Color blue900 = Color(0xFF0D3F6D);
  static const Color blue950 = Color(0xFF092848);

  static const Color daysOfWeekColor = Color(0xFF8F9BB3);
}

class AppColorsGredients {
  static const LinearGradient pieChartGradient1 = LinearGradient(
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    colors: [
      Color(0xFF3864FE),
      Color(0xFF86A1FF),
    ],
  );
  static const LinearGradient pieChartGradient2 = LinearGradient(
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    colors: [
      Color(0xFFF04F4F),
      Color(0xFFFF7A7A),
    ],
  );
  static const LinearGradient pieChartGradient3 = LinearGradient(
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    colors: [
      Color(0xFFFD9D3A),
      Color(0xFFFFDCA9),
    ],
  );

  static const LinearGradient greyGradient = LinearGradient(
    end: Alignment.centerLeft,
    begin: Alignment.centerRight,
    colors: [
      AppColors.navIconGrey,
      AppColors.navIconGrey,
    ],
  );
  static const LinearGradient primaryRightToLeft = LinearGradient(
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
    colors: [
      Color(0xFF08477D),
      Color(0xFF0F81E3),
    ],
  );
  static const LinearGradient primaryLeftToRight = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Color(0xFF08477D),
      Color(0xFF0F81E3),
    ],
  );
  static const LinearGradient primaryTopToBottom = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF08477D),
      Color(0xFF0F81E3),
    ],
  );

  static const LinearGradient primaryBottomToTop = LinearGradient(
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    colors: [
      Color(0xFF08477D),
      Color(0xFF0F81E3),
    ],
  );
  static const LinearGradient quizSummary = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF08477D),
      Color(0xFF08477D),
      Color(0xFF08477D),
      Color(0xFF08477D),
      Color(0xFF0F81E3),
    ],
  );

  static const LinearGradient quizYesButton = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Color(0xFF56AB2F),
      Color(0xFFA8E063),
    ],
  );

  static const LinearGradient challengeCompletedBtn = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Color(0xFF56AB2F),
      Color(0xFFA8E063),
    ],
  );
  static const LinearGradient quizNoButton = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Color(0xFFBE0000),
      Color(0xFFEF1F1F),
    ],
  );
  static LinearGradient panicCardGradient = const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color.fromARGB(255, 112, 193, 251),
      Color.fromARGB(255, 217, 236, 253),
      Color.fromARGB(255, 254, 244, 213),
      Color.fromARGB(255, 250, 208, 183),
    ],
  );

  static const LinearGradient gradientForBorder = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFD6208F),
      Color(0xFF4211E6),
      Color(0xFF4211E6),
      Color(0xFF18FBAE),
      Color(0xFFF5DE38),
      Color(0xFFEE6C38),
    ],
  );
}
