import 'package:cloud_firestore/cloud_firestore.dart';

class ConversationModel {
  final String id;

  final List<String> participants;

  final String senderUid;
  final String receiverUid;

  final bool isAnonymous;

  final String senderName;
  final String senderUsername;
  final String senderPhoto;

  final String receiverName;
  final String receiverUsername;
  final String receiverPhoto;

  final String lastMessage;

  final DateTime lastMessageAt;

  const ConversationModel({
    required this.id,
    required this.participants,
    required this.senderUid,
    required this.receiverUid,
    required this.isAnonymous,
    required this.senderName,
    required this.senderUsername,
    required this.senderPhoto,
    required this.receiverName,
    required this.receiverUsername,
    required this.receiverPhoto,
    required this.lastMessage,
    required this.lastMessageAt,
  });

  factory ConversationModel.fromMap(
      Map<String, dynamic> json,
      String id,
      ) {
    return ConversationModel(
      id: id,
      participants: List<String>.from(
        json["participants"] ?? [],
      ),

      senderUid: json["senderUid"] ?? "",
      receiverUid: json["receiverUid"] ?? "",

      isAnonymous: json["isAnonymous"] ?? true,

      senderName: json["senderName"] ?? "",
      senderUsername: json["senderUsername"] ?? "",
      senderPhoto: json["senderPhoto"] ?? "",

      receiverName: json["receiverName"] ?? "",
      receiverUsername: json["receiverUsername"] ?? "",
      receiverPhoto: json["receiverPhoto"] ?? "",

      lastMessage: json["lastMessage"] ?? "",

      lastMessageAt:
      (json["lastMessageAt"] as Timestamp?)
          ?.toDate() ??
          DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "participants": participants,

      "senderUid": senderUid,
      "receiverUid": receiverUid,

      "isAnonymous": isAnonymous,

      "senderName": senderName,
      "senderUsername": senderUsername,
      "senderPhoto": senderPhoto,

      "receiverName": receiverName,
      "receiverUsername": receiverUsername,
      "receiverPhoto": receiverPhoto,

      "lastMessage": lastMessage,

      "lastMessageAt": FieldValue.serverTimestamp(),
    };
  }
}