import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:rise_pathway/core/constants/package_export.dart';
import 'package:rise_pathway/core/helpers/helpers.dart';
import 'package:rise_pathway/core/routes/routes.dart';
import 'package:rise_pathway/core/utils/colors.dart';
import 'package:rise_pathway/src/controllers/auth_controller.dart';
import 'package:rise_pathway/src/views/widget/rise_button.dart';
import 'package:rise_pathway/src/views/widget/text_form_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  final confirmPasswordController = TextEditingController().obs;

  final authController = Get.find<AuthController>();
  final signUpFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: signUpFormKey,
            child: Column(
              children: [
                SvgPicture.asset(
                  'assets/svg/login_svgs/signup.svg',
                ),
                RiseText('Sign Up', style: theme.headlineMedium),
                SizedBox(height: 2.h),
                RiseTextField(
                  title: 'Email',
                  hintText: 'Enter your email',
                  controller: emailController.value,
                  suffixIcon: FluentIcons.mail_48_regular,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: (p0) => Helpers.validateEmail(text: p0 ?? ""),
                ),
                SizedBox(height: 2.h),
                RiseTextField(
                  title: 'Password',
                  hintText: 'Enter your password',
                  controller: passwordController.value,
                  suffixIcon: FluentIcons.lock_closed_48_regular,
                  isPassword: true,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.next,
                  validator: (p0) => Helpers.validatePassword(text: p0 ?? ""),
                ),
                SizedBox(height: 2.h),
                RiseTextField(
                  title: 'Confirm Password',
                  hintText: 'Enter your confirm password',
                  controller: confirmPasswordController.value,
                  suffixIcon: FluentIcons.eye_off_32_regular,
                  isPassword: true,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  validator: (p0) => Helpers.validatePassword(text: p0 ?? ""),
                ),
                SizedBox(height: 10.h),
                RiseButton(
                  title: 'Sign Up',
                  onTap: () async {
                    if (signUpFormKey.currentState!.validate()) {
                      final response = await authController.signUp(
                        name: "--",
                        email: emailController.value.text,
                        password: passwordController.value.text,
                        confirmPassword: confirmPasswordController.value.text,
                      );
                      if (response) {
                        context.go(signupSelectMood);
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
                      onPressed: () => context.go(login),
                      child: RiseText(
                        'Sign In',
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
    );
  }
}
