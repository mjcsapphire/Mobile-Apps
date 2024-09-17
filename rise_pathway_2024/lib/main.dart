import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rise_pathway/config/constants/package_export.dart';
import 'package:rise_pathway/config/helpers/dependencies_injector.dart';
import 'package:rise_pathway/config/routes/router.dart';
import 'package:rise_pathway/config/utils/theme.dart';

// Code  --- nnew Changes
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await DependenciesInjector.initializeController();

  final GoRouter router = CustomRouter.goRouter;
  runApp(MyApp(router: router));
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
      ),
    );
  }
}
