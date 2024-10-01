import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:rise_pathway/core/helpers/helpers.dart';
import 'package:rise_pathway/services/rise_pathway_services.dart';
import 'package:rise_pathway/src/models/pathways/pathway_response.dart';

class RisePathwayController extends GetxController {
  final Dio dio;
  RisePathwayController({required this.dio});

  late final RisePathwayServices _services = RisePathwayServices(dio: dio);

  final pathways = <PathwayResponse>[].obs;

  Future<void> fetchPathways({required String email}) async {
    final successOrFailure = await _services.fetchPathways(email: email);
    successOrFailure.fold(
      (failure) => logger.e(failure),
      (response) {
        pathways.value = response;
      },
    );
  }

  Future<void> fatchPathwayQuestions({
    required String email,
    required String pathway,
  }) async {
    final successOrFailure = await _services.fatchPathwayQuestions(
      email: email,
      pathway: pathway,
    );
    successOrFailure.fold(
      (failure) => logger.e(failure),
      (response) {
        pathways.value = response;
      },
    );
  }

  Future<void> submitPathway({
    required String email,
    required String pathway,
  }) async {
    final successOrFailure = await _services.submitPathwayTest(
      email: email,
      pathway: pathway,
    );
    successOrFailure.fold(
      (failure) {
        logger.e("Error In Delete Pathway: $failure");
      },
      (success) {
        logger.d("Successfully Delete Pathway: $success");
      },
    );
  }
}
