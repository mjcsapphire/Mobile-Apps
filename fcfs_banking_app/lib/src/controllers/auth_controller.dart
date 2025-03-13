import 'dart:io';

import 'package:fcfs_banking_app/core/utils/app_helpers.dart';
import 'package:fcfs_banking_app/services/firebase/auth_services.dart';
import 'package:fcfs_banking_app/services/router/router.dart';
import 'package:fcfs_banking_app/services/router/routes_name.dart';
import 'package:fcfs_banking_app/src/models/user_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:logger/logger.dart';
import 'package:vibration/vibration.dart';

class AuthController extends GetxController {
  final AuthService _authService = AuthService();
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  final LocalAuthentication auth = LocalAuthentication();

  // Observable user
  var user = Rx<UserModel?>(null);

  RxBool isLoading = false.obs;
  RxBool isAuthenticated = false.obs;
  RxBool biometricEnabled = false.obs;
  RxString errorMessage = ''.obs;
  RxBool isPasscodeEnabled = false.obs;

  var logger = Logger();

  @override
  void onInit() {
    super.onInit();
    checkBiometricStatus();
    checkPasscodecStatus();
  }

  Future<void> signUpUser({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String country,
    required String zipCode,
    required String phoneNumber,
    required String role,
    required File idImage,
    required String businessName,
  }) async {
    isLoading.value = true;
    (await _authService.signUpUser(
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
      country: country,
      zipCode: zipCode,
      phoneNumber: phoneNumber,
      role: role,
      idImage: idImage,
      businessName: role == "Business" ? (businessName ?? '') : '',
    ))
        .fold(
      (error) {
        errorMessage.value = error;
        AppHelpers.toast(error);
        logger.e('Error signing up user: $error');
      },
      (newUser) {
        user.value = newUser;
        errorMessage.value = '';

        router.goNamed(RoutesName.registerComplete);
      },
    );
    isLoading.value = false;
  }

  // Sign in user and handle success/error with fold
  Future<void> signInUser(String email, String password) async {
    isLoading.value = true;
    (await _authService.signInUser(email, password)).fold(
      (error) {
        errorMessage.value = error;
        AppHelpers.toast(error);
        logger.e('Error signing in user: $error');
      },
      (fetchedUser) {
        user.value = fetchedUser;
        errorMessage.value = '';
        AppHelpers.setLoggedInStatus(true);

        router.goNamed(RoutesName.memorableCode);
      },
    );
    isLoading.value = false;
  }

  // Fetch user data by UID
  Future<void> fetchUserData(String uid) async {
    isLoading.value = true;
    (await _authService.fetchUserData(uid)).fold(
      (error) {
        errorMessage.value = error;
        logger.e('Error fetching user data: $error');
      },
      (fetchedUser) {
        user.value = fetchedUser;
        errorMessage.value = '';
      },
    );
    isLoading.value = false;
  }

  // Sign out user
  Future<void> signOutUser() async {
    isLoading.value = true;
    (await _authService.signOutUser()).fold(
      (error) {
        errorMessage.value = error;
        logger.e('Error signing out user: $error');
      },
      (_) {
        user.value = null;
        errorMessage.value = '';
      },
    );
    isLoading.value = false;
  }

  // fingerprint logic
  Future<void> checkBiometricStatus() async {
    biometricEnabled.value = await AppHelpers.isBiometricEnabled();
  }

  Future<void> checkPasscodecStatus() async {
    isPasscodeEnabled.value = await AppHelpers.getPasscodeStatus();
  }

  Future<void> enableBiometrics() async {
    bool canAuthenticate = await auth.canCheckBiometrics;
    if (!canAuthenticate) {
      AppHelpers.toast(
          'Your device does not support biometric authentication.');
      return;
    }

    try {
      bool authenticated = await auth.authenticate(
        localizedReason: 'Enable biometric authentication for secure login',
        options: const AuthenticationOptions(biometricOnly: true),
      );

      if (authenticated) {
        await AppHelpers.setBiometricEnabled(true); // Persist setting
        checkBiometricStatus(); // Re-fetch the status to update the UI
        AppHelpers.toast('Biometric authentication enabled');
      }
    } catch (e) {
      logger.e('Error enabling biometric authentication: $e');
      AppHelpers.toast('Failed to enable biometric authentication');
    }
  }

  Future<void> disableBiometrics() async {
    await AppHelpers.setBiometricEnabled(false);
    checkBiometricStatus(); // Re-fetch the status to update the UI
    AppHelpers.toast('Biometric authentication disabled');
  }

  Future<bool> authenticate() async {
    bool authenticated = false;
    try {
      authenticated = await auth.authenticate(
        localizedReason: 'Please authenticate to continue',
        options: const AuthenticationOptions(biometricOnly: true),
      );

      if (authenticated) {
        isAuthenticated.value = true;
        if ((await Vibration.hasVibrator()) ?? false) {
          Vibration.vibrate(duration: 200);
        }
        router.goNamed(RoutesName.mainPage,
            pathParameters: {'initialIndex': '0'});
      } else {
        isAuthenticated.value = false;
      }
      return authenticated;
    } catch (e) {
      isAuthenticated.value = false;
      Get.snackbar('Error', 'Biometric authentication failed');
      logger.e('Error Biometric authenticating user: $e');
      return false;
    }
  }
}
