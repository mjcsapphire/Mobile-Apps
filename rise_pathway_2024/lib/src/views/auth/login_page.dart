import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:rise_pathway/config/constants/package_export.dart';
import 'package:rise_pathway/config/helpers/helpers.dart';
import 'package:rise_pathway/config/routes/routes.dart';
import 'package:rise_pathway/config/utils/colors.dart';
import 'package:rise_pathway/src/views/widget/rise_button.dart';
import 'package:rise_pathway/src/views/widget/text_form_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: SizedBox(
            height: 90.h,
            child: Column(
              children: [
                SvgPicture.asset(
                  'assets/svg/login_svgs/signin.svg',
                ),
                RiseText('Sign In', style: theme.headlineMedium),
                SizedBox(height: 2.h),
                RiseTextField(
                  title: 'Email',
                  hintText: 'Enter your email',
                  controller: emailController.value,
                  suffixIcon: FluentIcons.mail_48_regular,
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 2.h),
                RiseTextField(
                  title: 'Password',
                  hintText: 'Enter your password',
                  controller: passwordController.value,
                  suffixIcon: FluentIcons.lock_closed_48_regular,
                  isPassword: true,
                  keyboardType: TextInputType.visiblePassword,
                ),
                SizedBox(height: 2.h),
                const Spacer(),
                RiseButton(
                  title: 'Sign In',
                  onTap: () => context.go(selectMood),
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
                      onPressed: () => context.go(signUp),
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
    );
  }
}
