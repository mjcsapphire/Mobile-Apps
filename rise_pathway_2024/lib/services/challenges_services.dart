import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:rise_pathway/core/constants/config.dart';
import 'package:rise_pathway/core/errors/failures.dart';
import 'package:rise_pathway/core/helpers/helpers.dart';
import 'package:rise_pathway/services/api_services.dart';
import 'package:rise_pathway/src/models/challenges/challenges_response.dart';

class ChallengesServices {
  final Dio dio;
  ChallengesServices({required this.dio});

  Future<Either<Failure, List<ChallengesResponse>>> fetchChallenges(
      {required String email}) async {
    try {
      final response = await ApiServices.sendRequest(
          dio, RequestType.get, Config.fetchChallenges,
          headers: {"Content-Type": "application/json"},
          queryParams: {"email": email});

      List<ChallengesResponse> challenges = [];
      
      if (response != null) {
        for (var element in response) {
          challenges.add(ChallengesResponse.fromJson(element));
        }
      }

      return Right(challenges);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
