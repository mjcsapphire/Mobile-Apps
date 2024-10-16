import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import 'package:triple_g/core/utils/colors.dart';

import 'core/helpers/database_helper.dart';
import 'core/helpers/dependencies_injector.dart';
import 'core/helpers/helpers.dart';
import 'core/routes/router.dart';
import 'core/utils/environment.dart';
import 'core/utils/theme.dart';

void main() async {
  await mainDependencies();

  await DatabaseHelper.instance.fetchDatabase;
  final GoRouter router = GRouter.goRouter;

  if (DatabaseHelper.instance.isDatabaseInitialized) {
    runApp(MyApp(router: router));
  } else {
    logger.e('Database Is not Initialized');
  }
}

Future<void> mainDependencies() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: Environment.fileName);
  await DependenciesInjector.initializeController();
}

class MyApp extends StatefulWidget {
  final GoRouter router;
  const MyApp({super.key, required this.router});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        // statusBarColor: AppColors.black,
        systemNavigationBarColor: AppColors.secondaryColor,
        statusBarBrightness: Brightness.light,
      ),
    );

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return Sizer(
      builder: (context, orientation, deviceType) => GetMaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        routerDelegate: widget.router.routerDelegate,
        routeInformationParser: widget.router.routeInformationParser,
        routeInformationProvider: widget.router.routeInformationProvider,
        builder: EasyLoading.init(),
      ),
    );
  }
}
