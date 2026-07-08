import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../model/inbox_models.dart';

class InboxRepository {
  InboxRepository._();

  static final _db = FirebaseFirestore.instance;
  static final _auth = FirebaseAuth.instance;

  static String get uid => _auth.currentUser!.uid;

  static Stream<List<InboxMessage>> inbox() {
    return _db
        .collection("messages")
        .where("receiverUid", isEqualTo: uid)
        .orderBy("createdAt", descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
          .map(
            (e) => InboxMessage.fromMap(
          e.data(),
          e.id,
        ),
      )
          .toList(),
    );
  }

  static Future<void> sendMessage({
    required String receiverUid,
    required String text,
    bool anonymous = true,
  }) async {
    await _db.collection("messages").add({
      "senderUid": uid,
      "receiverUid": receiverUid,
      "text": text.trim(),
      "isAnonymous": anonymous,
      "isRead": false,
      "createdAt": FieldValue.serverTimestamp(),
    });
  }

  static Future<void> markAsRead(
      String messageId,
      ) {
    return _db
        .collection("messages")
        .doc(messageId)
        .update({
      "isRead": true,
    });
  }

  static Future<void> deleteMessage(
      String messageId,
      ) {
    return _db
        .collection("messages")
        .doc(messageId)
        .delete();
  }
  static Stream<List<InboxMessage>> receivedMessages() {
    return _db
        .collection("messages")
        .where("receiverUid", isEqualTo: uid)
        .orderBy("createdAt", descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
          .map(
            (doc) => InboxMessage.fromMap(
          doc.data(),
          doc.id,
        ),
      )
          .toList(),
    );
  }

  static Stream<List<InboxMessage>> sentMessages() {
    return _db
        .collection("messages")
        .where("senderUid", isEqualTo: uid)
        .orderBy("createdAt", descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
          .map(
            (doc) => InboxMessage.fromMap(
          doc.data(),
          doc.id,
        ),
      )
          .toList(),
    );
  }

  static Future<void> replyToMessage({
    required InboxMessage message,
    required String text,
  }) async {
    await _db.collection("messages").add({
      "senderUid": uid,
      "receiverUid": message.senderUid,

      "text": text.trim(),

      "isAnonymous": true,

      "isRead": false,

      "replyTo": message.id,

      "createdAt": FieldValue.serverTimestamp(),
    });
  }

}