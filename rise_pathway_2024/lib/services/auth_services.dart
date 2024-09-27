import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:rise_pathway/core/constants/config.dart';
import 'package:rise_pathway/core/errors/failures.dart';
import 'package:rise_pathway/core/helpers/helpers.dart';
import 'package:rise_pathway/services/api_services.dart';
import 'package:rise_pathway/src/models/auth/sign_in_response.dart';
import 'package:rise_pathway/src/models/auth/sign_up_response.dart';

class AuthServices {
  final Dio dio;
  AuthServices({required this.dio});

  Future<Either<Failure, SignInResponse>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await ApiServices.sendRequest(
        dio,
        RequestType.get,
        Config.fetchUser,
        headers: {
          "Content-Type": "application/json",
        },
        queryParams: {
          "email": email,
        },
      );

      return Right(SignInResponse.fromJson(response!.first));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, SignUpResponse>> signUp({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      final response = await ApiServices.sendRequest(
        dio,
        RequestType.post,
        Config.addUser,
        headers: {
          "Content-Type": "application/json",
        },
        queryParams: {
          "email": email,
        },
      );

      return Right(SignUpResponse.fromJson(response!));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future signOut() async {}

  Future resetPassword() async {}

  Future changePassword() async {}

  Future changeEmail() async {}

  Future changeMood({
    required String email,
    required int moodIndex,
  }) async {
    try {
      final response = await ApiServices.sendRequest(
        dio,
        RequestType.get,
        Config.updateMood,
        headers: {
          "Content-Type": "application/json",
        },
        queryParams: {
          "email": email,
          "mood": "happy",
        },
      );
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
