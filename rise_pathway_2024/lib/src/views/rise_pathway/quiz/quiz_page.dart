import 'package:flutter/material.dart';
import 'package:rise_pathway/config/constants/package_export.dart';
import 'package:rise_pathway/config/utils/colors.dart';
import 'package:rise_pathway/src/views/widget/app_bar.dart';
import 'package:rise_pathway/src/views/widget/rise_button.dart';

class QuizPage extends StatefulWidget {
  final String title;
  const QuizPage({super.key, required this.title});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final _pageController = PageController();
  final currentQuiz = 1.obs;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: RiseAppBar.riseAppBar(
        theme: theme,
        title: widget.title,
        onTap: () => context.pop(),
        backgroundColor: AppColors.primaryColor,
        iconColor: AppColors.white,
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                gradient: AppColorsGredients.primaryTopToBottom),
          ),
          SizedBox(
            height: 100.h,
            child: Image.asset(
              'assets/png/quiz_background.png',
              fit: BoxFit.cover,
              opacity: const AlwaysStoppedAnimation(0.3),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Obx(() => LinearProgressIndicator(
                      value: currentQuiz.value / 10,
                      color: AppColors.quizProgressColor,
                      borderRadius: BorderRadius.circular(20),
                    )),
                Container(
                  width: 100.w,
                  margin: EdgeInsets.symmetric(vertical: 2.h),
                  padding: EdgeInsets.all(3.h),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              _pageController.previousPage(
                                curve: Curves.easeInOut,
                                duration: 300.ms,
                              );
                              print(currentQuiz.value);
                              if (currentQuiz.value > 1) {
                                currentQuiz.value -= 1;
                              }
                            },
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.arrow_left_rounded,
                                  color: AppColors.primaryColor,
                                ),
                                Text(
                                  'Prev',
                                  style: theme.labelSmall!.copyWith(
                                    color: AppColors.primaryColor,
                                    fontSize: 10.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Obx(() => Text(
                                'Question ${currentQuiz.value} of 10',
                                style: theme.titleSmall!.copyWith(
                                  color: AppColors.darkSkyBlue,
                                ),
                              )),
                          GestureDetector(
                            onTap: () {
                              _pageController.nextPage(
                                curve: Curves.easeInOut,
                                duration: 300.ms,
                              );
                              print(currentQuiz.value);
                              if (currentQuiz.value < 10) {
                                currentQuiz.value += 1;
                              }
                            },
                            child: Row(
                              children: [
                                Text(
                                  'Next',
                                  style: theme.labelSmall!.copyWith(
                                    color: AppColors.primaryColor,
                                    fontSize: 10.sp,
                                  ),
                                ),
                                const Icon(
                                  Icons.arrow_right_rounded,
                                  color: AppColors.primaryColor,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 2.h),
                      SizedBox(
                        height: 45.h,
                        child: PageView.builder(
                          itemCount: 10,
                          controller: _pageController,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return _buildQuizField(index, theme);
                          },
                        ),
                      ),
                      SizedBox(height: 2.h),
                      RiseButton(
                        title: 'Yes',
                        onTap: () {},
                        gradient: AppColorsGredients.quizYesButton,
                      ),
                      SizedBox(height: 2.h),
                      RiseButton(
                        title: 'No',
                        onTap: () {},
                        gradient: AppColorsGredients.quizNoButton,
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Text _buildQuizField(int index, TextTheme theme) {
    return Text(
      'I think before I speak ${index + 1}',
      style: theme.titleMedium!.copyWith(
        color: AppColors.primaryColor,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
