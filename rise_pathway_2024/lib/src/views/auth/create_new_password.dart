import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:rise_pathway/config/constants/package_export.dart';
import 'package:rise_pathway/config/helpers/helpers.dart';
import 'package:rise_pathway/config/routes/routes.dart';
import 'package:rise_pathway/src/views/widget/rise_button.dart';
import 'package:rise_pathway/src/views/widget/text_form_field.dart';

class CreateNewPassword extends StatefulWidget {
  const CreateNewPassword({super.key});

  @override
  State<CreateNewPassword> createState() => _CreateNewPasswordState();
}

class _CreateNewPasswordState extends State<CreateNewPassword> {
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
                RiseText('Create New Password', style: theme.headlineSmall),
                SizedBox(height: 2.h),
                RiseText(
                  'Your New Password Must be Different from Previously Used Password',
                  width: 80.w,
                  textAlign: TextAlign.center,
                  style: theme.labelMedium!.copyWith(
                    color: const Color(0xFF696969),
                  ),
                ),
                SizedBox(height: 2.h),
                RiseTextField(
                  title: 'New Password',
                  hintText: 'Enter New Password',
                  controller: emailController.value,
                  suffixIcon: FluentIcons.lock_closed_48_regular,
                  keyboardType: TextInputType.visiblePassword,
                  isPassword: true,
                ),
                SizedBox(height: 2.h),
                RiseTextField(
                  title: 'Confirm New Password',
                  hintText: 'Enter Confirm New Password',
                  controller: emailController.value,
                  suffixIcon: FluentIcons.lock_closed_48_regular,
                  keyboardType: TextInputType.visiblePassword,
                  isPassword: true,
                ),
                SizedBox(height: 2.h),
                const Spacer(),
                RiseButton(
                  title: 'Save',
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
