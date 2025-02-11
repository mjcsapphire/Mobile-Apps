import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:rise_pathway/core/helpers/helpers.dart';
import 'package:rise_pathway/services/goal_service.dart';
import 'package:rise_pathway/src/models/goals/goal_response.dart';

class GoalController extends GetxController {
  final Dio dio;
  GoalController({required this.dio});

  late final GoalService _services = GoalService(dio: dio);

  final goals = <GoalResponse>[].obs;
  final boughtGoals = <GoalResponse>[].obs;
  RxBool isLoading = false.obs;

  Future<void> fetchGoals({required String email}) async {
    isLoading.value = true;
    final successOrFailure = await _services.fetchGoals(email: email);
    successOrFailure.fold(
      (failure) {
        isLoading.value = false;
        logger.e(failure);
      },
      (response) {
        isLoading.value = false;
        goals.value = response;
      },
    );
  }

  Future<void> fetchBoughtGoals({required String email}) async {
    isLoading.value = true;
    final successOrFailure = await _services.fetchGoals(email: email);
    successOrFailure.fold(
      (failure) {
        isLoading.value = false;
        logger.e(failure);
      },
      (response) {
        isLoading.value = false;
        boughtGoals.value = response;
      },
    );
  }
}
