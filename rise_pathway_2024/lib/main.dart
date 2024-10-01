import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:rise_pathway/core/constants/package_export.dart';
import 'package:rise_pathway/core/helpers/database_helper.dart';
import 'package:rise_pathway/core/helpers/dependencies_injector.dart';
import 'package:rise_pathway/core/helpers/helpers.dart';
import 'package:rise_pathway/core/routes/router.dart';
import 'package:rise_pathway/core/utils/environment.dart';
import 'package:rise_pathway/core/utils/theme.dart';

void main() async {
  await mainDependencies();

  await DatabaseHelper.instance.fetchDatabase;
  final GoRouter router = CustomRouter.goRouter;

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
