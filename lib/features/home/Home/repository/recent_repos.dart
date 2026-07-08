import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../feed/post/models/post_models.dart';

class RecentPostsRepository {
  RecentPostsRepository._();

  static Stream<List<PostModel>> latestPosts() {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    return FirebaseFirestore.instance
        .collection("posts")
        .where("uid", isEqualTo: uid)
        .orderBy("createdAt", descending: true)
        .limit(5)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
          .map(
            (doc) => PostModel.fromMap(
          doc.data(),
          doc.id,
        ),
      )
          .toList(),
    );
  }
}