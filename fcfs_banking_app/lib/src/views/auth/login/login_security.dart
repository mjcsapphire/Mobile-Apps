import 'package:fcfs_banking_app/core/theme/colors.dart';
import 'package:fcfs_banking_app/core/utils/app_helpers.dart';
import 'package:fcfs_banking_app/core/utils/constant/app_assets_constant.dart';
import 'package:fcfs_banking_app/services/router/routes_name.dart';
import 'package:fcfs_banking_app/src/views/widget/custom_button.dart';
import 'package:fcfs_banking_app/src/views/widget/helper_widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

class LoginSecurityScreen extends StatefulWidget {
  const LoginSecurityScreen({super.key});

  @override
  State<LoginSecurityScreen> createState() => _LoginSecurityScreenState();
}

class _LoginSecurityScreenState extends State<LoginSecurityScreen> {
  TextEditingController securityCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: ScaffoldHelperWidget(
        backgroundImage: AppAssetsConstant.onboardingBackground,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Login Text
              Text(
                "LOGIN",
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontSize: 30.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 3.h),

              // Security Code Label
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Security code",
                    style: theme.textTheme.headlineSmall?.copyWith(
                      // fontSize: 12.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 2.h),

              _buildSecurityCodeButton("cat"),
              _buildSecurityCodeButton("dog"),
              _buildSecurityCodeButton("whale"),
              _buildSecurityCodeButton("cappuccino"),

              SizedBox(height: 4.h),

              CustomButtonWidget(
                onTap: () {
                  context.pushNamed(RoutesName.otpVerification);
                  AppHelpers.saveUser(key: "hasSecurityQuestion", value: true);
                },
                width: MediaQuery.of(context).size.width * 0.88,
                text: "continue",
                isIconAvailable: false,
                fontSize: 17.sp,
              ),
              SizedBox(height: 1.h),
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
    );
  }

  Widget _buildSecurityCodeButton(String label) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 1.h),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 1.5.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          side: const BorderSide(color: Colors.white, width: 1),
        ),
        onPressed: () {
          // Handle button logic here
        },
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: AppColors.textGreyColor,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
