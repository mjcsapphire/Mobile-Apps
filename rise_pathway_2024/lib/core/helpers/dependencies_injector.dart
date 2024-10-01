import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:rise_pathway/core/constants/config.dart';
import 'package:rise_pathway/src/controllers/auth_controller.dart';
import 'package:rise_pathway/src/controllers/challenge_controller.dart';
import 'package:rise_pathway/src/controllers/chat_controller.dart';
import 'package:rise_pathway/src/controllers/home_controller.dart';
import 'package:rise_pathway/src/controllers/journal_controller.dart';
import 'package:rise_pathway/src/controllers/network_controller.dart';
import 'package:rise_pathway/src/controllers/rise_pathway_controller.dart';

class DependenciesInjector {
  static Future<void> initializeController() async {
    _injectDio();
    final dio = Get.find<Dio>();
    Get.put(AuthController(dio: dio));
    Get.put(NetworkController());
    Get.put(HomeController());
    Get.put(ChatController());
    Get.put(ChallengeController(dio: dio));
    Get.put(RisePathwayController(dio: dio));
    Get.put(JournalController(dio: dio));
  }

  static void deleteControllers() {
    Get.deleteAll();
  }

  static void _injectDio() {
    final dio = Dio(BaseOptions(baseUrl: Config.baseURL));
    Get.lazyPut<Dio>(() => dio);
  }
}
