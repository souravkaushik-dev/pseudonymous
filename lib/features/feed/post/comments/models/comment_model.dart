import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {
  final String id;
  final String uid;
  final String username;
  final String name;
  final String photoUrl;
  final String text;
  final DateTime createdAt;

  const CommentModel({
    required this.id,
    required this.uid,
    required this.username,
    required this.name,
    required this.photoUrl,
    required this.text,
    required this.createdAt,
  });

  factory CommentModel.fromMap(
      Map<String, dynamic> json,
      String id,
      ) {
    return CommentModel(
      id: id,
      uid: json["uid"] ?? "",
      username: json["username"] ?? "",
      name: json["name"] ?? "",
      photoUrl: json["photoUrl"] ?? "",
      text: json["text"] ?? "",
      createdAt:
      (json["createdAt"] as Timestamp?)?.toDate() ??
          DateTime.now(),
    );
  }
}