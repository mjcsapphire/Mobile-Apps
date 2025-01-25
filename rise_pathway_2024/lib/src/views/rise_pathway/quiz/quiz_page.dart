import 'package:flutter/material.dart';
import 'package:rise_pathway/core/constants/package_export.dart';
import 'package:rise_pathway/core/helpers/helpers.dart';
import 'package:rise_pathway/core/routes/routes.dart';
import 'package:rise_pathway/core/utils/colors.dart';
import 'package:rise_pathway/src/controllers/auth_controller.dart';
import 'package:rise_pathway/src/controllers/rise_pathway_controller.dart';
import 'package:rise_pathway/src/models/pathways/quiz_response.dart';
import 'package:rise_pathway/src/models/pathways/quiz_test_response.dart';
import 'package:rise_pathway/src/views/widget/app_bar.dart';
import 'package:rise_pathway/src/views/widget/rise_button.dart';

class QuizPage extends StatefulWidget {
  final String title;
  final String? route;
  final String id;
  const QuizPage(
      {super.key, required this.title, this.route, required this.id});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final _pageController = PageController();
  final pathwayController = Get.find<RisePathwayController>();
  final authController = Get.find<AuthController>();
  final currentQuiz = 1.obs;
  final answers = <String>[].obs;
  final QuizTestResponse quizTestResponse = QuizTestResponse();

  @override
  void initState() {
    super.initState();
    pathwayController.fetchPathwayQuestions(pathway: widget.id).then((_) {
      answers
          .addAll(List.generate(pathwayController.quizs.length, (index) => ''));
    });
  }

  void _handleNextOrSubmit(String answer) async {
    answers[currentQuiz.value - 1] = answer;

    if (currentQuiz.value < pathwayController.quizs.length) {
      _pageController.nextPage(
        curve: Curves.easeInOut,
        duration: 300.ms,
      );
      currentQuiz.value += 1;
    } else {
      final path =
          GoRouter.of(context).routerDelegate.currentConfiguration.fullPath;
      final email = authController.userData.value.userEmail;
      final pathwayId = widget.id;

      final Map<String, String> questions = {
        for (int i = 0; i < answers.length; i++) 'question${i + 1}': answers[i],
      };

      await pathwayController.submitPathway(
        email: email!,
        pathway: pathwayId,
        questions: questions,
      );
      // checking the widget is still active before proceeding with navigation
      if (!mounted) return;

      String quizPath =
          path.contains('rise_quiz_page') ? riseQuizSummary : quizSummary;

      context.go(quizPath);
    }
  }

  void _goToPreviousQuestion() {
    if (currentQuiz.value > 1) {
      _pageController.previousPage(
        curve: Curves.easeInOut,
        duration: 300.ms,
      );
      currentQuiz.value -= 1;
    }
  }

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
            child: Obx(() {
              if (pathwayController.quizs.isEmpty) {
                return Center(
                    child: RiseText(
                  'No quizes Available',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: AppColors.primaryColor),
                ));
              }
              return Column(
                children: [
                  Obx(() => LinearProgressIndicator(
                        value:
                            currentQuiz.value / pathwayController.quizs.length,
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
                              onTap: _goToPreviousQuestion,
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.arrow_left_rounded,
                                    color: AppColors.primaryColor,
                                  ),
                                  RiseText(
                                    'Prev',
                                    style: theme.labelSmall!.copyWith(
                                      color: AppColors.primaryColor,
                                      fontSize: 10.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Obx(() => RiseText(
                                  'Question ${currentQuiz.value} of ${pathwayController.quizs.length}',
                                  style: theme.titleSmall!.copyWith(
                                    color: AppColors.darkSkyBlue,
                                  ),
                                )),
                            GestureDetector(
                              onTap: () {
                                if (currentQuiz.value <
                                    pathwayController.quizs.length) {
                                  _pageController.nextPage(
                                    curve: Curves.easeInOut,
                                    duration: 300.ms,
                                  );
                                  currentQuiz.value += 1;
                                }
                              },
                              child: Row(
                                children: [
                                  RiseText(
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
                            itemCount: pathwayController.quizs.length,
                            controller: _pageController,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return _buildQuizField(
                                  pathwayController.quizs[index], theme);
                            },
                          ),
                        ),
                        SizedBox(height: 2.h),
                        RiseButton(
                          title: 'Yes',
                          onTap: () {
                            _handleNextOrSubmit('1');
                          },
                          gradient: AppColorsGredients.quizYesButton,
                        ),
                        SizedBox(height: 2.h),
                        RiseButton(
                          title: 'No',
                          onTap: () => _handleNextOrSubmit('0'),
                          gradient: AppColorsGredients.quizNoButton,
                        )
                      ],
                    ),
                  ),
                ],
              );
            }),
          )
        ],
      ),
    );
  }

  _buildQuizField(QuizResponse quiz, TextTheme theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RiseText(
          quiz.question,
          style: theme.titleMedium!.copyWith(
            color: AppColors.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
