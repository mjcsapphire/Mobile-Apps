import 'package:fcfs_banking_app/src/controllers/auth_controller.dart';
import 'package:get/get.dart';

class DependencyInjector {
  static void inject() {
    Get.lazyPut<AuthController>(() => AuthController());
  }
}
