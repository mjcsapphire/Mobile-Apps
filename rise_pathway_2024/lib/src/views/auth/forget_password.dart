import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:rise_pathway/core/constants/package_export.dart';
import 'package:rise_pathway/core/helpers/helpers.dart';
import 'package:rise_pathway/core/routes/routes.dart';
import 'package:rise_pathway/src/views/widget/rise_button.dart';
import 'package:rise_pathway/src/views/widget/text_form_field.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
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
                  'assets/svg/forget_password.svg',
                ),
                SizedBox(height: 2.h),
                RiseText('Forget Password', style: theme.headlineMedium),
                SizedBox(height: 2.h),
                RiseText(
                  'Please Enter Your Email Address To Receive a Verification Code',
                  width: 70.w,
                  textAlign: TextAlign.center,
                  style: theme.labelMedium!.copyWith(
                    color: const Color(0xFF696969),
                  ),
                ),
                SizedBox(height: 2.h),
                RiseTextField(
                  title: 'Email Address',
                  hintText: 'Enter email address',
                  controller: emailController.value,
                  suffixIcon: FluentIcons.mail_48_regular,
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 2.h),
                const Spacer(),
                RiseButton(
                  title: 'Send OTP',
                  onTap: () => context.go(otpVerify),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
