import 'package:flutter/material.dart';
import 'package:rise_pathway/core/constants/package_export.dart';
import 'package:rise_pathway/core/helpers/helpers.dart';
import 'package:rise_pathway/core/utils/colors.dart';
import 'package:rise_pathway/src/controllers/home_controller.dart';
import 'package:rise_pathway/src/views/challenges/challenges.dart';
import 'package:rise_pathway/src/views/home/home.dart';
import 'package:rise_pathway/src/views/journal/journal.dart';
import 'package:rise_pathway/src/views/reflection/reflection.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final homeController = Get.find<HomeController>();
  final navTab = [
    const HomePage(),
    const Challenges(),
    const Journal(),
    const Reflection(),
  ];

  @override
  Widget build(BuildContext context) {
    final RxDouble progress = .20.obs;
    const navIconPath = 'assets/nav_bar_icons/';
    final theme = Theme.of(context).textTheme;

    return Obx(() {
      final index = homeController.navIndex.value;
      final isPlayerVisible = homeController.isPlayerVisible.value;

      return Scaffold(
        body: Stack(
          children: [
            navTab[index],
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Stack(
                children: [
                  Container(
                    height: 12.h,
                    width: 100.w,
                    padding: const EdgeInsets.all(12),
                    margin: EdgeInsets.only(top: 0.7.h),
                    decoration: BoxDecoration(
                      gradient: AppColorsGredients.panicCardGradient,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(18),
                        topRight: Radius.circular(18),
                      ),
                      border: Border(
                        top: BorderSide(
                          color: AppColors.black.withOpacity(0.1),
                          width: 3,
                        ),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.black
                              .withOpacity(isPlayerVisible ? 0.2 : 0.5),
                          blurRadius: isPlayerVisible ? 6 : 16,
                        )
                      ],
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          height: 56,
                          width: 56,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(14),
                            child: Image.asset(
                              'assets/png/nature.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: 2.w),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                RiseText(
                                  'Out of my mine',
                                  style: theme.bodySmall!.copyWith(
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 2.w),
                                Image.asset(
                                  'assets/icons/music.png',
                                  scale: 4,
                                )
                              ],
                            ),
                            RiseText(
                              'Some Feeling',
                              style: theme.labelSmall!.copyWith(
                                color: AppColors.primaryColor,
                                fontSize: 9.sp,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        const Icon(
                          Icons.pause_rounded,
                          color: AppColors.primaryColor,
                        ),
                        IconButton(
                          onPressed: () =>
                              homeController.isPlayerVisible.value = false,
                          icon: const Icon(
                            Icons.clear_rounded,
                            size: 20,
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 0.7.h,
                      left: 5.w,
                      right: 5.w,
                    ),
                    child: LinearProgressIndicator(
                      value: progress.value,
                      color: AppColors.primaryColor,
                      minHeight: 3,
                      backgroundColor: AppColors.lightSkyBlue.withOpacity(0),
                    ),
                  ),
                  Container(
                    width: 5.w,
                    height: 24,
                    margin: EdgeInsets.only(top: 0.7.h),
                    decoration: const BoxDecoration(
                      border: Border(
                          top: BorderSide(
                        color: AppColors.primaryColor,
                        width: 3,
                      )),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(18),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: progress.value == 1.0,
                    child: Align(
                      alignment: const Alignment(1, .9),
                      child: Container(
                        width: 5.w,
                        height: 24,
                        margin: EdgeInsets.only(top: 0.7.h),
                        decoration: const BoxDecoration(
                          border: Border(
                            top: BorderSide(
                              color: AppColors.primaryColor,
                              width: 3,
                            ),
                          ),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(18),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 14,
                    height: 14,
                    margin: EdgeInsets.only(left: 21.w),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.primaryColor.withOpacity(0.2),
                        width: 2,
                      ),
                    ),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: AppColors.primaryColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ).animate(target: isPlayerVisible ? 1 : 0).moveY(
                    begin: isPlayerVisible ? 100 : 105,
                    end: 0,
                    duration: 700.ms,
                    curve: isPlayerVisible ? Curves.easeInOut : Curves.easeIn,
                  ),
            ),
          ],
        ),
        floatingActionButton: Padding(
          padding: EdgeInsets.only(bottom: 0.h),
          child: GestureDetector(
            onTap: () {
              homeController.isPlayerVisible.value =
                  !homeController.isPlayerVisible.value;
            },
            child: Container(
              width: 64,
              height: 64,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: AppColorsGredients.primaryBottomToTop,
              ),
              child: Image.asset(
                'assets/nav_bar_icons/user_stress.png',
                height: 24,
                width: 24,
                scale: 3.5,
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: Container(
          height: 10.1.h,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18),
              topRight: Radius.circular(18),
            ),
          ),
          child: Column(
            children: [
              Container(
                height: 10.1.h,
                padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 5.w),
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        homeController.navIndex.value = 0;
                      },
                      child: BottomNavBarCard(
                        homeIndex: index,
                        index: 0,
                        navIconPath: navIconPath,
                        theme: theme,
                        label: 'Home',
                        iconName: 'home',
                      ),
                    ),
                    SizedBox(width: 0.w),
                    GestureDetector(
                        onTap: () {
                          homeController.navIndex.value = 1;
                        },
                        child: BottomNavBarCard(
                          homeIndex: index,
                          index: 1,
                          navIconPath: navIconPath,
                          theme: theme,
                          label: 'Challenges',
                          iconName: 'trophy',
                        )),
                    SizedBox(width: 10.w),
                    GestureDetector(
                      onTap: () {
                        homeController.navIndex.value = 2;
                      },
                      child: BottomNavBarCard(
                        homeIndex: index,
                        index: 2,
                        navIconPath: navIconPath,
                        theme: theme,
                        label: 'Journal',
                        iconName: 'journal',
                      ),
                    ),
                    // SizedBox(width: 10.w),

                    GestureDetector(
                      onTap: () {
                        homeController.navIndex.value = 3;
                      },
                      child: BottomNavBarCard(
                        homeIndex: index,
                        index: 3,
                        navIconPath: navIconPath,
                        theme: theme,
                        label: 'Reflection',
                        iconName: 'oui_stats',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class BottomNavBarCard extends StatelessWidget {
  const BottomNavBarCard({
    super.key,
    required this.index,
    required this.navIconPath,
    required this.theme,
    required this.label,
    required this.iconName,
    required this.homeIndex,
  });

  final int index;
  final int homeIndex;
  final String navIconPath;
  final TextTheme theme;
  final String label;
  final String iconName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          iconName == 'trophy' ? EdgeInsets.only(right: 5.w) : EdgeInsets.zero,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ShaderMask(
            shaderCallback: (Rect bounds) {
              return index == homeIndex
                  ? AppColorsGredients.primaryTopToBottom.createShader(bounds)
                  : AppColorsGredients.greyGradient.createShader(bounds);
            },
            child: Image.asset(
              '$navIconPath$iconName.png',
              scale: 4,
            ),
          ),
          SizedBox(height: 1.w),
          RiseText(
            label,
            style: index == homeIndex
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
    );
  }
}
