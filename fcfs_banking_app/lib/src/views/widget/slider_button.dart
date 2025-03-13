import 'package:fcfs_banking_app/core/theme/colors.dart';
import 'package:fcfs_banking_app/core/utils/constant/app_assets_constant.dart';
import 'package:fcfs_banking_app/src/controllers/direct_debit_controller.dart';
import 'package:fcfs_banking_app/src/controllers/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class SlideButton extends StatefulWidget {
  final void Function(double position)? onPanEnd;
  const SlideButton({
    super.key,
    required this.onPanEnd,
  });

  @override
  SlideButtonState createState() => SlideButtonState();
}

class SlideButtonState extends State<SlideButton> {
  final DirectDebitController directDebitController =
      Get.find<DirectDebitController>();
  final themeController = Get.find<ThemeController>();
  double _buttonPosition = 8;
  bool _isWhite = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.9;
    double height = 6.5.h;
    const double buttonSize = 80;

    return ClipPath(
      clipper: SlantedClipper(),
      child: Stack(
        children: [
          // Background Gradient
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: width,
            height: height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.centerRight,
                colors: [
                  Colors.white,
                  themeController.themeMode == ThemeMode.dark
                      ? AppColors.darkBgColor2
                      : AppColors.stackContainerColor1,
                ],
                stops: _isWhite ? [1, 0] : [0, 1],
              ),
            ),
          ),
          // Draggable Button
          Positioned(
            left: _buttonPosition,
            top: 0,
            child: GestureDetector(
              onPanUpdate: (details) {
                setState(() {
                  _buttonPosition += details.delta.dx;
                  _buttonPosition =
                      _buttonPosition.clamp(0.0, width - buttonSize);

                  _isWhite = _buttonPosition >= width - buttonSize;
                });
              },
              onPanEnd: (_) {
                setState(() {
                  // Snap the button to the end if it's close to the right
                  if (_buttonPosition >= width - buttonSize - 10) {
                    _buttonPosition = width - buttonSize;
                    _isWhite = true; // Set the background to white
                  }
                });

                widget.onPanEnd?.call(_buttonPosition);
              },
              child: Container(
                width: buttonSize,
                height: height,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(8, 0),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0, left: 6),
                    child: Image.asset(
                      AppAssetsConstant.applogo,
                      width: 44,
                      height: 44,
                      color: themeController.themeMode == ThemeMode.dark
                          ? AppColors.darkBorderColor
                          : AppColors.red,
                    ),
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

class SlantedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, size.height);
    path.lineTo(size.width * 0.95, size.height);
    path.lineTo(size.width, 0);
    path.lineTo(size.width * 0.05, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
