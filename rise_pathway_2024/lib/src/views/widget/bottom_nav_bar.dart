import 'package:flutter/material.dart';
import 'package:rise_pathway/core/constants/package_export.dart';
import 'package:rise_pathway/core/helpers/helpers.dart';
import 'package:rise_pathway/core/utils/colors.dart';
import 'package:rise_pathway/src/controllers/home_controller.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final navIconPath = 'assets/nav_bar_icons/';

  final homeController = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Obx(() {
      final index = homeController.navIndex.value;
      return BottomAppBar(
        shadowColor: AppColors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                homeController.navIndex.value = 0;
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return index == 0
                          ? AppColorsGredients.primaryTopToBottom
                              .createShader(bounds)
                          : const LinearGradient(colors: [
                              AppColors.navIconGrey,
                              AppColors.navIconGrey,
                            ]).createShader(bounds);
                    },
                    child: Image.asset(
                      '${navIconPath}home.png',
                      scale: 4,
                    ),
                  ),
                  SizedBox(height: 1.w),
                  RiseText(
                    'Home',
                    style: index == 0
                        ? theme.labelSmall!.copyWith(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 10.sp,
                          )
                        : theme.labelSmall!.copyWith(
                            color: AppColors.navIconGrey,
                            fontWeight: FontWeight.w500,
                            fontSize: 10.sp,
                          ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                homeController.navIndex.value = 1;
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return index == 1
                          ? AppColorsGredients.primaryTopToBottom
                              .createShader(bounds)
                          : const LinearGradient(colors: [
                              AppColors.navIconGrey,
                              AppColors.navIconGrey,
                            ]).createShader(bounds);
                    },
                    child: Image.asset(
                      '${navIconPath}trophy.png',
                      scale: 4,
                    ),
                  ),
                  SizedBox(height: 1.w),
                  RiseText(
                    'Challenges',
                    style: index == 1
                        ? theme.labelSmall!.copyWith(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 10.sp,
                          )
                        : theme.labelSmall!.copyWith(
                            color: AppColors.navIconGrey,
                            fontWeight: FontWeight.w500,
                            fontSize: 10.sp,
                          ),
                  )
                ],
              ),
            ),
            SizedBox(width: 4.w),
            GestureDetector(
              onTap: () {
                homeController.navIndex.value = 2;
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return index == 2
                          ? AppColorsGredients.primaryTopToBottom
                              .createShader(bounds)
                          : const LinearGradient(colors: [
                              AppColors.navIconGrey,
                              AppColors.navIconGrey,
                            ]).createShader(bounds);
                    },
                    child: Image.asset(
                      '${navIconPath}journal.png',
                      scale: 4,
                    ),
                  ),
                  SizedBox(height: 1.w),
                  RiseText(
                    'Journal',
                    style: index == 2
                        ? theme.labelSmall!.copyWith(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 10.sp,
                          )
                        : theme.labelSmall!.copyWith(
                            color: AppColors.navIconGrey,
                            fontWeight: FontWeight.w500,
                            fontSize: 10.sp,
                          ),
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                homeController.navIndex.value = 3;
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return index == 3
                          ? AppColorsGredients.primaryTopToBottom
                              .createShader(bounds)
                          : const LinearGradient(colors: [
                              AppColors.navIconGrey,
                              AppColors.navIconGrey,
                            ]).createShader(bounds);
                    },
                    child: Image.asset(
                      '${navIconPath}oui_stats.png',
                      scale: 4,
                    ),
                  ),
                  SizedBox(height: 1.w),
                  RiseText(
                    'Reflection',
                    style: index == 3
                        ? theme.labelSmall!.copyWith(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 10.sp,
                          )
                        : theme.labelSmall!.copyWith(
                            color: AppColors.navIconGrey,
                            fontWeight: FontWeight.w500,
                            fontSize: 10.sp,
                          ),
                  )
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
