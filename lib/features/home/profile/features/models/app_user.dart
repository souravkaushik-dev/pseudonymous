class AppUser {
  final String uid;
  final String name;
  final String username;
  final String email;

  /// Built-in avatar asset
  final String avatar;

  final String bio;
  final int followersCount;
  final int followingCount;

  /// Anonymous Mode
  final bool isAnonymousMode;
  final String anonymousName;
  final String anonymousUsername;
  final String anonymousAvatar;

  final String website;
  final String location;

  const AppUser({
    required this.uid,
    required this.name,
    required this.username,
    required this.email,
    required this.avatar,
    required this.bio,
    required this.followersCount,
    required this.followingCount,
    required this.isAnonymousMode,
    required this.anonymousName,
    required this.anonymousUsername,
    required this.anonymousAvatar,
    required this.website,
    required this.location,
  });

  factory AppUser.fromMap(Map<String, dynamic> json) {
    return AppUser(
      uid: json["uid"] ?? "",
      name: json["name"] ?? "",
      username: json["username"] ?? "",
      email: json["email"] ?? "",

      avatar: json["avatar"] ?? "avatar_01",

      bio: json["bio"] ?? "",

      followersCount: json["followersCount"] ?? 0,
      followingCount: json["followingCount"] ?? 0,

      isAnonymousMode: json["isAnonymousMode"] ?? false,
      anonymousName: json["anonymousName"] ?? "",
      anonymousUsername: json["anonymousUsername"] ?? "",
      anonymousAvatar: json["anonymousAvatar"] ?? "",

      website: json["website"] ?? "",
      location: json["location"] ?? "",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "name": name,
      "username": username,
      "email": email,

      "avatar": avatar,

      "bio": bio,

      "followersCount": followersCount,
      "followingCount": followingCount,

      "isAnonymousMode": isAnonymousMode,
      "anonymousName": anonymousName,
      "anonymousUsername": anonymousUsername,
      "anonymousAvatar": anonymousAvatar,

      "website": website,
      "location": location,
    };
  }

  AppUser copyWith({
    String? uid,
    String? name,
    String? username,
    String? email,
    String? avatar,
    String? bio,
    int? followersCount,
    int? followingCount,
    bool? isAnonymousMode,
    String? anonymousName,
    String? anonymousUsername,
    String? anonymousAvatar,
    String? website,
    String? location,
  }) {
    return AppUser(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      username: username ?? this.username,
      email: email ?? this.email,

      avatar: avatar ?? this.avatar,

      bio: bio ?? this.bio,

      followersCount:
      followersCount ?? this.followersCount,

      followingCount:
      followingCount ?? this.followingCount,

      isAnonymousMode:
      isAnonymousMode ?? this.isAnonymousMode,

      anonymousName:
      anonymousName ?? this.anonymousName,

      anonymousUsername:
      anonymousUsername ?? this.anonymousUsername,

      anonymousAvatar:
      anonymousAvatar ?? this.anonymousAvatar,

      website: website ?? this.website,
      location: location ?? this.location,
    );
  }
}