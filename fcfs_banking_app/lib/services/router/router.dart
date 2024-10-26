import 'package:fcfs_banking_app/core/utils/app_helpers.dart';
import 'package:fcfs_banking_app/services/router/routes_name.dart';
import 'package:fcfs_banking_app/services/router/routes_path.dart';
import 'package:fcfs_banking_app/src/views/auth/login/login_otp_verification.dart';
import 'package:fcfs_banking_app/src/views/auth/login/login_security.dart';
import 'package:fcfs_banking_app/src/views/auth/login/passcode_screen.dart';
import 'package:fcfs_banking_app/src/views/auth/register/register_complete.dart';
import 'package:fcfs_banking_app/src/views/bottom_nav_page.dart';
import 'package:fcfs_banking_app/src/views/faqs_screen.dart';
import 'package:fcfs_banking_app/src/views/home/home_screen.dart';
import 'package:fcfs_banking_app/src/views/more/more_screen.dart';
import 'package:fcfs_banking_app/src/views/notification_screen.dart';
import 'package:fcfs_banking_app/src/views/profile/profile_screen.dart';
import 'package:fcfs_banking_app/src/views/referal/referal_screen.dart';
import 'package:fcfs_banking_app/src/views/splash/splash.dart';
import 'package:fcfs_banking_app/src/views/transaction/transaction_screen.dart';
import 'package:fcfs_banking_app/src/views/transfer/transfer_screen.dart';
import 'package:go_router/go_router.dart';

import '../../src/views/auth/login_screen.dart';
import '../../src/views/auth/register_screen.dart';
import '../../src/views/splash/onboarding_screen.dart';

final router = GoRouter(
    redirect: (context, state) async {
      bool isRegistered =
          await AppHelpers.getUser(key: 'isRegistered') ?? false;
      bool hasPasscode = await AppHelpers.getUser(key: 'hasPasscode ') ?? false;

      bool hasSecurityQuestion =
          await AppHelpers.getUser(key: 'hasSecurityQuestion ') ?? false;
      if (isRegistered == true &&
          (hasSecurityQuestion == true &&
              state.uri.toString() == RoutesPath.splash)) {
        return RoutesPath.otpVerification;
      }
      if (hasSecurityQuestion == true &&
          (hasPasscode == true && state.uri.toString() == RoutesPath.splash)) {
        return RoutesPath.passcodeVerification;
      }
      return null;
    },

    // redirect: (context, state) async {
    //   bool? isRegistered = await AppHelpers.getUser(key: 'isRegistered');
    //   bool? hasPasscode = await AppHelpers.getUser(key: 'hasPasscode');
    //   // If user is registered and has a passcode, redirect to passcode verification
    //   if (isRegistered == true && hasPasscode == true) {
    //     return RoutesPath.passcodeVerification;
    //   }
    //   // If user is registered but has not yet set a passcode, allow navigation
    //   if (isRegistered == true && hasPasscode == false) {
    //     return RoutesPath.otpVerification; // No redirection, allow access to passcode setup or other screens
    //   }
    //   // If user is not registered, continue to registration flow
    //   return RoutesPath.registerRoute; // Replace this with your actual registration route
    // },

    initialLocation: RoutesPath.splash,
    routes: [
      GoRoute(
        path: RoutesPath.splash,
        name: RoutesName.splash,
        builder: (context, state) => const Splash(),
      ),
      GoRoute(
        path: RoutesPath.onboarding,
        name: RoutesName.onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: RoutesPath.loginRoute,
        name: RoutesName.loginPage,
        builder: (context, state) => const Login(),
      ),
      GoRoute(
        path: RoutesPath.registerRoute,
        name: RoutesName.registerPage,
        builder: (context, state) => const Register(),
      ),
      GoRoute(
        path: RoutesPath.registerComplete,
        name: RoutesName.registerComplete,
        builder: (context, state) => const RegisterCompleteScreen(),
      ),
      GoRoute(
        path: RoutesPath.loginSecurity,
        name: RoutesName.loginSecurity,
        builder: (context, state) => const LoginSecurityScreen(),
      ),
      GoRoute(
        path: RoutesPath.otpVerification,
        name: RoutesName.otpVerification,
        builder: (context, state) => const LoginOtpVerification(),
      ),
      GoRoute(
        path: RoutesPath.passcodeVerification,
        name: RoutesName.passcodeVerification,
        builder: (context, state) => const LoginPassCodeScreen(),
      ),
      GoRoute(
        path: RoutesPath.home,
        name: RoutesName.home,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: RoutesPath.transactionScreen,
        name: RoutesName.transactionScreen,
        builder: (context, state) => const TransactionScreen(),
      ),
      GoRoute(
        path: RoutesPath.transferScreen,
        name: RoutesName.transferScreen,
        builder: (context, state) => const TransferScreen(),
      ),
      GoRoute(
        path: RoutesPath.moreScreen,
        name: RoutesName.moreScreen,
        builder: (context, state) => const MoreScreen(),
      ),
      GoRoute(
        path: RoutesPath.profileScreen,
        name: RoutesName.profileScreen,
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: RoutesPath.referralScreen,
        name: RoutesName.referralScreen,
        builder: (context, state) => const ReferralScreen(),
      ),
      GoRoute(
        path: RoutesPath.notificationScreen,
        name: RoutesName.notificationScreen,
        builder: (context, state) => const NotificationScreen(),
      ),
      GoRoute(
        path: RoutesPath.faqsScreen,
        name: RoutesName.faqsScreen,
        builder: (context, state) => const FAQScreen(),
      ),
      GoRoute(
          path: '/mainPage/:initialIndex',
          name: RoutesName.mainPage,
          builder: (context, state) {
            final initialIndex =
                int.parse(state.pathParameters['initialIndex']!);
            return MainPage(initialIndex: initialIndex);
          }),
    ]);
