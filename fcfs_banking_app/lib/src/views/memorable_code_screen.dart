import 'package:action_slider/action_slider.dart';
import 'package:fcfs_banking_app/core/theme/colors.dart';
import 'package:fcfs_banking_app/core/utils/app_helpers.dart';
import 'package:fcfs_banking_app/core/utils/constant/app_assets_constant.dart';
import 'package:fcfs_banking_app/services/router/routes_name.dart';
import 'package:fcfs_banking_app/src/controllers/auth_controller.dart';
import 'package:fcfs_banking_app/src/controllers/theme_controller.dart';
import 'package:fcfs_banking_app/src/views/widget/slider_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

class CreateMemorableCodeScreen extends StatefulWidget {
  const CreateMemorableCodeScreen({
    super.key,
  });

  @override
  CreateMemorableCodeScreenState createState() =>
      CreateMemorableCodeScreenState();
}

final _controller = ActionSliderController();
final authController = Get.find<AuthController>();

class CreateMemorableCodeScreenState extends State<CreateMemorableCodeScreen> {
  final List<String> _enteredCode = [];
  final int _codeLength = 5;
  final themeController = Get.find<ThemeController>();

  void _onKeyPressed(String value) {
    if (_enteredCode.length < _codeLength) {
      setState(() {
        _enteredCode.add(value);
      });
    }
  }

  void _onDeletePressed() {
    if (_enteredCode.isNotEmpty) {
      setState(() {
        _enteredCode.removeLast();
      });
    }
  }

  Widget _buildPinDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(_codeLength, (index) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 3.5.w),
          width: 6.w,
          height: 3.h,
          decoration: BoxDecoration(
            color:
                index < _enteredCode.length ? themeController.themeMode == ThemeMode.dark
                    ? AppColors.darkBorderColor
                    : Colors.red : Colors.transparent,
            shape: BoxShape.circle,
            border: Border.all(
              color: themeController.themeMode == ThemeMode.dark ?AppColors.darkBorderColor : Colors.red,
              width: 2,
            ),
          ),
        );
      }),
    );
  }

  Widget _buildNumericKeypad() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ...[1, 2, 3, 4, 5, 6, 7, 8, 9].chunked(3).map(
              (row) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: row.map((number) {
                  return _buildKey(number.toString());
                }).toList(),
              ),
            ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(width: 20.w),
            _buildKey('0'),
            _buildDeleteKey(),
          ],
        ),
      ],
    );
  }

  Widget _buildKey(String value) {
    return GestureDetector(
      onTap: () => _onKeyPressed(value),
      child: Container(
        margin: const EdgeInsets.all(10),
        width: 18.w,
        height: 7.h,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: Text(
          value,
          style: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontFamily: 'Montserrat',
          ),
        ),
      ),
    );
  }

  Widget _buildDeleteKey() {
    return GestureDetector(
      onTap: _onDeletePressed,
      child: Container(
        margin: const EdgeInsets.all(10),
        width: 16.w,
        height: 7.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: themeController.themeMode == ThemeMode.dark
              ? Colors.white
              : Colors.red[100],
        ),
        child: Icon(
          Icons.backspace,
          size: 20.sp,
          color: themeController.themeMode == ThemeMode.dark
              ? AppColors.darkBorderColor
              : Colors.red,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        print(
            "authController.isPasscodeEnabled.value: ${authController.isPasscodeEnabled.value}");
        print(
            "authController.biometricEnabled.value: ${authController.biometricEnabled.value}");
        return Container(
          decoration: BoxDecoration(
            gradient: themeController.themeMode == ThemeMode.dark
                ? const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF04091C),
                      Color(0xFF14133B),
                      Color(0xFF02071A),
                    ],
                    stops: [0.0, 0.3, 0.7],
                  )
                : const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF51121E),
                      Color(0xFF92430C),
                      Color(0xFFA4325E),
                    ],
                    stops: [0.0, 0.3, 0.7],
                  ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 38.w,
                  ),
                  Image.asset(
                    AppAssetsConstant.applogo,
                    width: 20.w,
                    height: 20.w,
                    color: themeController.themeMode == ThemeMode.dark ?AppColors.white : AppColors.red,
                  ),
                  const Spacer(),
                  if (authController.isPasscodeEnabled.value)
                    TextButton(
                      onPressed: () =>
                          context.pushNamed(RoutesName.createNewPassword),
                      child: Text(
                        "Forget PIN?",
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                    ),
                  SizedBox(
                    width: 4.w,
                  )
                ],
              ),
              SizedBox(
                height: 2.h,
              ),
              Text(
                authController.isPasscodeEnabled.value
                    ? 'Enter your passcode'
                    : 'Create your memorable code',
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                ),
              ),
              SizedBox(height: 2.h),
              _buildPinDots(),
              SizedBox(height: 9.h),
              if (authController.biometricEnabled.value)
                Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () async {
                      await authController.authenticate();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      width: 50.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            color: AppColors.white.withOpacity(0.5),
                            width: 0.5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.fingerprint,
                            color: AppColors.white,
                            size: 21.sp,
                          ),
                          Text(
                            'Use fingerprint',
                            style: Theme.of(context).textTheme.displayMedium,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              SizedBox(height: 2.h),
              _buildNumericKeypad(),
              SizedBox(height: 5.h),
              SlideButton(
                onPanEnd: (position) async {
                  // Check if the passcode feature is enabled
                  if (authController.isPasscodeEnabled.value) {
                    // If enabled, verify the entered code against the stored passcode
                    if (_enteredCode.join() == await AppHelpers.getPasscode()) {
                      AppHelpers.setPasscodeStatus(true);
                      context.goNamed(
                        RoutesName.mainPage,
                        pathParameters: {'initialIndex': '0'},
                      ); // Navigate to the main page
                    } else {
                      AppHelpers.toast("Incorrect Passcode");
                    }
                  } else {
                    // If passcode is not enabled, set the new passcode
                    AppHelpers.setPasscode(_enteredCode.join());
                    AppHelpers.setPasscodeStatus(true);
                    AppHelpers.toast("Passcode created successfully");

                    context.goNamed(
                      RoutesName.mainPage,
                      pathParameters: {'initialIndex': '0'},
                    ); // Navigate to the main page
                  }
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}

extension IterableExtensions<T> on Iterable<T> {
  List<List<T>> chunked(int size) {
    List<List<T>> chunks = [];
    for (var i = 0; i < length; i += size) {
      chunks.add(skip(i).take(size).toList());
    }
    return chunks;
  }
}
