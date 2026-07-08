import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../home/notification/model/notification_repository.dart';

class LikeRepository {
  LikeRepository._();

  static final _db = FirebaseFirestore.instance;
  static final _auth = FirebaseAuth.instance;

  static String get uid => _auth.currentUser!.uid;

  static Future<void> like({
    required String postId,
    required String receiverUid,
  }) async {
    final postRef = _db.collection("posts").doc(postId);

    await _db.runTransaction((transaction) async {
      final likeRef = postRef
          .collection("likes")
          .doc(uid);

      final likeDoc = await transaction.get(likeRef);

      // Already liked
      if (likeDoc.exists) return;

      transaction.set(likeRef, {
        "createdAt": FieldValue.serverTimestamp(),
      });

      transaction.update(postRef, {
        "likeCount": FieldValue.increment(1),
      });
    });

    await NotificationRepository.createLike(
      receiverUid: receiverUid,
      senderUid: uid,
      postId: postId,
    );
  }

  static Future<void> unlike(String postId) async {
    final postRef = _db.collection("posts").doc(postId);

    await _db.runTransaction((transaction) async {
      final likeRef = postRef
          .collection("likes")
          .doc(uid);

      final likeDoc = await transaction.get(likeRef);

      // Not liked
      if (!likeDoc.exists) return;

      transaction.delete(likeRef);

      transaction.update(postRef, {
        "likeCount": FieldValue.increment(-1),
      });
    });
  }

  /// Is Liked
  static Stream<bool> isLiked(
      String postId,
      ) {
    return _db
        .collection("posts")
        .doc(postId)
        .collection("likes")
        .doc(uid)
        .snapshots()
        .map((e) => e.exists);
  }
}