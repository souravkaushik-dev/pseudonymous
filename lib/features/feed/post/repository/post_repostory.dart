import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../home/profile/features/models/app_user.dart';
import '../../../home/profile/repositories/profile_repositories.dart';
import '../models/post_models.dart';

class PostRepository {
  PostRepository._();

  static final FirebaseFirestore _db =
      FirebaseFirestore.instance;

  static final FirebaseAuth _auth =
      FirebaseAuth.instance;


  static Future<void> createPost({
    required String text,
    String imageUrl = "",
  }) async {
    final AppUser user =
    await ProfileRepository.currentUser();

    final doc = _db.collection("posts").doc();

    final post = PostModel(
      id: doc.id,
      uid: _auth.currentUser!.uid,

      isAnonymous: user.isAnonymousMode,

      username: user.username,
      anonymousUsername: user.anonymousUsername,

      name: user.name,
      photoUrl: user.photoUrl,

      text: text.trim(),
      imageUrl: imageUrl,

      likeCount: 0,
      commentCount: 0,

      createdAt: DateTime.now(),
    );

    await doc.set(post.toMap());
  }

  /// Feed
  static Stream<List<PostModel>> feed() {
    return _db
        .collection("posts")
        .orderBy(
      "createdAt",
      descending: true,
    )
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

  static Future<void> deletePost(PostModel post) async {
    final batch = _db.batch();

    final postRef = _db.collection("posts").doc(post.id);

    // Delete likes
    final likes = await postRef.collection("likes").get();

    for (final doc in likes.docs) {
      batch.delete(doc.reference);
    }

    // Delete notifications related to this post
    final notifications = await _db
        .collection("notifications")
        .where("postId", isEqualTo: post.id)
        .get();

    for (final doc in notifications.docs) {
      batch.delete(doc.reference);
    }

    // Delete post document
    batch.delete(postRef);

    await batch.commit();

    // Delete image from Firebase Storage
    if (post.imageUrl.isNotEmpty) {
      try {
        await FirebaseStorage.instance
            .refFromURL(post.imageUrl)
            .delete();
      } catch (_) {}
    }
  }

  static Stream<int> postsCount(String uid) {
    return _db
        .collection("posts")
        .where("uid", isEqualTo: uid)
        .snapshots()
        .map((snapshot) => snapshot.docs.length);
  }


}

class UserRepository {
  static Stream<AppUser> user(String uid) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .snapshots()
        .map(
          (doc) => AppUser.fromMap(doc.data()!),
    );
  }
}