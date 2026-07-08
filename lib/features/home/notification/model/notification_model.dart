import 'package:cloud_firestore/cloud_firestore.dart';

enum NotificationType {
  like,
  follow,
  reply,
  message,
  comment,
  system,
}

class AppNotification {
  const AppNotification({
    required this.id,
    required this.receiverUid,
    required this.senderUid,
    required this.type,
    required this.postId,
    required this.conversationId,
    required this.isRead,
    required this.createdAt,
  });

  final String id;

  final String receiverUid;
  final String senderUid;

  final NotificationType type;

  final String postId;
  final String conversationId;

  final bool isRead;

  final DateTime createdAt;

  factory AppNotification.fromMap(
      Map<String, dynamic> json,
      String id,
      ) {
    return AppNotification(
      id: id,

      receiverUid: json["receiverUid"] ?? "",

      senderUid: json["senderUid"] ?? "",

      type: NotificationType.values.firstWhere(
            (e) => e.name == json["type"],
        orElse: () => NotificationType.system,
      ),

      postId: json["postId"] ?? "",

      conversationId:
      json["conversationId"] ?? "",

      isRead: json["isRead"] ?? false,

      createdAt:
      (json["createdAt"] as Timestamp?)
          ?.toDate() ??
          DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "receiverUid": receiverUid,

      "senderUid": senderUid,

      "type": type.name,

      "postId": postId,

      "conversationId": conversationId,

      "isRead": isRead,

      "createdAt":
      FieldValue.serverTimestamp(),
    };
  }
}