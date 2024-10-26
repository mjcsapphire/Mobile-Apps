import 'package:fcfs_banking_app/core/utils/app_helpers.dart';
import 'package:fcfs_banking_app/core/utils/constant/app_assets_constant.dart';
import 'package:fcfs_banking_app/services/router/routes_name.dart';
import 'package:fcfs_banking_app/services/router/routes_path.dart';
import 'package:fcfs_banking_app/src/views/widget/custom_button.dart';
import 'package:fcfs_banking_app/src/views/widget/custom_textfield.dart';
import 'package:fcfs_banking_app/src/views/widget/helper_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:local_auth/local_auth.dart';
import 'package:sizer/sizer.dart';
import 'package:vibration/vibration.dart';

class LoginPassCodeScreen extends StatefulWidget {
  const LoginPassCodeScreen({super.key});

  @override
  State<LoginPassCodeScreen> createState() => _LoginPassCodeScreenState();
}

class _LoginPassCodeScreenState extends State<LoginPassCodeScreen> {
  final TextEditingController otpController = TextEditingController();
  final LocalAuthentication auth = LocalAuthentication();
  final bool _isAuthenticating = false;
  Color fingerprintIconColor = Colors.white;
  bool isAuthenticated = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      if (!isAuthenticated) {
        _showFingerprintPopup();
      }
    });
  }

  Future<void> _showFingerprintPopup() async {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
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
        onTap: _isAuthenticating ? null : _authenticate,
        child: CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey.shade800,
          child: Icon(
            Icons.fingerprint,
            color: fingerprintIconColor,
            size: 40,
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
          onPressed: () => Future.delayed(Duration.zero, () {
            Navigator.of(context).pop();
          }),
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

  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      authenticated = await auth.authenticate(
        localizedReason: 'Touch this fingerprint icon to authenticate',
        options: const AuthenticationOptions(
          biometricOnly: true,
        ),
      );
      if (authenticated) {
        setState(() {
          isAuthenticated = true;
          fingerprintIconColor = Colors.green;
        });

        context.pop();

        context.go(RoutesPath.mainPage);

        if ((await Vibration.hasVibrator()) ?? false) {
          Vibration.vibrate(duration: 200);
        }
      } else {
        debugPrint('Authentication failed');
      }
    } on PlatformException catch (e) {
      debugPrint("error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ScaffoldHelperWidget(
      backgroundImage: AppAssetsConstant.onboardingBackground,
      child: SafeArea(
        child: Column(
          children: [
            _buildLoginHeader(theme),
            _buildOtpInput(theme),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginHeader(ThemeData theme) {
    return Expanded(
      child: Center(
        child: Text(
          "LOGIN",
          style: theme.textTheme.headlineMedium?.copyWith(
            fontSize: 30.sp,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
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
      width: MediaQuery.of(context).size.width * 0.6,
      child: CustomTextField(
        controller: otpController,
        hintText: "Enter OTP",
        obscureText: false,
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter OTP';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildContinueButton() {
    return CustomButtonWidget(
      onTap: () {
        if (otpController.text.isNotEmpty) {
          debugPrint("OTP Submitted: ${otpController.text}");
          setState(() {
            isAuthenticated = true;
            context.goNamed(RoutesName.home);
          });
        } else {
          AppHelpers.toast("Please enter OTP");
        }
      },
      width: MediaQuery.of(context).size.width * 0.7,
      text: "Continue",
      isIconAvailable: false,
      fontSize: 17.sp,
    );
  }

  Widget _buildHelpButton(ThemeData theme) {
    return TextButton(
      onPressed: () {
        // Handle help logic here
      },
      child: Text(
        "Need Help?",
        style: theme.textTheme.bodyLarge?.copyWith(
          color: Colors.white,
          fontSize: 14.sp,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }
}
