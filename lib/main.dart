import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:medicine_scheduler_app/globals/global_vars.dart';
import 'package:medicine_scheduler_app/view/login_screen.dart';
import 'package:medicine_scheduler_app/view/nav_bar_screen.dart';
import 'package:medicine_scheduler_app/view/splash_screen.dart';
import 'package:medicine_scheduler_app/view/user_home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: apiKey,
        appId: appId,
        messagingSenderId: messagingSenderId,
        projectId: projectId,
        storageBucket: storageBucket,
      ),
      //
    );
  } else {
    await Firebase.initializeApp();
  }
  // runApp(const MyApp());
  runApp(DevicePreview(
      enabled: !kReleaseMode, builder: (context) => const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Scheduler App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme:
              AppBarTheme(backgroundColor: Colors.teal.shade200, elevation: 0),
          primarySwatch: Colors.blue,
        ),
        home: const SplashScreen());
  }
}
