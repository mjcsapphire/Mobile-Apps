import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fcfs_banking_app/core/utils/app_helpers.dart';
import 'package:fcfs_banking_app/core/utils/constant/api_constant.dart';
import 'package:fcfs_banking_app/core/utils/failure.dart';
import 'package:fcfs_banking_app/src/models/currency_model.dart';
import 'package:logger/logger.dart';

class CurrencyApiService {
  final Dio dio;

  CurrencyApiService(this.dio);

  Future<Either<Failure, CurrencyResponse>> getCurrency() async {
    try {
      final queryParams = {
        'apikey': ApiConstant.currencyApiKey,
        'currencies': 'INR,EUR,GBP,JPY,CAD',
        'base_currency': 'USD',
      };
      final response = await AppHelpers.sendRequest(
        dio,
        RequestType.get,
        ApiConstant.endPoint,
        queryParam: queryParams,
      );

      if (response.data != null) {
        final currencyResponse = CurrencyResponse.fromJson(response.data);
        return Right(currencyResponse);
      } else {
        return Left(ServerFailure(message: 'No data received from server.'));
      }
    } on DioException catch (e) {
      Logger().e('DioException: ${e.message}');
      return Left(ServerFailure(message: 'DioException: ${e.message}'));
    } catch (e) {
      Logger().e('Unexpected error: $e');
      return Left(ServerFailure(message: 'Unexpected error: $e'));
    }
  }
}
