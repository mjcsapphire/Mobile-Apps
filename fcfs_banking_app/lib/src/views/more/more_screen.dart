import 'package:fcfs_banking_app/core/theme/colors.dart';
import 'package:fcfs_banking_app/core/utils/constant/app_assets_constant.dart';
import 'package:fcfs_banking_app/services/router/routes_name.dart';
import 'package:fcfs_banking_app/src/controllers/auth_controller.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "More Options",
        showMoreVertIcon: true,
        showNotificationIcon: false,
        showProfilePic: false,
        onMoreVertTap: () {},
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppAssetsConstant.upperBackground),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: AppColors.black,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 5.h),
                CustomListTile(
                  title: "Profile Setting",
                  leading: Icon(
                    Icons.person_3_outlined,
                    color: AppColors.white.withOpacity(0.9),
                  ),
                  trailingIcon: Icons.arrow_forward_ios,
                  onTap: () {
                    debugPrint('Profile Setting tapped');
                    context.pushNamed(RoutesName.profileScreen);
                  },
                ),
                CustomListTile(
                  title: "Setting",
                  leading: Icon(
                    Icons.settings,
                    color: AppColors.white.withOpacity(0.9),
                  ),
                  trailingIcon: Icons.arrow_forward_ios,
                  onTap: () {
                    // Add action for tap
                    debugPrint(' Setting tapped');
                  },
                ),
                CustomListTile(
                  title: "Manage Permissions",
                  leading: Icon(
                    Icons.vpn_key_off_outlined,
                    color: AppColors.white.withOpacity(0.9),
                  ),
                  trailingIcon: Icons.arrow_forward_ios,
                  onTap: () {
                    // Add action for tap
                    debugPrint(' Permission tapped');
                  },
                ),
                CustomListTile(
                  title: "FAQs",
                  leading: Icon(
                    Icons.question_mark_rounded,
                    color: AppColors.white.withOpacity(0.9),
                  ),
                  trailingIcon: Icons.arrow_forward_ios,
                  onTap: () {
                    // Add action for tap
                    debugPrint(' FAQs tapped');
                    context.pushNamed(RoutesName.faqsScreen);
                  },
                ),
                CustomListTile(
                  title: "Help & Support",
                  leading: Icon(
                    Icons.support_agent,
                    color: AppColors.white.withOpacity(0.9),
                  ),
                  trailingIcon: Icons.arrow_forward_ios,
                  onTap: () {
                    // Add action for tap
                    debugPrint(' Support tapped');
                  },
                ),
                CustomListTile(
                  title: "Privacy Policy ",
                  leading: Icon(
                    Icons.privacy_tip_sharp,
                    color: AppColors.white.withOpacity(0.9),
                  ),
                  trailingIcon: Icons.arrow_forward_ios,
                  onTap: () {
                    // Add action for tap
                    debugPrint(' Privacy tapped');
                  },
                ),
                CustomListTile(
                  title: "Terms & Conditions",
                  leading: Icon(
                    Icons.description_outlined,
                    color: AppColors.white.withOpacity(0.9),
                  ),
                  trailingIcon: Icons.arrow_forward_ios,
                  onTap: () {
                    // Add action for tap
                    debugPrint('Terms & Conditions');
                  },
                ),
                CustomListTile(
                  title: "SignOut ",
                  leading: Icon(
                    Icons.logout,
                    color: AppColors.white.withOpacity(0.9),
                  ),
                  onTap: () {
                    // Add action for tap
                    debugPrint(' Sign Out tapped');
                    authController.signOutUser();
                    Future.delayed(const Duration(milliseconds: 500), () {
                      context.goNamed(RoutesName.loginPage);
                    });
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
