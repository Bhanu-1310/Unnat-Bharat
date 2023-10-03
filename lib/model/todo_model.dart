// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';

class ToDo {
  final String text;
  final String uid;
  final String username;
  final datePublished;
  final String reminderDate;
  final String postId;
// remove int when array is needed

  const ToDo(
      {required this.text,
      required this.uid,
      required this.username,
      required this.datePublished,
      required this.reminderDate,
      required this.postId});

  Map<String, dynamic> toJson() => {
        "text": text,
        "uid": uid,
        "username": username,
        "datePublished": datePublished,
        "reminderDate": reminderDate,
        "postId": postId,
      };

  static ToDo fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return ToDo(
      username: snapshot['username'],
      uid: snapshot['uid'],
      text: snapshot['text'],
      postId: snapshot['postId'],
      datePublished: snapshot['datePublished'],
      reminderDate: snapshot['reminderDate'],
    );
  }
}
