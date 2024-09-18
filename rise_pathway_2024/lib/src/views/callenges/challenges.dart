import 'package:flutter/material.dart';
import 'package:rise_pathway/config/constants/package_export.dart';
import 'package:rise_pathway/config/routes/routes.dart';
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
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    List<Map<String, dynamic>> challengeList = [
      {
        'title': 'Talk to people',
        'description': 'The beautiful talk of life is always...'
      },
      {
        'title': 'Tidy my bed',
        'description': 'The beautiful talk of life is always...'
      },
      {
        'title': 'Talk to people',
        'description': 'The beautiful talk of life is always...'
      },
      {
        'title': 'Tidy my bed',
        'description': 'The beautiful talk of life is always...'
      }
    ];
    return Scaffold(
      appBar: RiseAppBar.riseAppBar(
        theme: theme,
        title: 'Challenges',
        onTap: () {
          homeController.navIndex.value = 0;
        },
      ),
      body: Obx(() => ListView.builder(
            itemCount: 4,
            padding: EdgeInsets.only(
                bottom: homeController.isPlayerVisible.value ? 22.h : 14.h,
                left: 4.w,
                right: 4.w),
            itemBuilder: (context, index) => ChallengesCard(
              height: 28.h,
              title: challengeList[index]['title'],
              description: challengeList[index]['description'],
              onTap: () => context.go(challengePage),
              isCompleted: index % 3 == 0,
            ),
          )),
    );
  }
}
