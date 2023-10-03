// ignore_for_file: camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';

class myUserModel {
  String username;
  String password;
  String email;
  String uid;

  myUserModel(
      {required this.username,
      required this.email,
      required this.password,
      required this.uid});

//APP to Firebase MAP=JSON

  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "password": password,
      "email": email,
      "uid": uid
    };
  }

//toJson for companies collection

//Firebase(Map) to App(UserModel) - using static keyword to access this function without class params
//fromSnap=fromJson

  static myUserModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return myUserModel(
        username: snapshot['username'],
        password: snapshot['password'],
        email: snapshot['email'],
        uid: snapshot['uid']);
  }
}
