import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:rise_pathway/core/helpers/helpers.dart';
import 'package:rise_pathway/services/challenges_services.dart';
import 'package:rise_pathway/src/models/challenges/challenges_response.dart';

class ChallengeController extends GetxController {
  final Dio dio;
  ChallengeController({required this.dio});

  late final ChallengesServices _services = ChallengesServices(dio: dio);

  final challenges = <ChallengesResponse>[].obs;

  Future<void> fetchChallenges({required String email}) async {
    final successOrFailure = await _services.fetchChallenges(email: email);
    successOrFailure.fold(
      (failure) => logger.e(failure),
      (response) {
        challenges.value = response;
      },
    );
  }
}
