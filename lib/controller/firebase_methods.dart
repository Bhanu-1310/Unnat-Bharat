import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medicine_scheduler_app/model/todo_model.dart';
import 'package:uuid/uuid.dart';

class FirebaseMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uploadPost(
      String caption, String uid, String username, String reminderdate) async {
    if (caption.isEmpty ||
        uid.isEmpty ||
        username.isEmpty ||
        reminderdate.isEmpty) {
      return "Fill all the Details";
    }
    String res = "error";

    try {
      String postId = const Uuid().v1();

      ToDo toDo = ToDo(
          text: caption,
          uid: uid,
          username: username,
          datePublished: FieldValue.serverTimestamp(),
          reminderDate: reminderdate,
          postId: postId);

      // saving in cloud firestore...
      _firestore.collection('ToDos').doc(postId).set(toDo.toJson());
      res = "success";
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<void> updateLatAndLong(String docId, String lat, String long) async {
    try {
      final collectionRef = FirebaseFirestore.instance.collection('users');
      final documentRef = collectionRef.doc(docId);
      await documentRef.update({"lat": lat, "long": long});
    } catch (e) {
      print(e.toString());
    }
  }

  Future<String> addPhoneNumber(
      String name, String phNumber, String docId) async {
    if (name.isEmpty || phNumber.isEmpty || docId.isEmpty) {
      return "Fill all details";
    }
    try {
      final collectionRef = FirebaseFirestore.instance.collection('users');
      final documentRef = collectionRef.doc(docId);
      await documentRef.update({
        "contactNames": FieldValue.arrayUnion([name]),
        "phNumber": FieldValue.arrayUnion([phNumber]),
      });
      return "success";
    } catch (e) {
      print(e.toString());
      return "failed";
    }
  }

  Future<String> deletePost(String postId) async {
    try {
      await _firestore.collection('ToDos').doc(postId).delete();
      return "Deleted the post successfully";
    } catch (e) {
      print(e.toString());
      return "Failed";
    }
  }
}
