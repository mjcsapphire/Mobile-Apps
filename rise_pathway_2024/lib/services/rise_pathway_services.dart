import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:rise_pathway/core/constants/config.dart';
import 'package:rise_pathway/core/errors/failures.dart';
import 'package:rise_pathway/core/helpers/helpers.dart';
import 'package:rise_pathway/services/api_services.dart';
import 'package:rise_pathway/src/models/pathways/pathway_response.dart';

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
      return Right(pathways);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, List<PathwayResponse>>> fatchPathwayQuestions(
      {required String email, required String pathway}) async {
    try {
      final response = await ApiServices.sendRequest(
          dio, RequestType.get, Config.fetchPathwayQuestions,
          headers: {"Content-Type": "application/json"},
          queryParams: {"email": email, "pathway": pathway});

      List<PathwayResponse> pathways = [];
      if (response != null) {
        for (var element in response) {
          pathways.add(PathwayResponse.fromJson(element));
        }
      }
      return Right(pathways);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, String>> submitPathwayTest({
    required String email,
    required String pathway,
  }) async {
    try {
      final response = await ApiServices.sendRequest(
        dio,
        RequestType.post,
        Config.submitPathwayTest,
        headers: {"Content-Type": "application/json"},
        queryParams: {"email": email},
        data: {"pathway": pathway},
      );

      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
