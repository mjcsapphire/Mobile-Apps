import 'package:fcfs_banking_app/core/theme/colors.dart';
import 'package:fcfs_banking_app/core/theme/radialBg.dart';
import 'package:fcfs_banking_app/core/utils/constant/app_assets_constant.dart';
import 'package:fcfs_banking_app/services/router/routes_name.dart';
import 'package:fcfs_banking_app/src/controllers/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

class Splash extends StatelessWidget {
  Splash({super.key});

  final themeController = Get.find<ThemeController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Gradient background
          CustomPaint(
            size: Size(
              MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height,
            ),
            painter: themeController.themeMode == ThemeMode.dark
                ? DarkGradientBackgroundPainter()
                : GradientBackgroundPainter(),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Image.asset(
                AppAssetsConstant.applogo,
                height: 14.h,
                color: themeController.themeMode == ThemeMode.dark
                    ? AppColors.white
                    : AppColors.red,
              ),
              Center(
                child: Text(
                  'FANTASY',
                  style: TextStyle(
                    fontSize: 12.w,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Text(
                  'The banking app for the caribbean',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 4.w,
                    color: Colors.white70,
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipPath(
              clipper: TopAlignedWaveClipper(),
              child: Container(
                decoration: BoxDecoration(
                  gradient: themeController.themeMode == ThemeMode.dark
                      ? AppColors.darkStackContainerBackground
                      : AppColors.stackContainerBackground,
                ),
                height: 400,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.25),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              themeController.themeMode == ThemeMode.dark
                                  ? AppColors.darkBorderColor
                                  : AppColors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        onPressed: () {
                          context.goNamed(RoutesName.loginPage);
                        },
                        child: const Text(
                          'GET STARTED',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TopAlignedWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();

    // Start from the left at 50% of the screen height
    path.lineTo(0, size.height * 0.5);

    // Define the first curve
    var firstControlPoint = Offset(size.width / 4,
        size.height * 0.45); // Control point slightly above 40% of height
    var firstEndPoint = Offset(
        size.width / 2, size.height * 0.55); // End point lower than left curve
    path.quadraticBezierTo(
      firstControlPoint.dx,
      firstControlPoint.dy,
      firstEndPoint.dx,
      firstEndPoint.dy,
    );

    // Define the second curve
    var secondControlPoint =
        Offset(size.width * 3 / 4, size.height * 0.7); // Higher control point
    var secondEndPoint = Offset(size.width,
        size.height * 0.3); // End point higher than both left and mid
    path.quadraticBezierTo(
      secondControlPoint.dx,
      secondControlPoint.dy,
      secondEndPoint.dx,
      secondEndPoint.dy,
    );

    // Complete the shape
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
