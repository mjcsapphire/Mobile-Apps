import 'package:fcfs_banking_app/core/utils/app_helpers.dart';
import 'package:fcfs_banking_app/services/router/routes_name.dart';
import 'package:fcfs_banking_app/services/router/routes_path.dart';
import 'package:fcfs_banking_app/src/models/community_funding_model.dart';
import 'package:fcfs_banking_app/src/models/transactions_model.dart';
import 'package:fcfs_banking_app/src/views/auth/login/login_otp_verification.dart';
import 'package:fcfs_banking_app/src/views/auth/login/login_security.dart';
import 'package:fcfs_banking_app/src/views/auth/login/passcode_screen.dart';
import 'package:fcfs_banking_app/src/views/auth/password/create_new_password_screen.dart';
import 'package:fcfs_banking_app/src/views/auth/password/forgot_password_screen.dart';
import 'package:fcfs_banking_app/src/views/auth/register/register_complete.dart';
import 'package:fcfs_banking_app/src/views/bottom_nav_page.dart';
import 'package:fcfs_banking_app/src/views/business_user/add%20product/add_product_screen.dart';
import 'package:fcfs_banking_app/src/views/business_user/add%20product/choose_payment.dart';
import 'package:fcfs_banking_app/src/views/business_user/add%20product/initial_product.dart';
import 'package:fcfs_banking_app/src/views/business_user/add%20product/payment/initial_terminal_payment.dart';
import 'package:fcfs_banking_app/src/views/business_user/add%20product/payment/payment_status_page.dart';
import 'package:fcfs_banking_app/src/views/business_user/add%20product/product_billing.dart';
import 'package:fcfs_banking_app/src/views/business_user/community%20funding/community_funding.dart';
import 'package:fcfs_banking_app/src/views/business_user/community%20funding/idea_submission_form.dart';
import 'package:fcfs_banking_app/src/views/business_user/community%20funding/pitch_details_view.dart';
import 'package:fcfs_banking_app/src/views/credit_card_screen.dart';
import 'package:fcfs_banking_app/src/views/direct_debit/business_direct_debit_dashboard.dart';
import 'package:fcfs_banking_app/src/views/direct_debit/personal_direct_debit_dashboard.dart';
import 'package:fcfs_banking_app/src/views/direct_debit/process_debit_req_screen.dart';
import 'package:fcfs_banking_app/src/views/direct_debit/user_new_request_screen.dart';
import 'package:fcfs_banking_app/src/views/help_support/faqs_screen.dart';
import 'package:fcfs_banking_app/src/views/help_support/help_support_chat_screen.dart';
import 'package:fcfs_banking_app/src/views/help_support/help_support_screen.dart';
import 'package:fcfs_banking_app/src/views/home/home_screen.dart';
import 'package:fcfs_banking_app/src/views/limit_screen.dart';
import 'package:fcfs_banking_app/src/views/manage_permission_screen.dart';
import 'package:fcfs_banking_app/src/views/memorable_code_screen.dart';
import 'package:fcfs_banking_app/src/views/more/more_screen.dart';
import 'package:fcfs_banking_app/src/views/more/setting_screen.dart';
import 'package:fcfs_banking_app/src/views/notification_screen.dart';
import 'package:fcfs_banking_app/src/views/onboarding/privacy_policy_screen.dart';
import 'package:fcfs_banking_app/src/views/onboarding/terms_condition_screen.dart';
import 'package:fcfs_banking_app/src/views/payment_success_page.dart';
import 'package:fcfs_banking_app/src/views/profile/profile_screen.dart';
import 'package:fcfs_banking_app/src/views/qr_code/qr_payment_screen.dart';
import 'package:fcfs_banking_app/src/views/qr_code/scan_qr_screen.dart';
import 'package:fcfs_banking_app/src/views/referal/referal_screen.dart';
import 'package:fcfs_banking_app/src/views/reward_screeen.dart';
import 'package:fcfs_banking_app/src/views/splash/splash.dart';
import 'package:fcfs_banking_app/src/views/transaction/transaction_details_screen.dart';
import 'package:fcfs_banking_app/src/views/transaction/transaction_screen.dart';
import 'package:fcfs_banking_app/src/views/transfer/receive_initial.dart';
import 'package:fcfs_banking_app/src/views/transfer/request_money_screen.dart';
import 'package:fcfs_banking_app/src/views/transfer/request_received.dart';
import 'package:fcfs_banking_app/src/views/transfer/top_up_account.dart';
import 'package:fcfs_banking_app/src/views/transfer/transfer_screen.dart';
import 'package:go_router/go_router.dart';

