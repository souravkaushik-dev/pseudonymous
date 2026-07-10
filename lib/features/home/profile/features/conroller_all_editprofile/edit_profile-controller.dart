import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/app_user.dart';

class EditProfileController extends ChangeNotifier {
  EditProfileController({
    required AppUser user,
  }) : _user = user {
    nameController.text = user.name;
    usernameController.text = user.username;
    bioController.text = user.bio;

    isAnonymous = user.isAnonymousMode;

    anonymousName = user.anonymousName;
    anonymousUsername = user.anonymousUsername;
    anonymousAvatar = user.anonymousAvatar;

    selectedAvatar = user.avatar;

    usernameController.addListener(_usernameListener);
  }

  final AppUser _user;

  final FirebaseFirestore firestore =
      FirebaseFirestore.instance;

  final FirebaseAuth auth =
      FirebaseAuth.instance;

  final nameController =
  TextEditingController();

  final usernameController =
  TextEditingController();

  final bioController =
  TextEditingController();

  bool saving = false;

  bool checkingUsername = false;

  bool usernameAvailable = true;

  bool isAnonymous = false;

  late String selectedAvatar;

  Timer? _debounce;

  String anonymousName = "";

  String anonymousUsername = "";

  String anonymousAvatar = "";

  /// Select avatar from built-in avatars
  void selectAvatar(String avatar) {
    selectedAvatar = avatar;
    notifyListeners();
  }

  void _usernameListener() {
    _debounce?.cancel();

    final value = usernameController.text
        .trim()
        .toLowerCase();

    if (value == _user.username) {
      usernameAvailable = true;
      checkingUsername = false;
      notifyListeners();
      return;
    }

    checkingUsername = true;
    notifyListeners();

    _debounce = Timer(
      const Duration(milliseconds: 500),
      checkUsername,
    );
  }

  Future<void> checkUsername() async {
    final username = usernameController.text
        .trim()
        .toLowerCase();

    if (username.isEmpty) {
      checkingUsername = false;
      usernameAvailable = false;
      notifyListeners();
      return;
    }

    try {
      final query = await firestore
          .collection("users")
          .where(
        "username",
        isEqualTo: username,
      )
          .limit(1)
          .get();

      if (query.docs.isEmpty) {
        usernameAvailable = true;
      } else {
        usernameAvailable =
            query.docs.first.id ==
                auth.currentUser!.uid;
      }
    } catch (_) {
      usernameAvailable = false;
    }

    checkingUsername = false;
    notifyListeners();
  }

  void toggleAnonymous(bool value) {
    isAnonymous = value;

    if (value &&
        anonymousName.isEmpty) {
      generateAnonymousIdentity();
    }

    notifyListeners();
  }

  void generateAnonymousIdentity() {
    const adjectives = [
      "Ghost",
      "Hidden",
      "Silent",
      "Shadow",
      "Nova",
      "Mystic",
      "Secret",
      "Dark",
      "Frozen",
      "Echo",
      "Midnight",
      "Unknown",
      "Broken",
      "Golden",
      "Crimson",
      "Cyber",
    ];

    const nouns = [
      "Wolf",
      "Fox",
      "Falcon",
      "Dragon",
      "Owl",
      "Raven",
      "Panther",
      "Tiger",
      "Lion",
      "Phoenix",
      "Hunter",
      "Spirit",
      "Storm",
      "Ghost",
      "Eagle",
      "Viper",
    ];

    final random = Random();

    anonymousName =
    "${adjectives[random.nextInt(adjectives.length)]} "
        "${nouns[random.nextInt(nouns.length)]}";

    anonymousUsername =
        anonymousName
            .replaceAll(" ", "_")
            .toLowerCase() +
            "_${100 + random.nextInt(900)}";

    anonymousAvatar =
    "avatar_${(1 + random.nextInt(24)).toString().padLeft(2, "0")}";

    notifyListeners();
  }

  Future<bool> save() async {
    if (saving) return false;

    if (!usernameAvailable) return false;

    saving = true;
    notifyListeners();

    try {
      await firestore
          .collection("users")
          .doc(auth.currentUser!.uid)
          .update({
        "name": nameController.text
            .trim(),

        "username":
        usernameController.text
            .trim()
            .toLowerCase(),

        "bio":
        bioController.text.trim(),

        "avatar": selectedAvatar,

        "isAnonymousMode":
        isAnonymous,

        "anonymousName":
        anonymousName,

        "anonymousUsername":
        anonymousUsername,

        "anonymousAvatar":
        anonymousAvatar,

        "updatedAt":
        FieldValue.serverTimestamp(),
      });

      saving = false;
      notifyListeners();

      return true;
    } catch (e) {
      debugPrint(
        "Profile Update Error: $e",
      );

      saving = false;
      notifyListeners();

      return false;
    }
  }

  @override
  void dispose() {
    _debounce?.cancel();

    nameController.dispose();
    usernameController.dispose();
    bioController.dispose();

    super.dispose();
  }
}