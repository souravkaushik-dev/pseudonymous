import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../home/profile/features/models/app_user.dart';

class SearchRepository {
  SearchRepository._();

  static final FirebaseFirestore _db =
      FirebaseFirestore.instance;

  static Future<List<AppUser>> searchUsers(
      String query,
      ) async {
    final text = query.trim().toLowerCase();

    if (text.isEmpty) return [];

    final usernameSnapshot = await _db
        .collection("users")
        .orderBy("username")
        .startAt([text])
        .endAt(["$text\uf8ff"])
        .get();

    final users = usernameSnapshot.docs
        .map((e) => AppUser.fromMap(e.data()))
        .toList();

    if (users.isNotEmpty) {
      return users;
    }

    final nameSnapshot = await _db
        .collection("users")
        .orderBy("name")
        .startAt([query])
        .endAt(["$query\uf8ff"])
        .get();

    return nameSnapshot.docs
        .map((e) => AppUser.fromMap(e.data()))
        .toList();
  }
}