import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rise_pathway/core/helpers/helpers.dart';
import 'package:rise_pathway/services/rise_pathway_services.dart';
import 'package:rise_pathway/src/models/pathways/pathway_response.dart';
import 'package:rise_pathway/src/models/pathways/quiz_response.dart';
import 'package:rise_pathway/src/models/pathways/quiz_test_response.dart';

class RisePathwayController extends GetxController {
  final Dio dio;
  RisePathwayController({required this.dio});

  late final RisePathwayServices _services = RisePathwayServices(dio: dio);

  final pathways = <PathwayResponse>[].obs;
  final quizs = <QuizResponse>[].obs;
  final quizTestResponse = QuizTestResponse().obs;
  var selectedSong = Rxn<Map<String, String>>(); // Reactive variable
  final AudioPlayer audioPlayer = AudioPlayer();
  var isPlaying = false.obs;
  var position = 0.0.obs;
  var duration = 0.0.obs;

  Future<void> fetchPathways({required String email}) async {
    final successOrFailure = await _services.fetchPathways(email: email);
    successOrFailure.fold(
      (failure) => logger.e(failure),
      (response) {
        pathways.value = response;
      },
    );
  }

  Future<void> fetchPathwayQuestions({
    // required String email,
    required String pathway,
  }) async {
    final successOrFailure = await _services.fatchPathwayQuestions(
      // email: email,
      pathway: pathway,
    );
    successOrFailure.fold(
      (failure) => logger.e(failure),
      (questions) {
        quizs.value = questions;
      },
    );
  }

  Future<void> submitPathway({
    required String email,
    required String pathway,
    required Map<String, String> questions,
  }) async {
    final successOrFailure = await _services.submitPathwayTest(
      email: email,
      pathway: pathway,
      questions: questions,
    );
    successOrFailure.fold(
      (failure) {
        logger.e("Error In submitting pathway test: $failure");
      },
      (success) {
        logger.d("Successfully submitted pathway test: $success");
        final response = success;
        quizTestResponse.value = response;
        logger.i("quizTestResponse: ${quizTestResponse.value.toMap()}");
      },
    );
  }
}
