import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EditProfileRepository {
  EditProfileRepository._();

  static final _db = FirebaseFirestore.instance;
  static final _auth = FirebaseAuth.instance;

  static String get uid => _auth.currentUser!.uid;

  static Future<Map<String, dynamic>> profile() async {
    final doc = await _db
        .collection("users")
        .doc(uid)
        .get();

    return doc.data() ?? {};
  }

  static Future<bool> usernameAvailable(
      String username,
      ) async {
    final snapshot = await _db
        .collection("users")
        .where("username", isEqualTo: username)
        .limit(1)
        .get();

    if (snapshot.docs.isEmpty) {
      return true;
    }

    return snapshot.docs.first.id == uid;
  }

  static Future<void> save({
    required String name,
    required String username,
    required String bio,
    required String avatar,
  }) async {
    await _db.collection("users").doc(uid).update({
      "name": name,
      "username": username,
      "bio": bio,
      "avatar": avatar,
      "updatedAt": FieldValue.serverTimestamp(),
    });
  }
}