import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../home/notification/model/notification_repository.dart';
import '../../../home/profile/features/models/app_user.dart';
import 'follow_type.dart';

class FollowRepository {
  FollowRepository._();

  static final FirebaseFirestore _db =
      FirebaseFirestore.instance;

  static final FirebaseAuth _auth =
      FirebaseAuth.instance;

  static String get currentUid =>
      _auth.currentUser!.uid;

  /// Check if current user follows another user
  static Stream<bool> isFollowing(String userUid) {
    return _db
        .collection("followers")
        .doc(userUid)
        .collection("userFollowers")
        .doc(currentUid)
        .snapshots()
        .map((doc) => doc.exists);
  }

  static Future<void> follow(String userUid) async {
    final followerRef = _db
        .collection("followers")
        .doc(userUid)
        .collection("userFollowers")
        .doc(currentUid);

    // Already following? Do nothing.
    if ((await followerRef.get()).exists) {
      return;
    }

    final batch = _db.batch();

    batch.set(followerRef, {
      "createdAt": FieldValue.serverTimestamp(),
    });

    batch.set(
      _db
          .collection("following")
          .doc(currentUid)
          .collection("userFollowing")
          .doc(userUid),
      {
        "createdAt": FieldValue.serverTimestamp(),
      },
    );

    batch.update(
      _db.collection("users").doc(userUid),
      {
        "followersCount": FieldValue.increment(1),
      },
    );

    batch.update(
      _db.collection("users").doc(currentUid),
      {
        "followingCount": FieldValue.increment(1),
      },
    );

    await batch.commit();
    print("✅ Batch committed");

    await NotificationRepository.createFollow(
      receiverUid: userUid,
      senderUid: currentUid,
    );

    print("✅ Follow notification created");
  }
  /// Unfollow user
  static Future<void> unfollow(String userUid) async {
    final followerRef = _db
        .collection("followers")
        .doc(userUid)
        .collection("userFollowers")
        .doc(currentUid);

    // Not following? Do nothing.
    if (!(await followerRef.get()).exists) {
      return;
    }

    final batch = _db.batch();

    batch.delete(followerRef);

    batch.delete(
      _db
          .collection("following")
          .doc(currentUid)
          .collection("userFollowing")
          .doc(userUid),
    );

    batch.update(
      _db.collection("users").doc(userUid),
      {
        "followersCount": FieldValue.increment(-1),
      },
    );

    batch.update(
      _db.collection("users").doc(currentUid),
      {
        "followingCount": FieldValue.increment(-1),
      },
    );

    await batch.commit();

  }

  /// Toggle follow state
  static Future<void> toggleFollow(String userUid) async {
    final doc = await _db
        .collection("followers")
        .doc(userUid)
        .collection("userFollowers")
        .doc(currentUid)
        .get();

    if (doc.exists) {
      await unfollow(userUid);
    } else {
      await follow(userUid);
    }
  }
  static Stream<List<String>> followers(String userUid) {
    return _db
        .collection("followers")
        .doc(userUid)
        .collection("userFollowers")
        .snapshots()
        .map(
          (snapshot) =>
          snapshot.docs.map((e) => e.id).toList(),
    );
  }
  static Stream<List<String>> following(String userUid) {
    return _db
        .collection("following")
        .doc(userUid)
        .collection("userFollowing")
        .snapshots()
        .map(
          (snapshot) =>
          snapshot.docs.map((e) => e.id).toList(),
    );
  }
  static Stream<AppUser> user(String uid) {
    return _db
        .collection("users")
        .doc(uid)
        .snapshots()
        .map(
          (doc) => AppUser.fromMap(
        doc.data()!,
      ),
    );
  }
  static Stream<List<String>> ids({
    required String uid,
    required FollowType type,
  }) {
    final collection =
    type == FollowType.followers
        ? "followers"
        : "following";

    final subCollection =
    type == FollowType.followers
        ? "userFollowers"
        : "userFollowing";

    return _db
        .collection(collection)
        .doc(uid)
        .collection(subCollection)
        .snapshots()
        .map(
          (snapshot) =>
          snapshot.docs.map((e) => e.id).toList(),
    );
  }
  static Stream<int> followersCount(String uid) {
    return _db
        .collection("followers")
        .doc(uid)
        .collection("userFollowers")
        .snapshots()
        .map((snapshot) => snapshot.docs.length);
  }

  static Stream<int> followingCount(String uid) {
    return _db
        .collection("following")
        .doc(uid)
        .collection("userFollowing")
        .snapshots()
        .map((snapshot) => snapshot.docs.length);
  }
}