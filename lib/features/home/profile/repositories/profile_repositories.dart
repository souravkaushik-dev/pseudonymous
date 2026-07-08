import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../features/models/app_user.dart';

class ProfileRepository {
  ProfileRepository._();

  static final _db = FirebaseFirestore.instance;

  static Future<AppUser> currentUser() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    final doc = await _db
        .collection('users')
        .doc(uid)
        .get();

    return AppUser.fromMap(doc.data()!);
  }

  static Stream<AppUser> userStream() {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    return _db
        .collection('users')
        .doc(uid)
        .snapshots()
        .map(
          (e) => AppUser.fromMap(e.data()!),
    );
  }
}