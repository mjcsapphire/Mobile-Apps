import 'package:get/get.dart';
import 'package:rise_pathway/src/controllers/chat_controller.dart';
import 'package:rise_pathway/src/controllers/home_controller.dart';

class DependenciesInjector {
  static Future<void> initializeController() async {
    Get.put(HomeController());
    Get.put(ChatController());
  }
}
