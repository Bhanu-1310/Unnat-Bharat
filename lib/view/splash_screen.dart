import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medicine_scheduler_app/globals/global_vars.dart';
import 'package:medicine_scheduler_app/view/login_screen.dart';
import 'package:medicine_scheduler_app/view/nav_bar_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
//method to change screen

  changeScreen() {
    Future.delayed(const Duration(seconds: 2), () {
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user == null && mounted) {
          nextScreenReplace(const LoginScreen(), context);
        } else {
          nextScreenReplace(const NavBarScreeen(), context);
        }
      });
      nextScreenReplace(const LoginScreen(), context);
    });
  }

  @override
  void initState() {
    super.initState();
    changeScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Spacer(),
          Text(
            "Unnat Bharat",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
          ),
          Spacer(),
        ],
      )),
    );
  }
}
