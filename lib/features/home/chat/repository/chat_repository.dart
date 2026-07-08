import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../notification/model/notification_repository.dart' show NotificationRepository;
import '../models/conversation_model.dart';
import '../models/message_model.dart';

class ChatRepository {
  ChatRepository._();

  static final _db = FirebaseFirestore.instance;
  static final _auth = FirebaseAuth.instance;

  static String get uid => _auth.currentUser!.uid;

  /// Create or return an existing conversation
  /// Create or return an existing conversation
  static Future<String> createConversation({
    required String otherUserUid,
  }) async {
    final ids = [uid, otherUserUid]..sort();

    final conversationId = ids.join("_");

    final doc = _db.collection("conversations").doc(conversationId);

    if (!(await doc.get()).exists) {
      final currentUserDoc =
      await _db.collection("users").doc(uid).get();

      final otherUserDoc =
      await _db.collection("users").doc(otherUserUid).get();

      final currentUser = currentUserDoc.data()!;
      final otherUser = otherUserDoc.data()!;

      await doc.set({
        "participants": ids,

        "senderUid": uid,
        "receiverUid": otherUserUid,

        "isAnonymous": true,

        "senderName": currentUser["name"] ?? "",
        "senderUsername": currentUser["username"] ?? "",
        "senderPhoto": currentUser["photoUrl"] ?? "",

        "receiverName": otherUser["name"] ?? "",
        "receiverUsername": otherUser["username"] ?? "",
        "receiverPhoto": otherUser["photoUrl"] ?? "",

        "lastMessage": "",
        "lastMessageAt": FieldValue.serverTimestamp(),
      });
    }

    return conversationId;
  }

  /// Stream messages for one conversation
  static Stream<List<MessageModel>> messages(
      String conversationId,
      ) {
    return _db
        .collection("conversations")
        .doc(conversationId)
        .collection("messages")
        .orderBy("createdAt")
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
          .map(
            (e) => MessageModel.fromMap(
          e.data(),
          e.id,
        ),
      )
          .toList(),
    );
  }

  static Future<void> sendMessage({
    required String conversationId,
    required String receiverUid,
    required String text,
  }) async {
    final messageRef = _db
        .collection("conversations")
        .doc(conversationId)
        .collection("messages")
        .doc();

    await messageRef.set({
      "senderUid": uid,
      "text": text.trim(),
      "createdAt": FieldValue.serverTimestamp(),
    });

    await _db
        .collection("conversations")
        .doc(conversationId)
        .update({
      "lastMessage": text.trim(),
      "lastMessageAt": FieldValue.serverTimestamp(),
    });

    await NotificationRepository.createMessage(
      receiverUid: receiverUid,
      senderUid: uid,
      conversationId: conversationId,
    );
  }

  static Future<void> deleteConversations(
      Iterable<String> conversationIds,
      ) async {
    final batch = _db.batch();

    for (final id in conversationIds) {
      batch.delete(
        _db.collection("conversations").doc(id),
      );
    }

    await batch.commit();
  }

  static Stream<List<ConversationModel>> conversations() {
    return _db
        .collection("conversations")
        .where(
      "participants",
      arrayContains: uid,
    )
        .orderBy(
      "lastMessageAt",
      descending: true,
    )
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
          .map(
            (e) => ConversationModel.fromMap(
          e.data(),
          e.id,
        ),
      )
          .toList(),
    );
  }
}