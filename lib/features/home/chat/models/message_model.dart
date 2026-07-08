import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String id;

  final String senderUid;

  final String text;

  final DateTime createdAt;

  const MessageModel({
    required this.id,
    required this.senderUid,
    required this.text,
    required this.createdAt,
  });

  factory MessageModel.fromMap(
      Map<String, dynamic> json,
      String id,
      ) {
    return MessageModel(
      id: id,
      senderUid: json["senderUid"] ?? "",
      text: json["text"] ?? "",
      createdAt:
      (json["createdAt"] as Timestamp?)
          ?.toDate() ??
          DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "senderUid": senderUid,
      "text": text,
      "createdAt":
      FieldValue.serverTimestamp(),
    };
  }
}