import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:rise_pathway/core/constants/config.dart';
import 'package:rise_pathway/core/errors/failures.dart';
import 'package:rise_pathway/core/helpers/helpers.dart';
import 'package:rise_pathway/services/api_services.dart';
import 'package:rise_pathway/src/models/auth/sign_in_response.dart';
import 'package:rise_pathway/src/models/auth/sign_up_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        headers: {"Content-Type": "application/json"},
        queryParams: {"email": email},
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

  Future signOut() async {
    try {
      SharedPreferences sharedPref = await SharedPreferences.getInstance();
      await sharedPref.remove('user');
    } catch (e) {
      rethrow;
    }
  }

  Future resetPassword() async {}

  Future changePassword() async {}

  Future changeEmail() async {}

  Future changeMood({
    required String email,
    required String mood,
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
          "mood": mood,
        },
      );
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, SignUpResponse>> updateUser({
    required String email,
    required String firstname,
    required String surname,
  }) async {
    try {
      final response = await ApiServices.sendRequest(
        dio,
        RequestType.post,
        Config.updateUser,
        headers: {
          "Content-Type": "application/json",
        },
        queryParams: {
          "email": email,
          "firstname": firstname,
          "surname": surname
        },
      );

      return Right(SignUpResponse.fromJson(response!));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, SignUpResponse>> updateProfileImage({
    required String email,
    required String imagePath,
  }) async {
    try {
      if (!File(imagePath).existsSync()) {
        throw Exception("Image file does not exist at path: $imagePath");
      }

      final fileName = imagePath.split('/').last;
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(imagePath, filename: fileName),
        // "user_email": email,
        // "filename": fileName,
      });

      // Send API request
      final response = await ApiServices.sendRequest(
          dio, RequestType.post, Config.uploadImage,
          headers: {
            "Content-Type": "multipart/form-data",
          },
          // formData: formData,
          queryParams: {
            "user_email": email,
            "filename": fileName,
            // "file": await MultipartFile.fromFile(imagePath, filename: fileName),
          },
          formData: formData);

      return Right(SignUpResponse.fromJson(response!));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
