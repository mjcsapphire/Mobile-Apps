import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rise_app_emotivating_minds_2023/pages/checkin_screen.dart';
import 'package:rise_app_emotivating_minds_2023/pages/contact_coach_page.dart';
import 'package:rise_app_emotivating_minds_2023/pages/health_path_page.dart';
import 'package:rise_app_emotivating_minds_2023/pages/homepage.dart';
import 'package:rise_app_emotivating_minds_2023/pages/journal_screen.dart';
import 'package:rise_app_emotivating_minds_2023/pages/profile.dart';
import 'package:rise_app_emotivating_minds_2023/pages/reflections_page.dart';
import 'package:rise_app_emotivating_minds_2023/pages/reset_password.dart';
import 'package:rise_app_emotivating_minds_2023/pages/rise_screen.dart';
import 'package:rise_app_emotivating_minds_2023/pages/signin_screen.dart';
import 'package:rise_app_emotivating_minds_2023/pages/signup_screen.dart';
import 'package:rise_app_emotivating_minds_2023/pages/toolkit_image_page.dart';
import 'package:rise_app_emotivating_minds_2023/pages/toolkit_sound_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const RiseApp());
}

class RiseApp extends StatelessWidget {
  const RiseApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    // Get the firebase user
    User? firebaseUser = FirebaseAuth.instance.currentUser;

    // Define a widget
    Widget firstWidget;

    // Assign widget based on availability of currentUser
    if (firebaseUser != null) {
      firstWidget = CheckInScreen();
    } else {
      firstWidget = SignInScreen();
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rise App',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: firstWidget,
      routes: {
        '/checkin':(context) => CheckInScreen(),
        '/home':(context) => Homepage(),
        '/signin':(context) => SignInScreen(),
        '/signup':(context) => SignUpScreen(),
        '/resetpassword':(context) => ResetPassword(),
        '/profile':(context) => ProfilePage(data: theuser[0],),
        '/journal':(context) => JournalEntriesPage(),
        '/toolkitSound':(context) => ToolkitSoundPage(),
        '/toolkitImage':(context) => ToolkitPage(),
        '/rise':(context) => RiseScreen(data: theuser[0]),
        '/reflections':(context) => ReflectionsPage(data: theuser[0]),
        '/contact':(context) => ContactCoachPage(),
        '/health_path':(context) => HealthPathwayPage(),
      },
    );
  }
}

