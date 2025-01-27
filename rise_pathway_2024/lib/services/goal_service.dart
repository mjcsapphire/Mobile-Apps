import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:rise_pathway/core/constants/config.dart';
import 'package:rise_pathway/core/errors/failures.dart';
import 'package:rise_pathway/core/helpers/helpers.dart';
import 'package:rise_pathway/services/api_services.dart';
import 'package:rise_pathway/src/models/goals/goal_response.dart';

class GoalService {
  GoalService({required this.dio});
  final Dio dio;

  Future<Either<Failure, List<GoalResponse>>> fetchGoals(
      {required String email}) async {
    try {
      final response = await ApiServices.sendRequest(
          dio, RequestType.get, Config.fetchGoals,
          headers: {"Content-Type": "application/json"},
          queryParams: {"email": email, "user_owned": 0});

      List<GoalResponse> goals = [];
      if (response != null) {
        for (var element in response) {
          goals.add(GoalResponse.fromJson(element));
        }
      }
      return Right(goals);
    } catch (e) {
      logger.e(e);
      return Left(ServerFailure(message: e.toString()));
    }
  }

    Future<Either<Failure, List<GoalResponse>>> fetchBoughtGoals(
      {required String email}) async {
    try {
      final response = await ApiServices.sendRequest(
          dio, RequestType.get, Config.fetchGoals,
          headers: {"Content-Type": "application/json"},
          queryParams: {"email": email, "user_owned": 1});

      List<GoalResponse> goals = [];
      if (response != null) {
        for (var element in response) {
          goals.add(GoalResponse.fromJson(element));
        }
      }
      return Right(goals);
    } catch (e) {
      logger.e(e);
      return Left(ServerFailure(message: e.toString()));
    }
  }


}
