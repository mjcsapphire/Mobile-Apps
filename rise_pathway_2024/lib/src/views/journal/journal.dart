import 'package:flutter/material.dart';
import 'package:rise_pathway/core/constants/package_export.dart';
import 'package:rise_pathway/core/utils/colors.dart';
import 'package:rise_pathway/src/controllers/auth_controller.dart';
import 'package:rise_pathway/src/controllers/home_controller.dart';
import 'package:rise_pathway/src/controllers/journal_controller.dart';
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
  final journalController = Get.find<JournalController>();
  final authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      journalController.fetchJournals(
        email: authController.userData.value.userEmail ?? '',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

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
            height: 60.h,
            margin: EdgeInsets.only(
              left: 1.5.h,
              right: 1.5.h,
              bottom: 5.h,
            ),
            child: journalController.journals.isEmpty
                ? const Center(
                    child: CircularProgressIndicator.adaptive(
                      valueColor:
                          AlwaysStoppedAnimation(AppColors.primaryColor),
                      strokeCap: StrokeCap.round,
                    ),
                  )
                : StaggeredGrid.count(
                    crossAxisCount: 2,
                    children: List.generate(
                      journalController.journals.length,
                      (index) => GestureDetector(
                        onTap: () => context.go(addNewJournal, extra: {
                          'title': journalController.journals[index].title,
                          'description':
                              journalController.journals[index].entry,
                          'isEdit': true,
                        }),
                        child: JournalCard(
                          title: journalController.journals[index].title,
                          subtitle: journalController.journals[index].entry,
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
            'isEdit': false,
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
