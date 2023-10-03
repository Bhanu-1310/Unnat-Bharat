import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medicine_scheduler_app/controller/shared_prefs.dart';
import 'package:medicine_scheduler_app/globals/global_vars.dart';

class NavBarScreeen extends StatefulWidget {
  const NavBarScreeen({super.key});

  @override
  State<NavBarScreeen> createState() => _NavBarScreeenState();
}

class _NavBarScreeenState extends State<NavBarScreeen> {
  int currentScreenIndex = 0;

  StreamSubscription<DocumentSnapshot>? _subscription;

  getData() {
    DocumentReference docRef = FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid);
    _subscription = docRef.snapshots().listen((value) {
      if (value.exists) {
        setState(() {
          currentUsername = value.get("username");
          currentUserEmail = value.get("email");
          currentUserUid = FirebaseAuth.instance.currentUser!.uid;
          phNumbers = value.get("phNumber");
          contactNames = value.get("contactNames");
        });
      }
    });
  }

  loadUserType() async {
    userType = await loaduserTypeFromSharedPreferences();
  }

  @override
  void initState() {
    super.initState();
    loadUserType();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
          height: 60,
          backgroundColor: Colors.green,
          color: Colors.tealAccent,
          buttonBackgroundColor: Colors.teal,
          animationDuration: const Duration(milliseconds: 250),
          onTap: (value) {
            setState(() {
              currentScreenIndex = value;
            });
          },
          items: const [
            Icon(Icons.home),
            Icon(Icons.location_history),
          ]),
      body: userType == "User"
          ? userAppScreens[currentScreenIndex]
          : memberAppScreens[currentScreenIndex],
    );
  }
}
