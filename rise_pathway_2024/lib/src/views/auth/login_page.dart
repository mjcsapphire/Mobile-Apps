import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:rise_pathway/core/constants/package_export.dart';
import 'package:rise_pathway/core/helpers/helpers.dart';
import 'package:rise_pathway/core/routes/routes.dart';
import 'package:rise_pathway/core/utils/colors.dart';
import 'package:rise_pathway/src/controllers/auth_controller.dart';
import 'package:rise_pathway/src/views/widget/rise_button.dart';
import 'package:rise_pathway/src/views/widget/text_form_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final authController = Get.find<AuthController>();
  final signInFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: signInFormKey,
            child: SizedBox(
              height: 90.h,
              child: Column(
                children: [
                  SvgPicture.asset(
                    'assets/svg/login_svgs/signin.svg',
                    height: 25.h,
                  ),
                  RiseText('Sign In', style: theme.headlineMedium),
                  SizedBox(height: 2.h),
                  RiseTextField(
                    title: 'Email',
                    hintText: 'Enter your email',
                    controller: authController.emailController.value,
                    suffixIcon: FluentIcons.mail_48_regular,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) =>
                        Helpers.validateEmail(text: value ?? ""),
                    textInputAction: TextInputAction.next,
                  ),
                  SizedBox(height: 2.h),
                  RiseTextField(
                    title: 'Password',
                    hintText: 'Enter your password',
                    controller: authController.passwordController.value,
                    suffixIcon: FluentIcons.lock_closed_48_regular,
                    isPassword: true,
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                    // validator: (value) =>
                    //     Helpers.validatePassword(text: value ?? ""),
                  ),
                  SizedBox(height: 1.h),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () => context.go(forgotPassword),
                      child: RiseText('Forgot Password?',
                          style: theme.bodySmall!.copyWith(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ),
                  SizedBox(height: 2.h),
                  const Spacer(),
                  RiseButton(
                    title: 'Sign In',
                    onTap: () async {
                      if (signInFormKey.currentState!.validate()) {
                        final response = await authController.signIn(
                          email: authController.emailController.value.text,
                          password:
                              authController.passwordController.value.text,
                        );
                        if (response) {
                          EasyLoading.showSuccess('Login Successful');
                          // ignore: use_build_context_synchronously
                          context.go(loginSelectMood);
                        } else {
                          EasyLoading.showError('Login Failed');
                        }
                      }
                    },
                  ),
                  SizedBox(height: 2.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RiseText(
                        'Already have an account? ',
                        style: theme.bodySmall!
                            .copyWith(color: AppColors.textFieldColor),
                      ),
                      TextButton(
                        onPressed: () {
                          context.go(signUp);
                        },
                        child: RiseText(
                          'Sign Up',
                          style: theme.bodySmall!.copyWith(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
