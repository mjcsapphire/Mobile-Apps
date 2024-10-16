import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/colors.dart';
import '../../controllers/home_controller.dart';

class TripleGNavBar {
  final HomeController homeController = Get.find<HomeController>();
  static tripleGNavBar(homeController) {
    return Obx(
      () => Container(
        decoration: const BoxDecoration(
          color: AppColors.secondaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: NavigationBar(
          backgroundColor: AppColors.transparent,
          selectedIndex: homeController.selectedIndex.value,
          onDestinationSelected: (value) {
            homeController.selectedIndex.value = value;
          },
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          indicatorColor: AppColors.transparent,
          overlayColor: const WidgetStatePropertyAll(AppColors.transparent),
          destinations: [
            NavigationDestination(
              icon: Image.asset(
                'assets/png/icon_home.png',
                color: AppColors.primaryColor,
                scale: 5,
              ),
              label: 'Home',
              selectedIcon: Image.asset(
                'assets/png/icon_home.png',
                color: AppColors.white,
                scale: 4,
              ),
            ),
            NavigationDestination(
              icon: Image.asset(
                'assets/png/church.png',
                color: AppColors.primaryColor,
                scale: 5,
              ),
              label: 'Church',
              selectedIcon: Image.asset(
                'assets/png/church.png',
                color: AppColors.white,
                scale: 4,
              ),
            ),
            NavigationDestination(
              icon: Image.asset(
                'assets/png/chat_messages.png',
                color: AppColors.primaryColor,
                scale: 5,
              ),
              label: 'Messages',
              selectedIcon: Image.asset(
                'assets/png/chat_messages.png',
                color: AppColors.white,
                scale: 4,
              ),
            ),
            NavigationDestination(
              icon: Image.asset(
                'assets/png/bookmark.png',
                color: AppColors.primaryColor,
                scale: 5,
              ),
              label: 'Bookmarks',
              selectedIcon: Image.asset(
                'assets/png/bookmark.png',
                color: AppColors.white,
                scale: 4,
              ),
            ),
            NavigationDestination(
              icon: Image.asset(
                'assets/png/menu.png',
                color: AppColors.primaryColor,
                scale: 5,
              ),
              label: 'Menu',
              selectedIcon: Image.asset(
                'assets/png/menu.png',
                color: AppColors.white,
                scale: 4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
