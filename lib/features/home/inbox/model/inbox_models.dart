import 'package:cloud_firestore/cloud_firestore.dart';

class InboxMessage {
  final String id;
  final String text;
  final String senderUid;
  final String receiverUid;
  final bool isAnonymous;
  final bool isRead;
  final DateTime createdAt;

  const InboxMessage({
    required this.id,
    required this.text,
    required this.senderUid,
    required this.receiverUid,
    required this.isAnonymous,
    required this.isRead,
    required this.createdAt,
  });

  factory InboxMessage.fromMap(
      Map<String, dynamic> json,
      String id,
      ) {
    return InboxMessage(
      id: id,
      text: json["text"] ?? "",
      senderUid: json["senderUid"] ?? "",
      receiverUid: json["receiverUid"] ?? "",
      isAnonymous: json["isAnonymous"] ?? true,
      isRead: json["isRead"] ?? false,
      createdAt:
      (json["createdAt"] as Timestamp?)?.toDate() ??
          DateTime.now(),
    );
  }
}