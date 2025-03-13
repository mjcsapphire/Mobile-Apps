import 'package:fcfs_banking_app/core/theme/colors.dart';
import 'package:fcfs_banking_app/core/theme/radialBg.dart';
import 'package:fcfs_banking_app/src/controllers/theme_controller.dart';
import 'package:fcfs_banking_app/src/views/widget/custom_app_bar.dart';
import 'package:fcfs_banking_app/src/views/widget/custom_button.dart';
import 'package:fcfs_banking_app/src/views/widget/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class CreateNewPassword extends StatefulWidget {
  const CreateNewPassword({super.key});

  @override
  State<CreateNewPassword> createState() => _CreateNewPasswordState();
}

class _CreateNewPasswordState extends State<CreateNewPassword> {
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();
  final themeController = Get.find<ThemeController>();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
        appBar: CustomAppBar(
          title: "New Password",
          showMoreVertIcon: true,
          showEditIcon: false,
          showNotificationIcon: false,
          showProfilePic: false,
          onMoreVertTap: () {},
        ),
        body: Stack(children: [
          CustomPaint(
            size: Size(
              MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height,
            ),
            painter: themeController.themeMode == ThemeMode.dark
                ? DarkGradientBackgroundPainter()
                : GradientBackgroundPainter(),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16.h),
                Text(
                  "Enter new password",
                  style: theme.textTheme.displayMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 17.sp,
                  ),
                ),
                SizedBox(height: 2.h),
                TextfieldWidget(
                  label: "Enter new password",
                  keyboardType: TextInputType.visiblePassword,
                  controller: newPasswordController,
                  obscureText: true,
                ),
                SizedBox(height: 2.h),
                Text(
                  "Re-enter new password",
                  style: theme.textTheme.displayMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 17.sp,
                  ),
                ),
                SizedBox(height: 2.h),
                TextfieldWidget(
                  label: "Enter new password again",
                  keyboardType: TextInputType.visiblePassword,
                  controller: confirmNewPasswordController,
                  obscureText: true,
                ),
                SizedBox(height: 4.h),
                CustomButtonWidget(
                  onTap: () {},
                  width: MediaQuery.of(context).size.width * 0.9,
                  text: "update Password",
                  color: themeController.themeMode == ThemeMode.dark
                      ? AppColors.darkBorderColor
                      : AppColors.red,
                  borderColor: themeController.themeMode == ThemeMode.dark
                      ? AppColors.darkBorderColor
                      : AppColors.red,
                  fontSize: 18.sp,
                  radius: 8,
                  isIconAvailable: false,
                ),
              ],
            ),
          )
        ]));
  }
}
