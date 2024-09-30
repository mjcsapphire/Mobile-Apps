import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:rise_pathway/core/constants/config.dart';
import 'package:rise_pathway/core/errors/failures.dart';
import 'package:rise_pathway/core/helpers/helpers.dart';
import 'package:rise_pathway/services/api_services.dart';
import 'package:rise_pathway/src/models/journals/journal_response.dart';

class JournalServices {
  JournalServices({
    required this.dio,
  });

  final Dio dio;

  Future<Either<Failure, String>> addJournal({
    required String email,
    required String title,
    required String content,
  }) async {
    try {
      final response = await ApiServices.sendRequest(
        dio,
        RequestType.post,
        Config.addJournalEntry,
        headers: {"Content-Type": "application/json"},
        queryParams: {"email": email},
        data: {"title": title, "content": content},
      );

      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, List<JournalEntriesResponse>>> fetchJournals({
    required String email,
  }) async {
    try {
      final response = await ApiServices.sendRequest(
        dio,
        RequestType.get,
        Config.fetchJournalEntries,
        headers: {"Content-Type": "application/json"},
        queryParams: {"email": email},
      );

      
      List<JournalEntriesResponse> challenges = [];

      if (response != null) {
        for (var element in response) {
          challenges.add(JournalEntriesResponse.fromJson(element));
        }
      }

      return Right(challenges);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, String>> updateJournal({
    required String email,
    required String id,
    required String title,
    required String content,
  }) async {
    try {
      final response = await ApiServices.sendRequest(
        dio,
        RequestType.post,
        Config.updateJournalEntry,
        headers: {"Content-Type": "application/json"},
        queryParams: {"email": email, "id": id},
        data: {"title": title, "content": content},
      );

      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, String>> deleteJournal({
    required String email,
    required String id,
  }) async {
    try {
      final response = await ApiServices.sendRequest(
        dio,
        RequestType.post,
        Config.deleteJournalEntry,
        headers: {"Content-Type": "application/json"},
        queryParams: {"email": email, "id": id},
      );

      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
