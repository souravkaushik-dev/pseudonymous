import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hi_pseudonymous/features/home/profile/repositories/profileheader-reps.dart';


class ProfileStatsRepository {
  ProfileStatsRepository._();

  static Stream<ProfileStats> stats() {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    return FirebaseFirestore.instance
        .collection("posts")
        .where("uid", isEqualTo: uid)
        .snapshots()
        .map((snapshot) {
      int likes = 0;
      int replies = 0;

      for (final doc in snapshot.docs) {
        likes += (doc.data()["likeCount"] ?? 0) as int;
        replies += (doc.data()["commentCount"] ?? 0) as int;
      }

      return ProfileStats(
        posts: snapshot.docs.length,
        likes: likes,
        replies: replies,
      );
    });
  }
}