import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../home/profile/repositories/profile_repositories.dart';
import '../models/comment_model.dart';

class CommentRepository {
  CommentRepository._();

  static final _db = FirebaseFirestore.instance;

  static Future<void> addComment({
    required String postId,
    required String text,
  }) async {
    final user = await ProfileRepository.currentUser();

    final commentRef = _db
        .collection("posts")
        .doc(postId)
        .collection("comments")
        .doc();

    final batch = _db.batch();

    batch.set(commentRef, {
      "uid": user.uid,

      "username": user.isAnonymousMode
          ? user.anonymousUsername
          : user.username,

      "name": user.isAnonymousMode
          ? user.anonymousName
          : user.name,

      "avatar": user.isAnonymousMode
          ? user.anonymousAvatar
          : user.avatar,

      "isAnonymous": user.isAnonymousMode,

      "text": text.trim(),

      "createdAt": FieldValue.serverTimestamp(),
    });

    batch.update(
      _db.collection("posts").doc(postId),
      {
        "commentCount": FieldValue.increment(1),
      },
    );

    await batch.commit();
  }

  static Future<void> deleteComment({
    required String postId,
    required String commentId,
  }) async {
    final batch = _db.batch();

    batch.delete(
      _db
          .collection("posts")
          .doc(postId)
          .collection("comments")
          .doc(commentId),
    );

    batch.update(
      _db.collection("posts").doc(postId),
      {
        "commentCount": FieldValue.increment(-1),
      },
    );

    await batch.commit();
  }

  static Stream<List<CommentModel>> comments(
      String postId,
      ) {
    return _db
        .collection("posts")
        .doc(postId)
        .collection("comments")
        .orderBy(
      "createdAt",
      descending: false,
    )
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
          .map(
            (e) => CommentModel.fromMap(
          e.data(),
          e.id,
        ),
      )
          .toList(),
    );
  }
}