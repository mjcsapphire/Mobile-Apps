import 'package:fcfs_banking_app/core/theme/colors.dart';
import 'package:fcfs_banking_app/core/theme/radialBg.dart';
import 'package:fcfs_banking_app/services/router/routes_name.dart';
import 'package:fcfs_banking_app/src/controllers/auth_controller.dart';
import 'package:fcfs_banking_app/src/controllers/theme_controller.dart';
import 'package:fcfs_banking_app/src/controllers/user_controller.dart';
import 'package:fcfs_banking_app/src/views/widget/custom_app_bar.dart';
import 'package:fcfs_banking_app/src/views/widget/custom_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  AuthController authController = Get.find<AuthController>();
  UserController userController = Get.find<UserController>();
  ThemeController themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(builder: (themeController) {
      final theme = Theme.of(context);
      return Scaffold(
        appBar: CustomAppBar(
          title: "More Options",
          showMoreVertIcon: false,
          showNotificationIcon: false,
          showProfilePic: false,
          onMoreVertTap: () {},
          onNotificationTap: () {},
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
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Obx(() {
                final user = userController.user.value;

                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 2.h),
                      CustomListTile(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 0.5.h, horizontal: 4.w),
                        border: Border.all(
                          color: AppColors.white,
                          width: 1,
                        ),
                        titleStyle: theme.textTheme.displaySmall!.copyWith(
                          fontSize: 17.sp,
                        ),
                        title: "Account",
                        leading: Icon(
                          Icons.account_box_rounded,
                          color: AppColors.white.withOpacity(0.9),
                        ),
                        trailingIcon: Icons.arrow_forward_ios,
                        onTap: () {
                          debugPrint('Account tapped');
                          context.pushNamed(RoutesName.setting);
                        },
                      ),

                      if (user!.role == 'Business')
                        CustomListTile(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 0.5.h, horizontal: 4.w),
                          border: Border.all(
                            color: AppColors.white,
                            width: 1,
                          ),
                          titleStyle: theme.textTheme.displaySmall!.copyWith(
                            fontSize: 17.sp,
                          ),
                          title: "Request Direct Debit",
                          leading: Icon(
                            Icons.manage_accounts_outlined,
                            color: AppColors.white.withOpacity(0.9),
                          ),
                          trailingIcon: Icons.arrow_forward_ios,
                          onTap: () {
                            // Add action for tap
                            // user!.role == 'Personal'
                            //     ?
                            context.pushNamed(RoutesName.personalDashboard);
                            // : context.pushNamed(RoutesName.businessDashboard);
                          },
                        ),
                      if (user.role == 'Personal')
                        CustomListTile(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 0.5.h, horizontal: 4.w),
                          border: Border.all(
                            color: AppColors.white,
                            width: 1,
                          ),
                          titleStyle: theme.textTheme.displaySmall!.copyWith(
                            fontSize: 17.sp,
                          ),
                          title: "Request Standing Order",
                          leading: Icon(
                            Icons.manage_accounts_outlined,
                            color: AppColors.white.withOpacity(0.9),
                          ),
                          trailingIcon: Icons.arrow_forward_ios,
                          onTap: () {
                            // Add action for tap
                            // user!.role == 'Personal'
                            //     ?
                            context.pushNamed(RoutesName.personalDashboard);
                            // : context.pushNamed(RoutesName.businessDashboard);
                          },
                        ),

                      CustomListTile(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 0.5.h, horizontal: 4.w),
                        border: Border.all(
                          color: AppColors.white,
                          width: 1,
                        ),
                        titleStyle: theme.textTheme.displaySmall!.copyWith(
                          fontSize: 17.sp,
                        ),
                        title: "Manage Standing Orders",
                        leading: Icon(
                          Icons.manage_accounts_outlined,
                          color: AppColors.white.withOpacity(0.9),
                        ),
                        trailingIcon: Icons.arrow_forward_ios,
                        onTap: () {
                          // Add action for tap
                          // user!.role == 'Personal'
                          //     ? context.pushNamed(RoutesName.personalDashboard)
                          // :
                          context.pushNamed(RoutesName.businessDashboard);
                          debugPrint(' Setting tapped');
                        },
                      ),
                      CustomListTile(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 0.5.h, horizontal: 4.w),
                        border: Border.all(
                          color: AppColors.white,
                          width: 1,
                        ),
                        titleStyle: theme.textTheme.displaySmall!.copyWith(
                          fontSize: 17.sp,
                        ),
                        title: "Settings",
                        leading: Icon(
                          Icons.settings,
                          color: AppColors.white.withOpacity(0.9),
                        ),
                        trailingIcon: Icons.arrow_forward_ios,
                        onTap: () {
                          // Add action for tap
                          debugPrint(' Permission tapped');
                          context.pushNamed(RoutesName.managePermission);
                        },
                      ),
                      if (user.role == 'Business')
                        CustomListTile(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 0.5.h, horizontal: 4.w),
                          border: Border.all(
                            color: AppColors.white,
                            width: 1,
                          ),
                          titleStyle: theme.textTheme.displaySmall!.copyWith(
                            fontSize: 17.sp,
                          ),
                          title: "Add products",
                          leading: Icon(
                            Icons.add_box_rounded,
                            color: AppColors.white.withOpacity(0.9),
                          ),
                          trailingIcon: Icons.arrow_forward_ios,
                          onTap: () {
                            // Add action for tap
                            debugPrint(' Add products tapped');
                            context.pushNamed(RoutesName.productScreen);
                          },
                        ),
                      // if (user.role == 'Business')
                      CustomListTile(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 0.5.h, horizontal: 4.w),
                        border: Border.all(
                          color: AppColors.white,
                          width: 1,
                        ),
                        titleStyle: theme.textTheme.displaySmall!.copyWith(
                          fontSize: 17.sp,
                        ),
                        title: "Make Community Investments",
                        leading: Icon(
                          Icons.attach_money_rounded,
                          color: AppColors.white.withOpacity(0.9),
                        ),
                        trailingIcon: Icons.arrow_forward_ios,
                        onTap: () {
                          // Add action for tap
                          debugPrint('Make Community Investments tapped');
                          context.pushNamed(RoutesName.communityFunding);
                        },
                      ),
                      // CustomListTile(
                      //   contentPadding: EdgeInsets.symmetric(
                      //       vertical: 0.5.h, horizontal: 4.w),
                      //   border: Border.all(
                      //     color: AppColors.white,
                      //     width: 1,
                      //   ),
                      //   titleStyle: theme.textTheme.displaySmall!.copyWith(
                      //     fontSize: 17.sp,
                      //   ),
                      //   title: "Request Received",
                      //   leading: Icon(
                      //     Icons.request_page,
                      //     color: AppColors.white.withOpacity(0.9),
                      //   ),
                      //   trailingIcon: Icons.arrow_forward_ios,
                      //   onTap: () {
                      //     // Add action for tap

                      //     context.pushNamed(RoutesName.requestReceived);
                      //   },
                      // ),
                      CustomListTile(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 0.5.h, horizontal: 4.w),
                        border: Border.all(
                          color: AppColors.white,
                          width: 1,
                        ),
                        titleStyle: theme.textTheme.displaySmall!.copyWith(
                          fontSize: 17.sp,
                        ),
                        title: "Rewards",
                        leading: Icon(
                          Icons.redeem_rounded,
                          color: AppColors.white.withOpacity(0.9),
                        ),
                        trailingIcon: Icons.arrow_forward_ios,
                        onTap: () {
                          // Add action for tap
                          debugPrint('Rewards tapped');
                          context.pushNamed(RoutesName.rewards);
                        },
                      ),
                      CustomListTile(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 0.5.h, horizontal: 4.w),
                        border: Border.all(
                          color: AppColors.white,
                          width: 1,
                        ),
                        titleStyle: theme.textTheme.displaySmall!.copyWith(
                          fontSize: 17.sp,
                        ),
                        title: "Help & Support",
                        leading: Icon(
                          Icons.support_agent,
                          color: AppColors.white.withOpacity(0.9),
                        ),
                        trailingIcon: Icons.arrow_forward_ios,
                        onTap: () {
                          // Add action for tap
                          debugPrint(' Support tapped');
                          context.pushNamed(RoutesName.helpSupportScreen);
                        },
                      ),
                      CustomListTile(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 0.5.h, horizontal: 4.w),
                        border: Border.all(
                          color: AppColors.white,
                          width: 1,
                        ),
                        titleStyle: theme.textTheme.displaySmall!.copyWith(
                          fontSize: 17.sp,
                        ),
                        title: "Privacy Policy ",
                        leading: Icon(
                          Icons.privacy_tip_sharp,
                          color: AppColors.white.withOpacity(0.9),
                        ),
                        trailingIcon: Icons.arrow_forward_ios,
                        onTap: () {
                          // Add action for tap
                          debugPrint(' Privacy tapped');
                          context.pushNamed(RoutesName.privacyPolicyScreen);
                        },
                      ),
                      CustomListTile(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 0.5.h, horizontal: 4.w),
                        border: Border.all(
                          color: AppColors.white,
                          width: 1,
                        ),
                        titleStyle: theme.textTheme.displaySmall!.copyWith(
                          fontSize: 17.sp,
                        ),
                        title: "Terms & Conditions",
                        leading: Icon(
                          Icons.description_outlined,
                          color: AppColors.white.withOpacity(0.9),
                        ),
                        trailingIcon: Icons.arrow_forward_ios,
                        onTap: () {
                          // Add action for tap
                          debugPrint('Terms & Conditions');
                          context.pushNamed(RoutesName.termsConditionScreen);
                        },
                      ),
                      // CustomListTile(
                      //   contentPadding: EdgeInsets.symmetric(
                      //       vertical: 0.5.h, horizontal: 4.w),
                      //   border: Border.all(
                      //     color: AppColors.white,
                      //     width: 1,
                      //   ),
                      //   titleStyle: theme.textTheme.displaySmall!.copyWith(
                      //     fontSize: 17.sp,
                      //   ),
                      //   title: "SignOut ",
                      //   leading: Icon(
                      //     Icons.logout,
                      //     color: AppColors.white.withOpacity(0.9),
                      //   ),
                      //   onTap: () {
                      //     debugPrint(' Sign Out tapped');
                      //     AppHelpers.setLoggedInStatus(false);
                      //     authController.signOutUser();
                      //     Future.delayed(const Duration(milliseconds: 500), () {
                      //       context.goNamed(RoutesName.loginPage);
                      //     });
                      //   },
                      // ),
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
      );
    });
  }
}
