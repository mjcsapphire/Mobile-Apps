import 'package:fcfs_banking_app/core/theme/colors.dart';
import 'package:fcfs_banking_app/core/theme/radialBg.dart';
import 'package:fcfs_banking_app/services/router/routes_name.dart';
import 'package:fcfs_banking_app/src/controllers/theme_controller.dart';
import 'package:fcfs_banking_app/src/views/widget/custom_app_bar.dart';
import 'package:fcfs_banking_app/src/views/widget/custom_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

class HelpSupportScreen extends StatefulWidget {
  const HelpSupportScreen({super.key});

  @override
  State<HelpSupportScreen> createState() => _HelpSupportScreenState();
}

class _HelpSupportScreenState extends State<HelpSupportScreen> {
  final themeController = Get.find<ThemeController>();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: "Reach Out to Us",
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
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              children: [
                const Spacer(),
                const Icon(Icons.support_agent,
                    color: AppColors.white, size: 80),
                SizedBox(height: 2.h),
                Text(
                  "How can we help you?",
                  style: theme.textTheme.headlineSmall,
                ),
                SizedBox(height: 3.h),
                CustomListTile(
                  title: "FAQs (Frequently asked questions)",
                  leading: const Icon(
                    Icons.question_mark_outlined,
                    color: AppColors.white,
                  ),
                  onTap: () {
                    context.pushNamed(RoutesName.faqsScreen);
                  },
                  trailingIcon: Icons.arrow_forward_ios_rounded,
                  border: Border.all(color: AppColors.white, width: 1),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
                SizedBox(height: 1.h),
                CustomListTile(
                  title: "Contact Live Chat",
                  leading: const Icon(
                    Icons.support_agent_rounded,
                    color: AppColors.white,
                  ),
                  onTap: () {
                    context.pushNamed(RoutesName.helpSupportChatScreen);
                  },
                  trailingIcon: Icons.arrow_forward_ios_rounded,
                  border: Border.all(color: AppColors.white, width: 1),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
                const Spacer(),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.pinkColor, width: 1),
                    color: AppColors.pinkColor,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Icon(Icons.mail_outline_rounded,
                      color: AppColors.white, size: 30),
                ),
                SizedBox(height: 1.h),
                Text("Send us an email", style: theme.textTheme.bodyLarge),
                Text("support@fantasy.com",
                    style: theme.textTheme.displaySmall),
                SizedBox(height: 2.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
