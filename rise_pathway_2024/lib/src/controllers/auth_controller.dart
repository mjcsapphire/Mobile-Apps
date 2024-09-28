import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:rise_pathway/core/helpers/helpers.dart';
import 'package:rise_pathway/services/auth_services.dart';
import 'package:rise_pathway/src/models/auth/sign_in_response.dart';

class AuthController extends GetxController {
  final Dio dio;
  AuthController({required this.dio});

  late final AuthServices _services = AuthServices(dio: dio);

  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;

  final userData = SignInResponse().obs;

  Future<void> signIn({required String email, required String password}) async {
    try {
      final failureOrSuccess =
          await _services.signIn(email: email, password: password);

      failureOrSuccess.fold(
        (failure) {
          logger.e("Failure in Sign In: $failure");
        },
        (success) async {
          final data = success.toJson();
          final jsonData = json.encode(data);
          await Helpers.setString(key: 'user', value: jsonData);
          userData.value = SignInResponse.fromJson(data);
        },
      );
    } catch (e) {
      logger.e("Error In Catch Sign In: $e");
      rethrow;
    }
  }

  Future<bool> signUp({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      final failureOrSuccess = await _services.signUp(
        name: name,
        email: email,
        password: password,
        confirmPassword: confirmPassword,
      );

      failureOrSuccess.fold(
        (failure) {
          logger.e("Error In Sign Up: $failure");
          return false;
        },
        (response) {
          logger.d("Successfully Sign Up: ${response.message}");
          if (response.message.contains('Success')) {
            EasyLoading.showSuccess(
              'Registration Successful',
              maskType: EasyLoadingMaskType.black,
            );
            return true;
          } else {
            EasyLoading.showError(
              'Registration Failed',
              maskType: EasyLoadingMaskType.black,
            );
            return false;
          }
        },
      );
      return false;
    } catch (e) {
      logger.e("Error In Sign Up: $e");
      rethrow;
    }
  }

  Future<void> resetPassword() async {
    await _services.resetPassword();
  }

  Future<void> changePassword() async {
    await _services.changePassword();
  }

  Future<void> changeMood({
    required String email,
    required String mood,
  }) async {
    final successOrFailure = await _services.changeMood(
      email: email,
      mood: mood,
    );
    successOrFailure.fold(
      (failure) {
        logger.e("Error In Change Mood: $failure");
      },
      (success) {
        logger.d("Successfully Change Mood: $success");
      },
    );
  }

  Future<void> signOut() async {
    try {
      await _services.signOut();
    } catch (e) {
      rethrow;
    }
  }
}
