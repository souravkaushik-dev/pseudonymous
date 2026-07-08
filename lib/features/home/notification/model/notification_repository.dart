import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'notification_model.dart';

class NotificationRepository {
  NotificationRepository._();

  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static String get uid => _auth.currentUser!.uid;

  static CollectionReference<Map<String, dynamic>> get _collection =>
      _db.collection("notifications");

  /// Stream all notifications for current user
  static Stream<List<AppNotification>> notifications() {
    return _collection
        .where("receiverUid", isEqualTo: uid)
        .orderBy("createdAt", descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => AppNotification.fromMap(doc.data(), doc.id))
              .toList(),
        );
  }

  static Stream<int> unreadCount() {
    return _collection
        .where("receiverUid", isEqualTo: uid)
        .where("isRead", isEqualTo: false)
        .snapshots()
        .map((snapshot) => snapshot.docs.length);
  }

  /// Mark one notification as read
  static Future<void> markRead(String id) {
    return _collection.doc(id).update({"isRead": true});
  }

  static Future<void> markAllRead() async {
    final snapshot = await _collection
        .where("receiverUid", isEqualTo: uid)
        .where("isRead", isEqualTo: false)
        .get();

    if (snapshot.docs.isEmpty) return;

    final batch = _db.batch();

    for (final doc in snapshot.docs) {
      batch.update(doc.reference, {
        "isRead": true,
      });
    }

    await batch.commit();
  }

  static Future<void> deleteMany(
      Iterable<String> ids,
      ) async {
    final batch = _db.batch();

    for (final id in ids) {
      batch.delete(_collection.doc(id));
    }

    await batch.commit();
  }

  /// Delete notification
  static Future<void> delete(String id) {
    return _collection.doc(id).delete();
  }

  static Future<void> create({
    required String receiverUid,
    required String senderUid,
    required NotificationType type,
    String postId = "",
    String conversationId = "",
  }) async {
    if (receiverUid == senderUid) return;

    await _collection.add({
      "receiverUid": receiverUid,
      "senderUid": senderUid,

      "type": type.name,

      "postId": postId,

      "conversationId": conversationId,

      "isRead": false,

      "createdAt": FieldValue.serverTimestamp(),
    });
  }

  static Future<void> createLike({
    required String receiverUid,
    required String senderUid,
    required String postId,
  }) {
    return create(
      receiverUid: receiverUid,
      senderUid: senderUid,
      type: NotificationType.like,
      postId: postId,
    );
  }

  static Future<void> createFollow({
    required String receiverUid,
    required String senderUid,
  }) {
    return create(
      receiverUid: receiverUid,
      senderUid: senderUid,
      type: NotificationType.follow,
    );
  }

  static Future<void> createReply({
    required String receiverUid,
    required String senderUid,
    required String conversationId,
  }) {
    return create(
      receiverUid: receiverUid,
      senderUid: senderUid,
      type: NotificationType.reply,
      conversationId: conversationId,
    );
  }

  static Future<void> createMessage({
    required String receiverUid,
    required String senderUid,
    required String conversationId,
  }) {
    return create(
      receiverUid: receiverUid,
      senderUid: senderUid,
      type: NotificationType.message,
      conversationId: conversationId,
    );
  }
}
