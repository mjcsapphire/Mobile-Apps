import 'package:flutter/material.dart';
import 'package:rise_pathway/core/constants/package_export.dart';
import 'package:rise_pathway/core/helpers/helpers.dart';
import 'package:rise_pathway/core/routes/routes.dart';
import 'package:rise_pathway/core/utils/colors.dart';
import 'package:rise_pathway/src/controllers/goal_controller.dart';
import 'package:rise_pathway/src/controllers/home_controller.dart';
import 'package:rise_pathway/src/views/widget/app_bar.dart';
import 'package:rise_pathway/src/views/widget/goal_cards.dart';

class Goals extends StatefulWidget {
  const Goals({super.key});

  @override
  State<Goals> createState() => _GoalsState();
}

class _GoalsState extends State<Goals> {
  final homeController = Get.find<HomeController>();
  final goalsController = Get.find<GoalController>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: RiseAppBar.riseAppBar(
        theme: theme,
        title: 'Goals',
        onTap: () {
          homeController.navIndex.value = 0;
        },
      ),
      body: Obx(
        () => goalsController.goals.isEmpty
            ? Center(
                child: RiseText(
                  'No Goals Available',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: AppColors.primaryColor),
                ),
              )
            : ListView.builder(
                itemCount: goalsController.goals.length,
                padding: EdgeInsets.only(
                  bottom: homeController.isPlayerVisible.value ? 14.h : 5.h,
                  left: 4.w,
                  right: 4.w,
                ),
                itemBuilder: (context, index) {
                  if (goalsController.goals.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return GoalsCard(
                    height: 28.h,
                    goal: goalsController.goals[index],
                    onTap: () {
                      context.go(
                        goalPage,
                        extra: goalsController.goals[index],
                      );
                    },
                  );
                },
              ),
      ),
    );
  }
}
