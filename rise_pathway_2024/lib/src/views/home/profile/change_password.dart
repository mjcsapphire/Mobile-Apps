import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:rise_pathway/config/constants/package_export.dart';
import 'package:rise_pathway/src/views/widget/app_bar.dart';
import 'package:rise_pathway/src/views/widget/rise_button.dart';
import 'package:rise_pathway/src/views/widget/text_form_field.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final currentPassword = TextEditingController().obs;
  final newPasswordController = TextEditingController().obs;
  final confirmNewPasswordController = TextEditingController().obs;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: RiseAppBar.riseAppBar(
        theme: theme,
        title: 'Change Password',
        onTap: () => context.pop(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            SizedBox(height: 2.h),
            RiseTextField(
              title: 'Current Password',
              hintText: 'Enter Current Password',
              suffixIcon: FluentIcons.eye_off_32_regular,
              keyboardType: TextInputType.visiblePassword,
              controller: currentPassword.value,
            ),
            SizedBox(height: 2.h),
            RiseTextField(
              title: 'New Password',
              hintText: 'Enter New Password',
              suffixIcon: FluentIcons.eye_off_32_regular,
              keyboardType: TextInputType.visiblePassword,
              controller: newPasswordController.value,
            ),
            SizedBox(height: 2.h),
            RiseTextField(
              title: 'Confirm New Password',
              hintText: 'Enter Confirm New Password',
              suffixIcon: FluentIcons.eye_off_32_regular,
              keyboardType: TextInputType.visiblePassword,
              controller: confirmNewPasswordController.value,
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: RiseButton(
        width: 90.w,
        title: 'Change',
        onTap: () {},
      ),
    );
  }
}
