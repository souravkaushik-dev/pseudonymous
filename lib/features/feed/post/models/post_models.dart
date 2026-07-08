import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String id;
  final String uid;

  final bool isAnonymous;

  final String username;
  final String anonymousUsername;

  final String name;
  final String photoUrl;

  final String text;
  final String imageUrl;

  final int likeCount;
  final int commentCount;

  final DateTime createdAt;

  const PostModel({
    required this.id,
    required this.uid,
    required this.isAnonymous,
    required this.username,
    required this.anonymousUsername,
    required this.name,
    required this.photoUrl,
    required this.text,
    required this.imageUrl,
    required this.likeCount,
    required this.commentCount,
    required this.createdAt,
  });

  factory PostModel.fromMap(
      Map<String, dynamic> json,
      String id,
      ) {
    return PostModel(
      id: id,
      uid: json['uid'] ?? '',

      isAnonymous: json['isAnonymous'] ?? false,

      username: json['username'] ?? '',
      anonymousUsername:
      json['anonymousUsername'] ?? '',

      name: json['name'] ?? '',
      photoUrl: json['photoUrl'] ?? '',

      text: json['text'] ?? '',
      imageUrl: json['imageUrl'] ?? '',

      likeCount: json['likeCount'] ?? 0,
      commentCount: json['commentCount'] ?? 0,

      createdAt:
      (json['createdAt'] as Timestamp?)
          ?.toDate() ??
          DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,

      "isAnonymous": isAnonymous,

      "username": username,
      "anonymousUsername": anonymousUsername,

      "name": name,
      "photoUrl": photoUrl,

      "text": text,
      "imageUrl": imageUrl,

      "likeCount": likeCount,
      "commentCount": commentCount,

      "createdAt":
      FieldValue.serverTimestamp(),
    };
  }
}