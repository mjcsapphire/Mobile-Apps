import 'package:flutter/material.dart';
import 'package:rise_pathway/core/constants/package_export.dart';
import 'package:rise_pathway/core/routes/routes.dart';
import 'package:rise_pathway/src/controllers/challenge_controller.dart';
import 'package:rise_pathway/src/controllers/home_controller.dart';
import 'package:rise_pathway/src/views/widget/app_bar.dart';
import 'package:rise_pathway/src/views/widget/challenges_card.dart';

class Challenges extends StatefulWidget {
  const Challenges({super.key});

  @override
  State<Challenges> createState() => _ChallengesState();
}

class _ChallengesState extends State<Challenges> {
  final homeController = Get.find<HomeController>();
  final challengeController = Get.find<ChallengeController>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: RiseAppBar.riseAppBar(
        theme: theme,
        title: 'Challenges',
        onTap: () {
          homeController.navIndex.value = 0;
        },
      ),
      body: Obx(() => ListView.builder(
            itemCount: challengeController.challenges.length,
            padding: EdgeInsets.only(
                bottom: homeController.isPlayerVisible.value ? 14.h : 5.h,
                left: 4.w,
                right: 4.w),
            itemBuilder: (context, index) {
              if (challengeController.challenges.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }
              return ChallengesCard(
                height: 28.h,
                challenge: challengeController.challenges[index],
                onTap: () {
                  context.go(
                    challengePage,
                    extra: challengeController.challenges[index],
                  );
                },
              );
            },
          )),
    );
  }
}
