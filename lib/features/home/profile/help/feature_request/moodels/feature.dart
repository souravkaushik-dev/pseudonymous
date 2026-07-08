import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FeatureRequestRepository {
  FeatureRequestRepository._();

  static final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  static final FirebaseAuth _auth =
      FirebaseAuth.instance;

  static Future<void> submit(
      String message,
      ) async {
    await _firestore
        .collection("feature_requests")
        .add({
      "uid": _auth.currentUser?.uid,

      "message": message.trim(),

      "status": "pending",

      "createdAt":
      FieldValue.serverTimestamp(),
    });
  }
}