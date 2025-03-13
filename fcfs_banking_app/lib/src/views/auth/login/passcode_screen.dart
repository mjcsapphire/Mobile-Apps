import 'package:fcfs_banking_app/core/theme/colors.dart';
import 'package:fcfs_banking_app/core/utils/app_helpers.dart';
import 'package:fcfs_banking_app/core/utils/constant/app_assets_constant.dart';
import 'package:fcfs_banking_app/services/router/routes_name.dart';
import 'package:fcfs_banking_app/src/controllers/auth_controller.dart';
import 'package:fcfs_banking_app/src/controllers/transaction_controller.dart';
import 'package:fcfs_banking_app/src/controllers/user_controller.dart';
import 'package:fcfs_banking_app/src/views/widget/custom_button.dart';
import 'package:fcfs_banking_app/src/views/widget/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import 'package:vibration/vibration.dart';

class LoginPassCodeScreen extends StatefulWidget {
  const LoginPassCodeScreen({super.key});

  @override
  State<LoginPassCodeScreen> createState() => _LoginPassCodeScreenState();
}

class _LoginPassCodeScreenState extends State<LoginPassCodeScreen> {
  final TextEditingController otpController = TextEditingController();
  final AuthController authController = Get.find<AuthController>();
  UserController userController = Get.find<UserController>();
  TransactionController transactionController =
      Get.find<TransactionController>();

  @override
  void dispose() {
    otpController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    userController.fetchCurrentUserData().then((_) {
      final user = userController.user.value;
      if (user != null) {
        transactionController.fetchUserTransactions(user.uid);
      }
    });
    Future.delayed(Duration.zero, () {
      debugPrint("Biometric enabled: ${authController.biometricEnabled.value}");
      if (authController.biometricEnabled.value) {
        _showFingerprintPopup();
      }
    });
  }

  Future<void> _showFingerprintPopup() async {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      // backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            // color: Colors.black,
            gradient: AppColors.stackContainerBackground,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildHeader(),
              const SizedBox(height: 20),
              _buildFingerprintButton(),
              const SizedBox(height: 20),
              _buildCancelButton(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeader() {
    return Align(
      alignment: Alignment.topLeft,
      child: Text(
        "Verify",
        style: TextStyle(
          color: Colors.white,
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildFingerprintButton() {
    return Center(
      child: GestureDetector(
        onTap: () async {
          bool authenticated = await authController.authenticate();
          if (authenticated) {
            context.pop();
            Future.delayed(const Duration(seconds: 2), () {
              context.goNamed(RoutesName.mainPage,
                  pathParameters: {'initialIndex': '0'});
            });
            if ((await Vibration.hasVibrator()) ?? false) {
              Vibration.vibrate(duration: 200);
            }
          } else {
            debugPrint('Authentication failed');
          }
        },
        child: CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey.shade800,
          child: const Icon(
            Icons.fingerprint,
            color: Colors.white,
            size: 60,
          ),
        ),
      ),
    );
  }

  Widget _buildCancelButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            "Cancel",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: AppColors.background,
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildLoginHeader(theme),
              _buildOtpInput(theme),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoginHeader(ThemeData theme) {
    return Expanded(
      child: Center(
        child: Column(
          children: [
            const Spacer(),
            Image(
              image: const AssetImage(AppAssetsConstant.applogo),
              width: MediaQuery.of(context).size.width * 0.4,
            ),
            Text(
              "FANTASY",
              style: theme.textTheme.headlineMedium?.copyWith(
                fontSize: 30.sp,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Caribbean",
              style: theme.textTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.normal,
                fontSize: 17.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOtpInput(ThemeData theme) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const SizedBox(height: 20),
            _buildPinCodeLabel(theme),
            SizedBox(height: 1.h),
            _buildOtpTextField(),
            SizedBox(height: 4.h),
            _buildContinueButton(),
            _buildHelpButton(theme),
          ],
        ),
      ),
    );
  }

  Widget _buildPinCodeLabel(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          "PIN CODE",
          style: theme.textTheme.headlineSmall?.copyWith(
            fontSize: 16.sp,
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  Widget _buildOtpTextField() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.5,
      child: Form(
        child: TextfieldWidget(
          label: 'Enter Pass Code',
          controller: otpController,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
        ),
      ),
    );
  }

  Widget _buildContinueButton() {
    return CustomButtonWidget(
      onTap: () {
        if (otpController.text.isNotEmpty && otpController.text == "123456") {
          debugPrint("OTP Submitted: ${otpController.text}");
          context.goNamed(RoutesName.mainPage,
              pathParameters: {'initialIndex': '0'});
        } else {
          AppHelpers.toast("Please enter code");
        }
      },
      width: MediaQuery.of(context).size.width * 0.8,
      text: "Continue",
      isIconAvailable: false,
      radius: 4,
      fontSize: 20.sp,
    );
  }

  Widget _buildHelpButton(ThemeData theme) {
    return TextButton(
      onPressed: () {
        context.pushNamed(RoutesName.resetPassword);
      },
      child: Text(
        "Need Help?",
        style: theme.textTheme.bodyLarge?.copyWith(
          color: Colors.white,
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
