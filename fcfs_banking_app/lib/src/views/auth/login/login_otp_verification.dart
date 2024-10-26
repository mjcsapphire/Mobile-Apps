import 'package:fcfs_banking_app/core/utils/app_helpers.dart';
import 'package:fcfs_banking_app/core/utils/constant/app_assets_constant.dart';
import 'package:fcfs_banking_app/services/router/routes_name.dart';
import 'package:fcfs_banking_app/src/views/widget/custom_button.dart';
import 'package:fcfs_banking_app/src/views/widget/custom_textfield.dart';
import 'package:fcfs_banking_app/src/views/widget/helper_widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

class LoginOtpVerification extends StatefulWidget {
  const LoginOtpVerification({super.key});

  @override
  State<LoginOtpVerification> createState() => _LoginOtpVerificationState();
}

class _LoginOtpVerificationState extends State<LoginOtpVerification> {
  TextEditingController otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ScaffoldHelperWidget(
        backgroundImage: AppAssetsConstant.onboardingBackground,
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
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
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const SizedBox(height: 20),
                      // Security Code Label
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Verification code",
                            style: theme.textTheme.headlineSmall?.copyWith(
                              fontSize: 16.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 1.h),
                      // Security Code TextField
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: CustomTextField(
                            controller: otpController,
                            hintText: "enter otp",
                            obscureText: false,
                            keyboardType: TextInputType.name,
                            validator: (value) => null),
                      ),

                      // SizedBox(height: 1.h),
                      TextButton(
                        onPressed: () {
                          // Handle help logic here
                        },
                        child: Text(
                          "Resend code",
                          style: theme.textTheme.bodyLarge!.copyWith(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),

                      SizedBox(height: 4.h),

                      CustomButtonWidget(
                        onTap: () {
                          AppHelpers.saveUser(key: "hasPasscode", value: true);
                          context.pushNamed(RoutesName.passcodeVerification);
                        },
                        width: MediaQuery.of(context).size.width * 0.7,
                        text: "Continue",
                        isIconAvailable: false,
                        fontSize: 17.sp,
                      ),
                      // SizedBox(height: 1.h),
                      TextButton(
                        onPressed: () {
                          // Handle help logic here
                        },
                        child: Text(
                          "Need Help?",
                          style: theme.textTheme.bodyLarge!.copyWith(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
