import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:rise_pathway/core/constants/config.dart';
import 'package:rise_pathway/core/errors/exception.dart';
import 'package:rise_pathway/core/helpers/helpers.dart';

class ApiServices {
  static Future<dynamic> sendRequest(Dio dio, RequestType type, String path,
      {Map<String, dynamic>? queryParams,
      Map<String, dynamic>? headers,
      bool encoded = false,
      dynamic data,
      dynamic listData,
      CancelToken? cancelToken,
      FormData? formData}) async {
    // final NetworkController network = gtx.Get.find();

    // if (!network.isOnline) {
    //   logger.e('You Are Offline');
    //   return null;
    // }

    if (formData != null && formData.files.isNotEmpty) {
      for (var element in formData.files) {
        logger.i("Payload file: ${element.value.filename}");
      }
    }

    logger.i("""API Path: ${Config.baseURL}$path
Payload: 
  Query Params: $queryParams 
  Data: $data
  ListData: $listData 
  FormData: ${formData?.fields}""");

    final stopwatch = Stopwatch()..start();

    try {
      Response response;
      switch (type) {
        case RequestType.get:
          response = await dio.get(
            path,
            cancelToken: cancelToken,
            queryParameters: queryParams,
            options: Options(
              headers: headers,
              receiveTimeout: 120000.ms,
              sendTimeout: 120000.ms,
            ),
          );
          break;
        case RequestType.post:
          response = await dio.post(
            path,
            cancelToken: cancelToken,
            options: Options(
                headers: headers,
                contentType:
                    encoded == true ? Headers.formUrlEncodedContentType : null,
                validateStatus: (code) => true),
            data: queryParams ?? listData ?? formData ?? FormData.fromMap(data),
            queryParameters: queryParams ?? {},
          );
          break;
        case RequestType.delete:
          response = await dio.delete(
            path,
            cancelToken: cancelToken,
            queryParameters: queryParams,
            options: Options(headers: headers),
          );
          break;
        default:
          return null;
      }

      stopwatch.stop();
      logger.i("""
Path: ${Config.baseURL}$path
Response Data: ${jsonEncode(response.data)}
        """);

      if (response.statusCode == 200 || response.statusCode == 202) {
        return response.data == '' ? {} : response.data;
      } else if (response.statusCode == 400) {
        throw ServerException(
          code: response.statusCode,
          message: response.statusMessage,
        );
      } else if (response.statusCode == 502) {
        return {};
      } else {
        logger.e("""Error:
Status Code ${response.statusCode} - ${response.statusMessage}\n
Response: ${response.data}""");
        throw ServerException(
            message:
                response.data['message'] ?? response.data['errors']['message'],
            code: response.statusCode);
      }
    } on DioException catch (e) {
      logger.e(
          "Dio Exception: Status Code ${e.response?.statusCode} - ${e.response?.statusMessage}\nResponse: ${e.response?.data}");

      if (e.error == "Http status error [401]") {
        throw ServerException(message: "Unauthorized", code: 401);
      } else if (e.error is SocketException) {
        throw ServerException(message: "No Internet");
      } else {
        throw ServerException(message: e.error.toString());
      }
    } catch (e) {
      logger.e('Catch Error: ${e.toString()}');
      throw ServerException(message: e.toString());
    }
  }
}
