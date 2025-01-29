import 'package:fcfs_banking_app/core/theme/colors.dart';
import 'package:fcfs_banking_app/core/theme/radialBg.dart';
import 'package:fcfs_banking_app/core/utils/app_helpers.dart';
import 'package:fcfs_banking_app/src/controllers/auth_controller.dart';
import 'package:fcfs_banking_app/src/controllers/theme_controller.dart';
import 'package:fcfs_banking_app/src/views/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class ManagePermissionScreen extends StatefulWidget {
  const ManagePermissionScreen({super.key});

  @override
  State<ManagePermissionScreen> createState() => _ManagePermissionScreenState();
}

class _ManagePermissionScreenState extends State<ManagePermissionScreen> {
  AuthController authController = Get.find<AuthController>();
  ThemeController themeController = Get.find<ThemeController>();

  @override
  void initState() {
    super.initState();
    authController.checkBiometricStatus();
  }

  Rx<bool> enableNotifications = false.obs;
  Rx<bool> enableLocation = false.obs;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      builder: (themeController) {
        final theme = Theme.of(context);
        return Scaffold(
          appBar: CustomAppBar(
            title: "Settings",
            showMoreVertIcon: false,
            showNotificationIcon: false,
            showProfilePic: false,
            onMoreVertTap: () {},
          ),
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 2.h),
                  Expanded(
                    child: ListView(
                      children: [
                        Obx(() {
                          return buildPermissionTile(
                            theme,
                            permission: 'Allow Biometric Lock',
                            isEnabled: authController.biometricEnabled.value,
                            description:
                                'Use your fingerprint or face ID for secure login.',
                            onChanged: (newValue) async {
                              if (newValue) {
                                await authController.enableBiometrics();
                              } else {
                                await authController.disableBiometrics();
                              }

                              AppHelpers.toast(
                                  "Biometric Lock is now ${newValue ? 'enabled' : 'disabled'}");
                            },
                          );
                        }),
                        buildPermissionTile(
                          theme,
                          permission: 'Allow Notifications',
                          isEnabled: enableNotifications.value,
                          description:
                              'Receive notifications for transactions and updates.',
                          onChanged: (newValue) {
                            setState(() {
                              enableNotifications.value = newValue;
                            });
                          },
                        ),
                        buildPermissionTile(
                          theme,
                          permission: 'Allow Location',
                          isEnabled: enableLocation.value,
                          description:
                              'Enable location for nearby branches and ATMs.',
                          onChanged: (newValue) {
                            setState(() {
                              enableLocation.value = newValue;
                            });
                          },
                        ),
                        buildPermissionTile(
                          theme,
                          permission: 'Light / Dark mode',
                          isEnabled:
                              themeController.themeMode == ThemeMode.dark,
                          description:
                              'Customize the app theme to your preference.',
                          onChanged: (newValue) async {
                            themeController.toggleTheme(newValue);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildPermissionTile(
    ThemeData theme, {
    required String permission,
    required bool isEnabled,
    required String description,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: AppColors.white.withOpacity(0.5),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  permission,
                  style: theme.textTheme.displaySmall
                      ?.copyWith(fontSize: 16.sp, fontWeight: FontWeight.bold),
                ),
                Switch(
                  activeColor: themeController.themeMode == ThemeMode.dark
                      ? AppColors.white
                      : AppColors.red,
                  value: isEnabled,
                  onChanged: onChanged,
                ),
              ],
            ),
            Text(
              description,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.grey[400],
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
