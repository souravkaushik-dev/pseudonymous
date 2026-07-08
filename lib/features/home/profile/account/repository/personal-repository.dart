import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../features/models/app_user.dart';

class PersonalInformationRepository {
  PersonalInformationRepository._();

  static final _firestore = FirebaseFirestore.instance;

  static String get uid =>
      FirebaseAuth.instance.currentUser!.uid;

  static Stream<AppUser> userStream() {
    return _firestore
        .collection("users")
        .doc(uid)
        .snapshots()
        .map(
          (e) => AppUser.fromMap(e.data()!),
    );
  }

  static Future<void> update(
      Map<String, dynamic> data,
      ) {
    return _firestore
        .collection("users")
        .doc(uid)
        .update(data);
  }
}