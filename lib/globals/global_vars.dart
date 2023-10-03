import 'package:medicine_scheduler_app/view/location_or_sos_screen.dart';
import 'package:medicine_scheduler_app/view/member_home_screen.dart';
import 'package:medicine_scheduler_app/view/user_home_screen.dart';
import 'package:flutter/material.dart';

List userAppScreens = [const UserHomeScreen(), const LocationOrSOSscreen()];

List memberAppScreens = [const MemberHomeScreen(), const LocationOrSOSscreen()];

bool isUser = true;

nextScreen(Widget page, BuildContext context) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => page));
}

nextScreenReplace(Widget page, BuildContext context) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => page));
}

showSnackBar(String text, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.tealAccent,
      content: Text(
        text,
        style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.normal),
      )));
}

///wrap in a confidential file-----------
String apiKey = "AIzaSyDxLV5Q70F3h0c5vPj9kgVUXvIPW97PYAo";
String authDomain = "unnatbharattestapp.firebaseapp.com";
String projectId = "unnatbharattestapp";
String storageBucket = "unnatbharattestapp.appspot.com";
String messagingSenderId = "1008393312284";
String appId = "1:1008393312284:web:6d3eea4215c0634d2867d9";

///RxVariables-----
String currentUsername = "";
String currentUserUid = "";
String currentUserEmail = "";
String userType = "";

List phNumbers = [];
List contactNames = [];
