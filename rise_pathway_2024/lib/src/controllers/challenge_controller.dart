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

  Future<void> addChallenge({
    required String email,
    required String challenge,
  }) async {
    final successOrFailure = await _services.addChallenge(
      email: email,
      challenge: challenge,
    );
    successOrFailure.fold(
      (failure) {
        logger.e("Error In Submit Challenge: $failure");
      },
      (success) {
        logger.d("Successfully Submit Challenge: $success");
      },
    );
  }

  Future<void> removeChallenge({
    required String email,
    required String challenge,
  }) async {
    final successOrFailure = await _services.removeChallenge(
      email: email,
      challenge: challenge,
    );
    successOrFailure.fold(
      (failure) {
        logger.e("Error In Submit Challenge: $failure");
      },
      (success) {
        logger.d("Successfully Submit Challenge: $success");
      },
    );
  }

  Future<void> completeChallenge({
    required String email,
    required String challenge,
  }) async {
    final successOrFailure = await _services.completeChallenge(
      email: email,
      challenge: challenge,
    );
    successOrFailure.fold(
      (failure) {
        logger.e("Error In Submit Challenge: $failure");
      },
      (success) {
        logger.d("Successfully Submit Challenge: $success");
      },
    );
  }

  Future<void> fetchRelatedChallenges({required String email}) async {
    final successOrFailure =
        await _services.fatchRelatedChallenges(email: email);
    successOrFailure.fold(
      (failure) => logger.e(failure),
      (response) {
        // challenges.value = response;
      },
    );
  }
}
