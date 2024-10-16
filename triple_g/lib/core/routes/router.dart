import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:triple_g/core/routes/routes.dart';
import 'package:triple_g/src/app.dart';
import 'package:triple_g/src/views/more_page/donation.dart';
import 'package:triple_g/src/views/more_page/notebook.dart';
import 'package:triple_g/src/views/sermons/sermons_detail_screen.dart';
import 'package:triple_g/src/views/splash/splash_one.dart';
import 'package:triple_g/src/views/splash/splash_three.dart';

import '../../src/views/chat/message_screen.dart';
import '../../src/views/home/news_and_event_page.dart';
import '../../src/views/more_page/donation_page.dart';
import '../../src/views/splash/splash_two.dart';

class GRouter {
  static GoRouter goRouter = GoRouter(
    navigatorKey: Get.key,
    initialLocation: initialRoute,
    routes: <RouteBase>[
      GoRoute(
          path: initialRoute,
          builder: (context, state) => const SplashOne(),
          routes: [
            GoRoute(
                path: "splash_two",
                builder: (context, state) => const SplashTwo(),
                routes: [
                  GoRoute(
                    path: "splash_three",
                    builder: (context, state) => const SplashThree(),
                  ),
                ])
          ]),
      GoRoute(
        path: app,
        builder: (context, state) => const TripleG(),
        routes: [
          GoRoute(
            path: 'chat_screen',
            builder: (context, state) => const MessageScreen(),
          ),
          GoRoute(
            path: 'notebook',
            builder: (context, state) => const NoteBook(),
          ),
          GoRoute(
            path: 'news_and_events',
            builder: (context, state) => const NewsAndEventScreen(),
          ),
          GoRoute(
            path: 'donate',
            builder: (context, state) => const Donation(),
            routes: [
              GoRoute(
                path: 'donation_page',
                builder: (context, state) => const DonationPage(),
              ),
            ],
          ),
          GoRoute(
            path: 'sermons_detail',
            builder: (context, state) {
              final isLive = (state.extra as Map)['isLive'] as bool;
              return  SermonsDetailScreen(
                isLive: isLive,
              );
            },
          ),
        ],
      ),
    ],
  );
}
