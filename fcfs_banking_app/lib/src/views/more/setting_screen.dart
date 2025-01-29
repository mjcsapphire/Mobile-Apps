import 'package:cached_network_image/cached_network_image.dart';
import 'package:fcfs_banking_app/core/theme/colors.dart';
import 'package:fcfs_banking_app/core/theme/radialBg.dart';
import 'package:fcfs_banking_app/core/utils/app_helpers.dart';
import 'package:fcfs_banking_app/services/router/routes_name.dart';
import 'package:fcfs_banking_app/src/controllers/auth_controller.dart';
import 'package:fcfs_banking_app/src/controllers/theme_controller.dart';
import 'package:fcfs_banking_app/src/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({super.key});

  final UserController usercontroller = Get.find<UserController>();
  final AuthController authController = Get.find<AuthController>();
  final ThemeController themeController = Get.find<ThemeController>();
  @override
  Widget build(BuildContext context) {
    final user = usercontroller.user.value;
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
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: TextButton(
                      onPressed: () => context.pop(),
                      child: Text(
                        'Close',
                        style: theme.textTheme.displayMedium!
                            .copyWith(color: Colors.white, fontSize: 18.sp),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                          radius: 80,
                          backgroundColor: Colors.white,
                          backgroundImage: CachedNetworkImageProvider(user
                                  ?.profileImageUrl ??
                              "https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png")),
                      // Positioned(
                      //   top: -6,
                      //   child: IconButton(
                      //     icon: Container(
                      //       padding: const EdgeInsets.all(4),
                      //       decoration: const BoxDecoration(
                      //         shape: BoxShape.circle,
                      //         color: AppColors.red,
                      //       ),
                      //       child: const Icon(
                      //         Icons.camera_alt_outlined,
                      //         color: Colors.white,
                      //         size: 24,
                      //       ),
                      //     ),
                      //     onPressed: () {
                      //       // Implement profile picture change functionality
                      //     },
                      //   ),
                      // ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Lorem ipsum dolor sit amet,\nconsectetur adipiscing elit',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              children: [
                                _buildOptionTile(
                                    'Password and security', context, theme,
                                    onTap: () {}),
                                _buildOptionTile(
                                    'Personal details', context, theme,
                                    onTap: () {
                                  context.pushNamed(RoutesName.profileScreen);
                                }),
                                _buildOptionTile('Preferences', context, theme,
                                    onTap: () {}),
                                _buildOptionTile('Legal', context, theme,
                                    onTap: () {}),
                              ],
                            )),

                        // const Spacer(),
                        SizedBox(height: 2.h),
                        _buildButton('About us', context, theme, onTap: () {}),
                        _buildButton('Close account', context, theme,
                            onTap: () {
                          _showConfirmationDialog(
                              context, 'delete your account', () {});
                        }),
                        _buildButton('Logout', context, theme, onTap: () {
                          debugPrint(' Sign Out tapped');

                          _showConfirmationDialog(context, 'logout', () {
                            AppHelpers.setLoggedInStatus(false);
                            authController.signOutUser();

                            Future.delayed(const Duration(milliseconds: 500),
                                () {
                              context.goNamed(RoutesName.loginPage);
                            });
                          });
                        }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showConfirmationDialog(
      BuildContext context, String action, VoidCallback onPress) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: themeController.themeMode == ThemeMode.dark
              ? AppColors.darkBgColor1
              : AppColors.stackContainerColor1,
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          contentPadding: EdgeInsets.all(4.w),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Are you sure you want to $action ',
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 3.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            themeController.themeMode == ThemeMode.dark
                                ? AppColors.darkBorderColor
                                : AppColors.white,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Cancel',
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium
                            ?.copyWith(
                              color: themeController.themeMode == ThemeMode.dark
                                  ? AppColors.white
                                  : Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            themeController.themeMode == ThemeMode.dark
                                ? AppColors.red
                                : AppColors.red,
                      ),
                      onPressed: onPress,
                      child: Text(
                        action == 'delete your account' ? 'Delete' : 'Logout',
                        style:
                            Theme.of(context).textTheme.displayMedium?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildOptionTile(String title, BuildContext context, ThemeData theme,
      {required VoidCallback onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.2),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: theme.textTheme.displayMedium!
                .copyWith(fontWeight: FontWeight.w600, fontSize: 16.sp),
          ),
        ),
      ),
    );
  }

  Widget _buildButton(String title, BuildContext context, ThemeData theme,
      {required VoidCallback onTap}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50),
          backgroundColor: themeController.themeMode == ThemeMode.dark
              ? AppColors.darkBorderColor
              : AppColors.peachOrange.withOpacity(0.4),
          foregroundColor: themeController.themeMode == ThemeMode.dark
              ? AppColors.darkBorderColor
              : AppColors.peachOrange.withOpacity(0.4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        onPressed: onTap,
        child: Text(
          title,
          style: theme.textTheme.displayMedium!
              .copyWith(fontWeight: FontWeight.w600, fontSize: 16.sp),
        ),
      ),
    );
  }
}