import '../../src/views/auth/login_screen.dart';
import '../../src/views/auth/register_screen.dart';
import '../../src/views/splash/onboarding_screen.dart';

final router = GoRouter(
    redirect: (context, state) async {
      // Check if the user is logged in
      final isLoggedIn = await AppHelpers.checkLoggedInStatus();

      // Define the current location for better readability
      final currentLocation = state.uri.toString();

      // If the user is logged in, redirect to the passcode verification screen
      if (isLoggedIn && currentLocation == RoutesPath.memorableCode) {
        return RoutesPath.memorableCode;
      } else if (isLoggedIn && currentLocation == RoutesPath.splash) {
        return RoutesPath.memorableCode;
      }

      return null;
    },
    initialLocation: RoutesPath.splash,
    routes: [
      GoRoute(
        path: RoutesPath.splash,
        name: RoutesName.splash,
        builder: (context, state) => Splash(),
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
        path: RoutesPath.resetPassword,
        name: RoutesName.resetPassword,
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: RoutesPath.createNewPassword,
        name: RoutesName.createNewPassword,
        builder: (context, state) => const CreateNewPassword(),
      ),
      GoRoute(
        path: RoutesPath.home,
        name: RoutesName.home,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: RoutesPath.scanScreen,
        name: RoutesName.scanScreen,
        builder: (context, state) => const ScanScreen(),
      ),
      GoRoute(
        path: RoutesPath.transactionScreen,
        name: RoutesName.transactionScreen,
        builder: (context, state) => const TransactionScreen(),
      ),
      GoRoute(
        path: RoutesPath.transactionDetailsScreen,
        name: RoutesName.transactionDetailsScreen,
        builder: (context, state) {
          final transaction = state.extra as TransactionModel;
          return TransactionDetailsScreen(transaction: transaction);
        },
      ),
      GoRoute(
        path: RoutesPath.transferScreen,
        name: RoutesName.transferScreen,
        builder: (context, state) => const TransferScreen(),
      ),
      GoRoute(
        path: RoutesPath.qrPaymentScreen,
        name: RoutesName.qrPaymentScreen,
        builder: (context, state) {
          final phoneNumber = state.pathParameters['phoneNumber']!;
          final amount = double.parse(state.pathParameters['amount']!);
          return QrPaymentScreen(phoneNumber: phoneNumber, amount: amount);
        },
      ),
      GoRoute(
        path: RoutesPath.paymentSuccess,
        name: RoutesName.paymentSuccess,
        builder: (context, state) => const PaymentConfirmation(),
      ),
      GoRoute(
        path: RoutesPath.moreScreen,
        name: RoutesName.moreScreen,
        builder: (context, state) => const MoreScreen(),
      ),
      GoRoute(
        path: RoutesPath.setting,
        name: RoutesName.setting,
        builder: (context, state) => SettingScreen(),
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
        path: RoutesPath.privacyPolicyScreen,
        name: RoutesName.privacyPolicyScreen,
        builder: (context, state) => const PrivacyPolicyScreen(),
      ),
      GoRoute(
        path: RoutesPath.termsConditionScreen,
        name: RoutesName.termsConditionScreen,
        builder: (context, state) => const TermsCondition(),
      ),
      GoRoute(
        path: RoutesPath.managePermission,
        name: RoutesName.managePermission,
        builder: (context, state) => const ManagePermissionScreen(),
      ),
      GoRoute(
        path: RoutesPath.helpSupportScreen,
        name: RoutesName.helpSupportScreen,
        builder: (context, state) => const HelpSupportScreen(),
      ),
      GoRoute(
        path: RoutesPath.helpSupportChatScreen,
        name: RoutesName.helpSupportChatScreen,
        builder: (context, state) => const SupportChatScreen(),
      ),
      GoRoute(
        path: RoutesPath.newDirectDebitRequestScreen,
        name: RoutesName.newDirectDebitRequestScreen,
        builder: (context, state) => const NewDirectDebitRequestScreen(),
      ),
      GoRoute(
          path: RoutesPath.processDebitRequestScreen,
          name: RoutesName.processDebitRequestScreen,
          builder: (context, state) {
            final contactName = state.pathParameters['contactName']!;
            final selectedBusinessId =
                state.pathParameters['selectedBusinessId']!;
            final amount = double.parse(state.pathParameters['amount']!);
            return ProcessDebitReqScreen(
              contactName: contactName,
              selectedBusinessId: selectedBusinessId,
              amount: amount,
            );
          }),
      GoRoute(
        path: RoutesPath.personalDashboard,
        name: RoutesName.personalDashboard,
        builder: (context, state) => PersonalDirectDebitDashboard(),
      ),
      GoRoute(
        path: RoutesPath.businessDashboard,
        name: RoutesName.businessDashboard,
        builder: (context, state) => BusinessRequestDashboard(),
      ),
      // add products
      GoRoute(
        path: RoutesPath.addProduct,
        name: RoutesName.addProduct,
        builder: (context, state) => const AddProductScreen(),
      ),
      GoRoute(
        path: RoutesPath.productScreen,
        name: RoutesName.productScreen,
        builder: (context, state) => const ProductScreen(),
      ),
      GoRoute(
        path: RoutesPath.productBilling,
        name: RoutesName.productBilling,
        builder: (context, state) => const ProductBilling(),
      ),
      GoRoute(
        path: RoutesPath.choosePayment,
        name: RoutesName.choosePayment,
        builder: (context, state) => const ChoosePaymentMethod(),
      ),
      GoRoute(
        path: RoutesPath.externalTermialPayment,
        name: RoutesName.externalTermialPayment,
        builder: (context, state) => const InitialTerminalPayment(),
      ),
      GoRoute(
        path: RoutesPath.paymentReceiptStatus,
        name: RoutesName.paymentReceiptStatus,
        builder: (context, state) => PaymentReceiptStatus(),
      ),
      GoRoute(
        path: RoutesPath.communityFunding,
        name: RoutesName.communityFunding,
        builder: (context, state) => const CommunityFundingScreen(),
      ),
      GoRoute(
        path: RoutesPath.ideaSubmission,
        name: RoutesName.ideaSubmission,
        builder: (context, state) {
          final idea = state.extra as IdeaSubmissionModel?;
          return IdeaSubmissionForm(idea: idea);
        },
      ),
      GoRoute(
        path: RoutesPath.pitchDetails,
        name: RoutesName.pitchDetails,
        builder: (context, state) {
          final idea = state.extra as IdeaSubmissionModel;
          return PitchDetailsView(idea: idea);
        },
      ),
      GoRoute(
        path: RoutesPath.rewards,
        name: RoutesName.rewards,
        builder: (context, state) => const RewardScreeen(),
      ),
      GoRoute(
        path: RoutesPath.creditCard,
        name: RoutesName.creditCard,
        builder: (context, state) => const CreditCardScreen(),
      ),
      GoRoute(
        path: RoutesPath.memorableCode,
        name: RoutesName.memorableCode,
        builder: (context, state) => const CreateMemorableCodeScreen(),
      ),
      GoRoute(
        path: RoutesPath.receiveInitial,
        name: RoutesName.receiveInitial,
        builder: (context, state) => const ReceiveInitialPage(),
      ),
      GoRoute(
        path: RoutesPath.requestMoney,
        name: RoutesName.requestMoney,
        builder: (context, state) => const RequestMoneyScreen(),
      ),
      GoRoute(
        path: RoutesPath.topUpAccount,
        name: RoutesName.topUpAccount,
        builder: (context, state) => const TopUpAccountScreen(),
      ),
      GoRoute(
        path: RoutesPath.setLimit,
        name: RoutesName.setLimit,
        builder: (context, state) => TransferLimitScreen(),
      ),
      GoRoute(
          path: RoutesPath.requestReceived,
          name: RoutesName.requestReceived,
          builder: (context, state) {
            // final request = state.extra as MoneyRequest;
            return const RequestReceivedScreen();
          }),
      GoRoute(
          path: '/mainPage/:initialIndex',
          name: RoutesName.mainPage,
          builder: (context, state) {
            final initialIndex =
                int.parse(state.pathParameters['initialIndex']!);
            return MainPage(initialIndex: initialIndex);
          }),
    ]);
