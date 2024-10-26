import 'package:fcfs_banking_app/core/theme/colors.dart';
import 'package:fcfs_banking_app/core/utils/constant/app_assets_constant.dart';
import 'package:fcfs_banking_app/services/router/routes_name.dart';
import 'package:fcfs_banking_app/src/controllers/auth_controller.dart';
import 'package:fcfs_banking_app/src/views/widget/custom_button.dart';
import 'package:fcfs_banking_app/src/views/widget/helper_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

import '../widget/custom_textfield.dart';

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

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ScaffoldHelperWidget(
      backgroundImage: AppAssetsConstant.onboardingBackground,
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Center(
                child: Text(
                  "LOGIN",
                  style: theme.textTheme.headlineLarge!
                      .copyWith(fontSize: 30.sp, shadows: [
                    Shadow(
                      color: theme.colorScheme.shadow,
                      blurRadius: 20,
                    ),
                  ]),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 1.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(height: 6.h),
                    Text(
                      "Email",
                      style: theme.textTheme.displayMedium!.copyWith(
                        fontWeight: FontWeight.w300,
                        fontSize: 17.sp,
                      ),
                    ),
                    SizedBox(height: 0.6.h),
                    CustomTextField(
                      controller: emailController,
                      hintText: "someone@gmail.com",
                      obscureText: false,
                     
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your mail';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      "Password",
                      style: theme.textTheme.displayMedium!.copyWith(
                        fontWeight: FontWeight.w300,
                        fontSize: 17.sp,
                      ),
                    ),
                    SizedBox(height: 0.6.h),
                    CustomTextField(
                      controller: passwordController,
                      hintText: "password",
                      obscureText: true,
                      
                      keyboardType: TextInputType.visiblePassword,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter password';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 5.h),
                    Obx(
                      () => authController.isLoading.value
                          ? const Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircularProgressIndicator(
                                  color: AppColors.white,
                                ),
                              ],
                            )
                          : CustomButtonWidget(
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  authController.signInUser(
                                      emailController.text.trim(),
                                      passwordController.text.trim());
                                  Future.delayed(
                                    const Duration(seconds: 2),
                                    () {
                                      context.goNamed(RoutesName.mainPage,
                                          pathParameters: {
                                            'initialIndex': '0'
                                          });
                                    },
                                  );
                                  // context.pushNamed(RoutesName.loginSecurity);
                                }
                              },
                              width: MediaQuery.of(context).size.width * 0.95,
                              text: "Continue",
                              isIconAvailable: false,
                              fontSize: 19.sp,
                            ),
                    ),
                    SizedBox(height: 1.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            "Need Help?",
                            style: theme.textTheme.displayMedium!.copyWith(
                              fontWeight: FontWeight.w300,
                              fontSize: 17.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 2.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
