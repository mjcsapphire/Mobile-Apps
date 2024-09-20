import 'package:rise_pathway/config/routes/routes.dart';
import 'package:rise_pathway/src/app.dart';
import 'package:rise_pathway/src/views/auth/create_new_password.dart';
import 'package:rise_pathway/src/views/auth/forget_password.dart';
import 'package:rise_pathway/src/views/auth/login_page.dart';
import 'package:rise_pathway/src/views/auth/otp_verify.dart';
import 'package:rise_pathway/src/views/auth/sign_up_page.dart';
import 'package:rise_pathway/src/views/callenges/challenge_page.dart';
import 'package:rise_pathway/src/views/chat/chat_page.dart';
import 'package:rise_pathway/src/views/home/home.dart';
import 'package:rise_pathway/src/views/home/profile/change_password.dart';
import 'package:rise_pathway/src/views/home/profile_page.dart';
import 'package:rise_pathway/src/views/home/schedule_page.dart';
import 'package:rise_pathway/src/views/journal/add_new_journal.dart';
import 'package:rise_pathway/src/views/mood/select_mood.dart';
import 'package:rise_pathway/src/views/rise_pathway/quiz/quiz_page.dart';
import 'package:rise_pathway/src/views/rise_pathway/quiz/quiz_summary.dart';
import 'package:rise_pathway/src/views/rise_pathway/rise_pathway.dart';
import 'package:rise_pathway/src/views/splash/splash_page.dart';

import '../constants/package_export.dart';

class CustomRouter {
  static GoRouter goRouter = GoRouter(
    navigatorKey: Get.key,
    initialLocation: initialRoute,
    routes: <RouteBase>[
      GoRoute(
        path: initialRoute,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
          path: login,
          builder: (context, state) => const LoginPage(),
          routes: [
            GoRoute(
              path: 'select_mood',
              builder: (context, state) => const SelectMood(),
            ),
            GoRoute(
              path: 'forgot_password',
              builder: (context, state) => const ForgetPassword(),
              routes: [
                GoRoute(
                  path: 'otp_verify',
                  builder: (context, state) => const OtpVerify(),
                  routes: [
                    GoRoute(
                      path: 'create_new_password',
                      builder: (context, state) => const CreateNewPassword(),
                    ),
                  ],
                ),
              ],
            )
          ]),
      GoRoute(
          path: signUp,
          builder: (context, state) => const SignUpPage(),
          routes: [
            GoRoute(
              path: 'select_mood',
              builder: (context, state) => const SelectMood(),
            ),
          ]),
      GoRoute(
        path: app,
        builder: (context, state) => const App(),
        routes: [
          GoRoute(
            path: 'chat_page',
            builder: (context, state) => const ChatPage(),
          ),
          GoRoute(
            path: 'home_page',
            builder: (context, state) => const HomePage(),
          ),
          GoRoute(
            path: 'rise_pathway',
            builder: (context, state) => const RisePathWay(),
          ),
          GoRoute(
            path: 'add_new_journal',
            builder: (context, state) {
              final data = state.extra as Map<String, dynamic>;
              final title = data['title'];
              final description = data['description'];
              return AddNewJournal(
                title: title,
                description: description,
              );
            },
          ),
          GoRoute(
              path: 'quiz_page',
              builder: (context, state) {
                final title = ((state.extra ?? {'title': 'None'})
                    as Map<String, dynamic>)['title'];
                return QuizPage(title: title);
              },
              routes: [
                GoRoute(
                  path: 'summary',
                  builder: (context, state) {
                    return const QuizSummary();
                  },
                ),
              ]),
          GoRoute(
            path: 'schedule_page',
            builder: (context, state) {
              return const SchedulePage();
            },
          ),
          GoRoute(
            path: 'profile_page',
            builder: (context, state) {
              return const ProfilePage();
            },
            routes: [
              GoRoute(
                path: 'change_password',
                builder: (context, state) {
                  return const ChangePassword();
                },
              ),
            ],
          ),
          GoRoute(
            path: 'challenge_page',
            builder: (context, state) => const ChallengePage(),
          ),
        ],
      ),
    ],
  );
}
