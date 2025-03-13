import 'package:flutter/material.dart';
import 'package:rise_pathway/core/constants/package_export.dart';
import 'package:rise_pathway/core/helpers/helpers.dart';
import 'package:rise_pathway/core/utils/colors.dart';
import 'package:rise_pathway/src/controllers/auth_controller.dart';
import 'package:rise_pathway/src/controllers/goal_controller.dart';
import 'package:rise_pathway/src/models/goals/goal_response.dart';
import 'package:rise_pathway/src/views/widget/app_bar.dart';
import 'package:rise_pathway/src/views/widget/gradient_border_card.dart';
import 'package:rise_pathway/src/views/widget/rise_button.dart';
import 'package:url_launcher/url_launcher.dart';

class GoalPage extends StatefulWidget {
  final GoalResponse goal;
  const GoalPage({super.key, required this.goal});

  @override
  State<GoalPage> createState() => _GoalPageState();
}

class _GoalPageState extends State<GoalPage> {
  final goalsController = Get.find<GoalController>();
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: RiseAppBar.riseAppBar(
        title: widget.goal.title,
        onTap: () => context.pop(),
        theme: theme,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  GradientBorderCard(
                    height: 22.h,
                    margin: EdgeInsets.zero,
                    borderRadius: BorderRadius.circular(20),
                    children: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Container(
                          margin: const EdgeInsets.all(1),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(
                                  widget.goal.image,
                                  width: 100.w,
                                  height: 100.h,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  height: 20.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.transparent,
                                        Colors.black.withOpacity(0.8),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            width: 60.w,
                            height: 10.h,
                            padding: EdgeInsets.symmetric(horizontal: 3.h),
                            margin: const EdgeInsets.only(bottom: 1.5),
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                              gradient: AppColorsGredients.primaryRightToLeft,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 2.h,
                                  width: 20.w,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    color: AppColors.white,
                                  ),
                                  child: RiseText(
                                    'Goal',
                                    style: theme.bodySmall!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 8.sp,
                                      color: AppColors.blue600,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 1.h),
                                RiseText(
                                  widget.goal.title,
                                  overflow: TextOverflow.ellipsis,
                                  style: theme.titleMedium!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 30.h), // Optional space above the button
                ],
              ),
            ),
          ),
          // Button at the bottom
          Padding(
            padding: const EdgeInsets.all(24),
            child: RiseButton(
              title: 'Buy Now',
              onTap: () async {
                final url = widget.goal.stripelink;

                // Check if the URL is valid
                if (url.isNotEmpty) {
                  // Attempt to launch the URL
                  if (await canLaunchUrl(Uri.parse(url))) {
                    await launchUrl(Uri.parse(url));
                  } else {
                    // Show an error message if the URL cannot be launched
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Could not launch url')),
                    );
                  }
                } else {
                  // Handle the case where the URL is null or empty
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Invalid URL')),
                  );
                }
              },
              gradient: AppColorsGredients.challengeNotCompletedBtn,
              preffix: true,
              svgPath: 'assets/svg/success_complete.svg',
            ),
          ),
        ],
      ),
    );
  }
}
