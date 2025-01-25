import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:rise_pathway/core/constants/config.dart';
import 'package:rise_pathway/core/errors/failures.dart';
import 'package:rise_pathway/core/helpers/helpers.dart';
import 'package:rise_pathway/services/api_services.dart';
import 'package:rise_pathway/src/models/pathways/pathway_response.dart';
import 'package:rise_pathway/src/models/pathways/quiz_response.dart';
import 'package:rise_pathway/src/models/pathways/quiz_test_response.dart';

class RisePathwayServices {
  RisePathwayServices({required this.dio});
  final Dio dio;

  Future<Either<Failure, List<PathwayResponse>>> fetchPathways(
      {required String email}) async {
    try {
      final response = await ApiServices.sendRequest(
          dio, RequestType.get, Config.fetchPathways,
          headers: {"Content-Type": "application/json"},
          queryParams: {"email": email});

      List<PathwayResponse> pathways = [];
      if (response != null) {
        for (var element in response) {
          pathways.add(PathwayResponse.fromJson(element));
        }
      }
      // print("pathways: ${pathways.length}");
      // print("pathways response: ${pathways.toList()}");
      return Right(pathways);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, List<QuizResponse>>> fatchPathwayQuestions({
    // required String email,
    required String pathway,
  }) async {
    try {
      final response = await ApiServices.sendRequest(
          dio, RequestType.get, Config.fetchPathwayQuestions,
          headers: {
            "Content-Type": "application/json"
          },
          queryParams: {
            // "email": email,
            "pathway": pathway,
          });

      List<QuizResponse> quizes = [];
      if (response != null) {
        for (var element in response) {
          quizes.add(QuizResponse.fromJson(element));
        }
      }
      return Right(quizes);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, QuizTestResponse>> submitPathwayTest({
    required String email,
    required String pathway,
    required Map<String, String> questions,
  }) async {
    try {
      final response = await ApiServices.sendRequest(
        dio,
        RequestType.post,
        Config.submitPathwayTest,
        headers: {"Content-Type": "application/json"},
        queryParams: {
          "email": email,
          "pathway": pathway,
          ...questions,
        },
      );

      if (response is Map<String, dynamic>) {
        final quizTestResponse = QuizTestResponse.fromMap(response);
        return Right(quizTestResponse);
      } else {
        return Left(ServerFailure(message: "Unexpected response type"));
      }
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
