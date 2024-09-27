import 'package:flutter/material.dart';
import 'package:rise_pathway/core/constants/package_export.dart';
import 'package:rise_pathway/core/utils/colors.dart';
import 'package:rise_pathway/src/controllers/home_controller.dart';
import 'package:rise_pathway/src/views/widget/app_bar.dart';
import 'package:rise_pathway/src/views/widget/journal_card.dart';

import '../../../core/helpers/helpers.dart';
import '../../../core/routes/routes.dart';

class Journal extends StatefulWidget {
  const Journal({super.key});

  @override
  State<Journal> createState() => _JournalState();
}

class _JournalState extends State<Journal> {
  final homeController = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    List<String> moods = [
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do... ',
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore maconsequat.   deserunt mollit anim id est...',
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut deserunt mollit anim id est laborum...',
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod temporest...',
      'smod tempor incididunt ut deserunt mollit anim id est laborum...',
      'Lorem ipsum eiusmod tempor incididunt ut labore et dolore maconsequat.   deserunt mollit anim id est...',
      'Ldunt ut deserunt mollit anim id est consectetur adipiscing elit, sed do eiusmod tempor incidconsectetur adipiscing elit, sed do eiusmod tempor incidconsectetur adipiscing elit, sed do eiusmod tempor incid laborum...',
    ];
    List<String> moodsTitle = [
      'First Journal',
      'Second Journal',
      'Third Journal',
      'Fourth Journal',
      'Fifth Journal',
      'Sixth Journal',
      'Seventh Journal',
    ];
    return Scaffold(
      appBar: RiseAppBar.riseAppBar(
        theme: theme,
        title: 'Mood Journal',
        onTap: () {
          homeController.navIndex.value = 0;
        },
      ),
      body: Obx(
        () => SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: homeController.isPlayerVisible.value ? 10.h : 2.h,
          ),
          child: Container(
            margin: EdgeInsets.only(
              left: 1.5.h,
              right: 1.5.h,
              bottom: 5.h,
            ),
            child: StaggeredGrid.count(
              crossAxisCount: 2,
              children: List.generate(
                moods.length,
                (index) => GestureDetector(
                  onTap: () => context.go(addNewJournal, extra: {
                    'title': moodsTitle[index],
                    'description': moods[index],
                  }),
                  child: JournalCard(
                    title: moodsTitle[index],
                    subtitle: moods[index],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: Obx(() {
        final isPlayerVisible = homeController.isPlayerVisible.value;
        return GestureDetector(
          onTap: () => context.go(addNewJournal, extra: {
            'title': 'Add New Jorunal',
            'description': '',
          }),
          child: Container(
            width: 30.w,
            height: 5.h,
            margin: EdgeInsets.only(bottom: 13.h),
            padding: EdgeInsets.symmetric(horizontal: 2.w),
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: AppColors.primaryColor),
              borderRadius: BorderRadius.circular(30),
              color: AppColors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RiseText(
                  'Add New',
                  style: theme.bodySmall!.copyWith(
                    color: AppColors.primaryColor,
                  ),
                ),
                const Icon(
                  Icons.add,
                  color: AppColors.primaryColor,
                ),
              ],
            ),
          ).animate(target: isPlayerVisible ? 1 : 0).moveY(
                begin: isPlayerVisible ? 100 : 105,
                end: 0,
                duration: 700.ms,
                curve: isPlayerVisible ? Curves.easeInOut : Curves.easeIn,
              ),
        );
      }),
    );
  }
}
