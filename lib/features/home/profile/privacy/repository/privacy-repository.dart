import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../features/models/app_user.dart';

class PrivacyRepository {
  PrivacyRepository._();

  static final _firestore = FirebaseFirestore.instance;

  static String get uid =>
      FirebaseAuth.instance.currentUser!.uid;

  static const _characters =
      'abcdefghijklmnopqrstuvwxyz0123456789';

  static Stream<AppUser> userStream() {
    return _firestore
        .collection('users')
        .doc(uid)
        .snapshots()
        .map(
          (doc) => AppUser.fromMap(doc.data()!),
    );
  }

  static Future<void> updateAnonymousMode(
      bool enabled,
      ) {
    return _firestore
        .collection('users')
        .doc(uid)
        .update({
      'isAnonymousMode': enabled,
    });
  }

  static String _generateUsername() {
    final random = Random();

    return List.generate(
      8,
          (_) => _characters[
      random.nextInt(_characters.length)],
    ).join();
  }

  static Future<void> generateAnonymousIdentity() async {
    final username = _generateUsername();

    final avatar =
    _generateAvatarIndex();

    await updateAnonymousIdentity(
      anonymousUsername: username,
      anonymousAvatarIndex: avatar,
      anonymousDisplayName: _generateDisplayName(),
    );
  }

  static Future<void> updateAnonymousIdentity({
    required String anonymousUsername,
    required int anonymousAvatarIndex,
    required String anonymousDisplayName,

  }) {
    return _firestore
        .collection('users')
        .doc(uid)
        .update({
      'anonymousUsername': anonymousUsername,
      'anonymousAvatarIndex': anonymousAvatarIndex,
    });
  }
  static int _generateAvatarIndex() {
    final random = Random();

    return random.nextInt(20) + 1;
  }

  static String _generateDisplayName() {
    final random = Random();

    return "Anonymous ${1000 + random.nextInt(9000)}";
  }

}