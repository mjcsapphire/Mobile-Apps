// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rise_pathway/core/constants/package_export.dart';
import 'package:rise_pathway/core/routes/routes.dart';
import 'package:rise_pathway/core/utils/colors.dart';
import 'package:rise_pathway/src/controllers/auth_controller.dart';
import 'package:rise_pathway/src/models/auth/sign_in_response.dart';

import '../../../core/helpers/helpers.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    Future.delayed(const Duration(seconds: 3), () async {
      final user = await Helpers.getString(key: 'user');
      if (user != null) {
        final data = json.decode(user);
        authController.signIn(email: data['user_email'], password: '');
        final userData = SignInResponse.fromJson(data);
        authController.userData.value = userData;
        context.go(loginSelectMood);
      } else {
        context.go(login);
      } 
    });

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: RiseText(
          'Rise Pathway',
          style: theme.headlineMedium!.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.white,
          ),
        )
            .animate()
            .scale(begin: const Offset(-10, -10), end: const Offset(1, 1))
            .effect(
                curve: Curves.bounceIn, duration: const Duration(seconds: 1))
            .fadeIn(duration: 500.ms),
      ),
    );
  }
}
