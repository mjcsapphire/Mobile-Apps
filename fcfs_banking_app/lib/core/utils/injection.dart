import 'package:dio/dio.dart';
import 'package:fcfs_banking_app/core/utils/constant/api_constant.dart';
import 'package:fcfs_banking_app/src/controllers/auth_controller.dart';
import 'package:fcfs_banking_app/src/controllers/currency_exchange_controller.dart';
import 'package:fcfs_banking_app/src/controllers/direct_debit_controller.dart';
import 'package:fcfs_banking_app/src/controllers/idea_submission_controller.dart';
import 'package:fcfs_banking_app/src/controllers/money_request_controller.dart';
import 'package:fcfs_banking_app/src/controllers/notification_data_controller.dart';
import 'package:fcfs_banking_app/src/controllers/referral_controller.dart';
import 'package:fcfs_banking_app/src/controllers/theme_controller.dart';
import 'package:fcfs_banking_app/src/controllers/transaction_controller.dart';
import 'package:fcfs_banking_app/src/controllers/user_controller.dart';
import 'package:get/get.dart';

class DependencyInjector {
  static void inject() {
    _injectExternalDependencies();
    _injectControllers();
  }

  static void _injectExternalDependencies() {
    final dio = Dio(
      BaseOptions(baseUrl: ApiConstant.currencyUrl),
    );
    Get.lazyPut<Dio>(() => dio);
  }

  static void _injectControllers() {
    final dio = Get.find<Dio>();

    Get.lazyPut(() => AuthController());
    Get.lazyPut(() => UserController());
    Get.lazyPut(() => TransactionController());
    Get.lazyPut(() => DirectDebitController());
    Get.lazyPut(() => IdeaSubmissionController());
    Get.lazyPut(() => NotificationDataController());
    Get.lazyPut(() => ReferralController());
    Get.lazyPut(() => CurrencyController(dio));
    Get.lazyPut(() => ThemeController());
    Get.lazyPut(() => PaymentController());
  }
}
