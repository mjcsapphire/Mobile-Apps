import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:rise_pathway/core/constants/config.dart';
import 'package:rise_pathway/core/errors/failures.dart';
import 'package:rise_pathway/core/helpers/helpers.dart';
import 'package:rise_pathway/services/api_services.dart';

class ChatServices {
  final Dio dio;
  ChatServices({required this.dio});

  Future<Either<Failure, String>> sendMessage({
    required String email,
    required String message,
  }) async {
    try {
      final response = await ApiServices.sendRequest(
        dio,
        RequestType.post,
        Config.sendMessage,
        headers: {"Content-Type": "application/json"},
        queryParams: {"email": email, "message": message},
      );

      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
