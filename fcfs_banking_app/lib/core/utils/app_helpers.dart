import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fcfs_banking_app/core/theme/colors.dart';
import 'package:fcfs_banking_app/core/utils/constant/api_constant.dart';
import 'package:fcfs_banking_app/core/utils/exception.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum RequestType { get, post, put, delete, patch }

class AppHelpers {
  static toast(String text) {
    return Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIosWeb: 5,
      backgroundColor: AppColors.black,
      textColor: AppColors.grey,
      fontSize: 16.0,
    );
  }

  static showSnackBar(
      {required BuildContext context, required String content}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(content),
      ),
    );
  }

  static String formatDate(DateTime date) {
    return DateFormat.yMMMd().format(date); // e.g., "Nov 8, 2024"
  }

  static String? validatePassword(String? value) {
    final passwordRegex = RegExp(r'^(?=.*[a-zA-Z])(?=.*\d).{8,}$');
    if (value == null || value.isEmpty) {
      return 'Password cannot be empty';
    } else if (!passwordRegex.hasMatch(value)) {
      return 'Password must be at least 8 characters and include both letters and numbers';
    }
    return null;
  }

  static Future<File?> pickImage(ImageSource source) async {
    File? image;
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);

      if (pickedImage != null) {
        image = File(pickedImage.path);
      }
    } catch (e) {
      Logger().e(e.toString());
    }
    return image;
  }

  // file picker
  static Future<File?> pickFile() async {
    File? file;
    try {
      final result = await FilePicker.platform.pickFiles();

      if (result != null && result.files.single.path != null) {
        file = File(result.files.single.path!);
      }
    } catch (e) {
      Logger().e(e.toString());
    }
    return file;
  }

  static saveUser({required String key, required bool value}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }

  static Future<bool?> getUser({required String key}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }

  static Future<void> setLoggedInStatus(bool status) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', status);
  }

  static Future<bool> isBiometricEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('biometricEnabled') ?? false;
  }

  // Enable or disable biometric in local storage
  static Future<void> setBiometricEnabled(bool isEnabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('biometricEnabled', isEnabled);
  }

  // Check the login status
  static Future<bool> checkLoggedInStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  // set passcode
  static Future<void> setPasscode(String passcode) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('passcode', passcode);
  }

  // get passcode
  static Future<String?> getPasscode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('passcode');
  }

  // set passcode status
  static Future<void> setPasscodeStatus(bool status) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('passcodeStatus', status);
  }

  // get passcode status
  static Future<bool> getPasscodeStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('passcodeStatus') ?? false;
  }

  static Future<bool> hasSecuritySetup() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('securitySetup') ?? false;
  }

  // Set security setup status (used when a security question/passcode is created)
  static Future<void> setSecuritySetup(bool isSet) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('securitySetup', isSet);
  }

  static Future<Response> sendRequest(
    Dio dio,
    RequestType type,
    String endpoint, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? formData,
    Map<String, dynamic>? queryParam,
  }) async {
    dio.options.headers = {
      'connection': 'keep-alive',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    final String url = "${ApiConstant.currencyUrl}$endpoint";
    print('URL: $url');

    try {
      Response response;
      switch (type) {
        case RequestType.get:
          response = await dio.get(url, queryParameters: queryParam);
          debugPrint('GET request sent to $url with query $queryParam');
          Logger().i('Response: ${response.data}');
          break;
        case RequestType.post:
          if (formData != null) {
            response = await dio.post(url, data: FormData.fromMap(formData));
          } else {
            response = await dio.post(url, data: data);
          }
          debugPrint('POST request sent to $url with data: $data');
          break;
        case RequestType.put:
          response = await dio.put(url, data: data);
          debugPrint('PUT request sent to $url with data: $data');
          break;
        case RequestType.delete:
          response = await dio.delete(url);
          debugPrint('DELETE request sent to $url');
          break;
        case RequestType.patch:
          response = await dio.patch(url, data: data);
          debugPrint('PATCH request sent to $url with data: $data');
          break;
        default:
          throw ServerException(message: 'Unsupported HTTP method type: $type');
      }

      // debugPrint('Response received: ${response.statusCode}, ${response.data}');

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return response;
      } else if (response.statusCode! >= 400 && response.statusCode! < 500) {
        throw ClientException(
            message: 'Client error: ${response.statusMessage}');
      } else if (response.statusCode! >= 500 && response.statusCode! < 600) {
        throw ServerException(
            message: 'Server error: ${response.statusMessage}');
      } else {
        throw ServerException(
            message: 'Unexpected status code: ${response.statusCode}');
      }
    } on DioException catch (e) {
      debugPrint('DioException: ${e.message}');
      if (e.response != null) {
        debugPrint(
            'DioException response: ${e.response?.statusCode}, ${e.response?.data}');
        throw ServerException(
            message: 'Server error: ${e.response?.statusMessage}');
      } else {
        debugPrint('DioException without response: ${e.message}');
        throw ServerException(message: 'Connection error: ${e.message}');
      }
    } catch (e) {
      debugPrint('Unexpected error: $e');
      throw ServerException(message: 'Unexpected error: $e');
    }
  }
}
