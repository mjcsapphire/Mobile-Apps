import 'package:fcfs_banking_app/core/theme/colors.dart';
import 'package:fcfs_banking_app/core/utils/constant/app_assets_constant.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? profilePicUrl;
  final String title;
  final VoidCallback? onNotificationTap;
  final VoidCallback? onMoreVertTap;
  final VoidCallback? onProfileTap;
  final VoidCallback? onEditIconTap;
  final bool showNotificationIcon;
  final bool showMoreVertIcon;
  final bool showProfilePic;
  final bool showEditIcon;

  const CustomAppBar({
    super.key,
    required this.title,
    this.profilePicUrl,
    this.onNotificationTap,
    this.onMoreVertTap,
    this.onProfileTap,
    this.onEditIconTap,
    this.showNotificationIcon = true,
    this.showMoreVertIcon = true,
    this.showProfilePic = true,
    this.showEditIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 7.5.h,
      backgroundColor: Colors.transparent,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppAssetsConstant.upperBackground),
            fit: BoxFit.cover,
          ),
        ),
      ),
      title: Row(
        children: [
          if (showProfilePic && profilePicUrl != null)
            GestureDetector(
              onTap: onProfileTap,
              child: CircleAvatar(
                backgroundImage: AssetImage(profilePicUrl!),
              ),
            ),
          if (showProfilePic) const SizedBox(width: 10),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 18.sp,
                fontFamily: "RobotoMono"),
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
