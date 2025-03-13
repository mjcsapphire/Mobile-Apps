import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:rise_pathway/core/constants/config.dart';
import 'package:rise_pathway/core/errors/failures.dart';
import 'package:rise_pathway/core/helpers/helpers.dart';
import 'package:rise_pathway/services/api_services.dart';
import 'package:rise_pathway/src/models/chats/chat_model.dart';

class ChatServices {
  final Dio dio;
  ChatServices({required this.dio});

  Future<Either<Failure, dynamic>> sendMessage({
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

  Future<Either<Failure, List<ChatResponse>>> getMessages({
    required String email,
    required int limit,
    required int offset,
  }) async {
    try {
      final response = await ApiServices.sendRequest(
        dio,
        RequestType.get,
        Config.getMessages,
        headers: {"Content-Type": "application/json"},
        queryParams: {"email": email, "limit": limit, "offset": offset},
      );

      if (response is List) {
        return Right(response.map((e) => ChatResponse.fromJson(e)).toList());
      }

      return Left(ServerFailure(message: "Unexpected response format"));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
