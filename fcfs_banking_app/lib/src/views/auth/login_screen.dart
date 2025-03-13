import 'package:fcfs_banking_app/core/theme/colors.dart';
import 'package:fcfs_banking_app/core/theme/radialBg.dart';
import 'package:fcfs_banking_app/core/utils/constant/app_assets_constant.dart';
import 'package:fcfs_banking_app/services/router/routes_name.dart';
import 'package:fcfs_banking_app/src/controllers/auth_controller.dart';
import 'package:fcfs_banking_app/src/controllers/theme_controller.dart';
import 'package:fcfs_banking_app/src/views/widget/custom_button.dart';
import 'package:fcfs_banking_app/src/views/widget/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final AuthController authController = Get.find<AuthController>();
  final themeController = Get.find<ThemeController>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Stack(
        children: [
          CustomPaint(
            size: Size(
              MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height,
            ),
            painter: themeController.themeMode == ThemeMode.dark
                ? DarkGradientBackgroundPainter()
                : GradientBackgroundPainter(),
          ),
          SingleChildScrollView(
            // Makes the page scrollable
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 10.h),
                    Image(
                      image: const AssetImage(AppAssetsConstant.applogo),
                      width: MediaQuery.of(context).size.width * 0.5,
                      color: themeController.themeMode == ThemeMode.dark
                          ? AppColors.white
                          : AppColors.red,
                    ),
                    Text(
                      "FANTASY",
                      style: theme.textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 12.w,
                      ),
                    ),
                    Text(
                      "Caribbean",
                      style: theme.textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.normal,
                        fontSize: 18.sp,
                      ),
                    ),
                    SizedBox(height: 6.h),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: TextfieldWidget(
                        label: 'username',
                        controller: emailController,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.text,
                      ),
                    ),
                    SizedBox(height: 2.h),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: TextfieldWidget(
                        label: 'password',
                        controller: passwordController,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                      ),
                    ),
                    SizedBox(height: 5.h),

                    Obx(
                      () => authController.isLoading.value
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: AppColors.white,
                              ),
                            )
                          : CustomButtonWidget(
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  authController.signInUser(
                                    emailController.text.trim(),
                                    passwordController.text.trim(),
                                  );
                                }
                              },
                              width: MediaQuery.of(context).size.width * 0.5,
                              text: "LOG IN ",
                              isIconAvailable: false,
                              fontSize: 19.sp,
                              radius: 4,
                            ),
                    ),
                    SizedBox(height: 2.h),

                    // Forgot Password
                    Center(
                      child: TextButton(
                        onPressed: () {
                          context.pushNamed(RoutesName.resetPassword);
                        },
                        child: Text(
                          "Forgot Password?",
                          style: theme.textTheme.displayMedium!.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 17.sp,
                            color: themeController.themeMode == ThemeMode.dark
                                ? AppColors.darkTileColor
                                : AppColors.lightRed,
                          ),
                        ),
                      ),
                    ),

                    // Sign Up Section
                    Center(
                      child: TextButton(
                        onPressed: () {
                          context.pushNamed(RoutesName.registerPage);
                        },
                        child: Text.rich(
                          TextSpan(
                            text: "New to Fantasy? ",
                            style: theme.textTheme.displayMedium!.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 17.sp,
                            ),
                            children: [
                              TextSpan(
                                text: "Sign Up",
                                style: theme.textTheme.displayMedium!.copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 17.sp,
                                  color: themeController.themeMode ==
                                          ThemeMode.dark
                                      ? AppColors.darkTileColor
                                      : AppColors.lightRed,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 2.h),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
