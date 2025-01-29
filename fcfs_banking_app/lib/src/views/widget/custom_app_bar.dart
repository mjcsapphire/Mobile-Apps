import 'package:cached_network_image/cached_network_image.dart';
import 'package:fcfs_banking_app/core/theme/colors.dart';
import 'package:fcfs_banking_app/core/utils/constant/app_assets_constant.dart';
import 'package:fcfs_banking_app/src/controllers/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? profilePicUrl;
  final String title;
  final VoidCallback? onNotificationTap;
  final VoidCallback? onMoreVertTap;
  final VoidCallback? onProfileTap;
  final VoidCallback? onEditIconTap;
  final VoidCallback? onShareTap;
  final bool showNotificationIcon;
  final bool showMoreVertIcon;
  final bool showProfilePic;
  final bool showEditIcon;
  final bool showShareIcon;

  CustomAppBar({
    super.key,
    required this.title,
    this.profilePicUrl,
    this.onNotificationTap,
    this.onMoreVertTap,
    this.onProfileTap,
    this.onEditIconTap,
    this.onShareTap,
    this.showNotificationIcon = true,
    this.showMoreVertIcon = true,
    this.showProfilePic = true,
    this.showEditIcon = false,
    this.showShareIcon = false,
  });

  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return AppBar(
        toolbarHeight: 7.5.h,
        backgroundColor: AppColors.transparent,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: themeController.themeMode == ThemeMode.light
                ? AppColors.stackContainerBackground
                : AppColors.darkAppBarGradient
            // color: AppColors.white,
          ),
        ),
        title: Row(
          children: [
            if (showProfilePic && profilePicUrl != null)
              GestureDetector(
                onTap: onProfileTap,
                child: CircleAvatar(
                  backgroundColor: AppColors.white,
                  backgroundImage: profilePicUrl != null
                      ? CachedNetworkImageProvider(profilePicUrl!)
                      : const AssetImage(AppAssetsConstant.profile2)
                          as ImageProvider,
                  child: profilePicUrl == null
                      ? Image.asset(
                          AppAssetsConstant.profile2,
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
              ),
            if (showProfilePic) const SizedBox(width: 10),
            Text(
              title,
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 18.sp,
                    fontFamily: "Montserrat",
                  ),
            ),
            const Spacer(),
            if (showNotificationIcon)
              IconButton(
                icon: Image.asset(
                  AppAssetsConstant.notification,
                  height: 25,
                  width: 25,
                ),
                onPressed: onNotificationTap,
              ),
            if (showEditIcon)
              IconButton(
                icon: const Icon(
                  Icons.edit,
                  color: AppColors.white,
                  size: 24,
                ),
                onPressed: onEditIconTap,
              ),
            if (showShareIcon)
              IconButton(
                icon: const Icon(
                  Icons.ios_share_outlined,
                  color: AppColors.white,
                  size: 24,
                ),
                onPressed: onShareTap,
              ),
            if (showMoreVertIcon)
              GestureDetector(
                onTap: onEditIconTap,
                child: IconButton(
                  icon: const Icon(
                    Icons.more_vert,
                    color: AppColors.white,
                  ),
                  onPressed: onMoreVertTap,
                ),
              ),
          ],
        ),
      );
  
  }

  @override
  Size get preferredSize => Size.fromHeight(8.h);
}
