import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UsernameRepository {
  UsernameRepository._();

  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<bool> isUsernameAvailable(String username) async {
    final doc = await _db
        .collection('usernames')
        .doc(username.toLowerCase())
        .get();

    return !doc.exists;
  }

  static Future<void> saveUsername({
    required String username,
  }) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    final batch = _db.batch();

    // Update user
    batch.update(
      _db.collection('users').doc(uid),
      {
        'username': username.toLowerCase(),
        'updatedAt': FieldValue.serverTimestamp(),
      },
    );

    // Reserve username
    batch.set(
      _db.collection('usernames').doc(username.toLowerCase()),
      {
        'uid': uid,
      },
    );

    await batch.commit();
  }
}