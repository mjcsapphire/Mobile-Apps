import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:triple_g/src/controllers/home_controller.dart';

import '../constants/config.dart';

class DependenciesInjector {
  static Future<void> initializeController() async {
    _injectDio();
    final dio = Get.find<Dio>();
    debugPrint(dio.toString());
    Get.put(HomeController());
  }

  static void deleteControllers() {
    Get.deleteAll();
  }

  static void _injectDio() {
    final dio = Dio(BaseOptions(baseUrl: Config.baseURL));
    Get.lazyPut<Dio>(() => dio);
  }
}
