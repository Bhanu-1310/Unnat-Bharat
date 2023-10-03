import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:medicine_scheduler_app/controller/shared_prefs.dart';

import '../model/user_model.dart';

class AuthController {
  Future<String> signUp(
    String username,
    String email,
    String password,
  ) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty && username.isNotEmpty) {
        UserCredential credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);

//Creating UserModel with the provided data...

        myUserModel userModel = myUserModel(
            username: username,
            email: email,
            password: password,
            uid: credential.user!.uid);

//Uploading the data in firestore...

        await FirebaseFirestore.instance
            .collection("users")
            .doc(credential.user!.uid)
            .set(userModel.toJson());

        return "Success creating account";
      } else {
        return "Error creating account";
      }
    } catch (e) {
      return "$e || Error occured while creating account";
    }
  }

  Future<String> loginUser(
      String email, String password, String userType) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        saveuserTypeToSharedPreferences(userType);
        return "Success logging in";
      } else {
        return "Error logging in";
      }
    } catch (e) {
      return "$e || Error occured while logging in";
    }
  }

  Future<String> logOutUser(String email, String password) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await FirebaseAuth.instance.signOut();
        return "Success logging out";
      } else {
        return "Error logging out";
      }
    } catch (e) {
      return "Error occured while logging out";
    }
  }
}
