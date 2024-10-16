import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import 'package:triple_g/core/routes/routes.dart';
import 'package:triple_g/src/views/widgets/white_box.dart';

import '../../../core/utils/colors.dart';
import '../../controllers/home_controller.dart';
import '../widgets/news_events_card.dart';
import '../widgets/you_may_know.dart';

class MorePage extends StatefulWidget {
  const MorePage({super.key});

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  HomeController homeController = Get.find();
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final options = [
      "My Account",
      "Notes",
      "Settings & Privacy",
      "Journal",
      "Help & Support",
    ];

    final icons = ["person", "notes", "setting", "journal", "help"];
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              SizedBox(height: 5.h),
              const NewsEventsCard(
                margin: EdgeInsets.all(0),
                isAdd: false,
              ),
              SizedBox(height: 2.h),
              const YouMayKnow(
                isAdd: false,
              ),
              SizedBox(height: 2.h),
              WhiteBox(
                onTap: () => context.go(donate),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            "assets/png/donate.png",
                            scale: 3.5,
                          ),
                          const Text(
                            'Donate',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.rotationY(3.14),
                            child: Image.asset(
                              "assets/png/donate.png",
                              scale: 3.5,
                            ),
                          ),
                        ]),
                  ],
                ),
              ),
              SizedBox(height: 2.h),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                runSpacing: 12,
                spacing: 12,
                alignment: WrapAlignment.center,
                children: [
                  ...List.generate(
                    5,
                    (index) => GestureDetector(
                      onTap: () => context.go(noteBook),
                      child: WhiteBox(
                        width: 40.w,
                        height: 12.h,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              "assets/png/${icons[index]}.png",
                              scale: 3.5,
                            ),
                            SizedBox(height: 1.h),
                            Text(
                              options[index],
                              style: textTheme.bodySmall!.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
