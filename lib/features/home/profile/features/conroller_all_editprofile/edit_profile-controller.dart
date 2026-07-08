import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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

usernameController.addListener(_usernameListener);
}

final AppUser _user;

final FirebaseFirestore firestore =
FirebaseFirestore.instance;

final FirebaseAuth auth =
FirebaseAuth.instance;

final FirebaseStorage storage =
FirebaseStorage.instance;

final ImagePicker picker = ImagePicker();

final nameController = TextEditingController();

final usernameController =
TextEditingController();

final bioController = TextEditingController();

File? selectedImage;

bool saving = false;

bool checkingUsername = false;

bool usernameAvailable = true;

bool isAnonymous = false;

Timer? _debounce;

String anonymousName = "";

String anonymousUsername = "";

String anonymousAvatar = "";

void _usernameListener() {
_debounce?.cancel();

final value =
usernameController.text.trim().toLowerCase();

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
final username =
usernameController.text.trim().toLowerCase();

if (username.isEmpty) {
checkingUsername = false;
usernameAvailable = false;
notifyListeners();
return;
}

try {
final query = await firestore
.collection("users")
.where("username", isEqualTo: username)
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

Future<void> pickImage() async {
final image = await picker.pickImage(
source: ImageSource.gallery,
imageQuality: 85,
);

if (image == null) return;

selectedImage = File(image.path);

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
"Invisible",
"Golden",
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
"avatar_${1 + random.nextInt(20)}";

notifyListeners();
}
Future<String?> _uploadAvatar() async {
  if (selectedImage == null) {
    return _user.photoUrl;
  }

  try {
    final ref = storage
        .ref()
        .child("profile_photos")
        .child("${auth.currentUser!.uid}.jpg");

    final task = await ref.putFile(selectedImage!);

    if (task.state == TaskState.success) {
      return await ref.getDownloadURL();
    }

    return _user.photoUrl;
  } catch (e) {
    debugPrint("Avatar Upload Error: $e");
    return _user.photoUrl;
  }
}

Future<bool> save() async {
  if (saving) return false;

  if (!usernameAvailable) return false;

  saving = true;
  notifyListeners();

  try {
    final photoUrl = await _uploadAvatar();

    await firestore
        .collection("users")
        .doc(auth.currentUser!.uid)
        .update({
      "name": nameController.text.trim(),
      "username":
      usernameController.text.trim().toLowerCase(),
      "bio": bioController.text.trim(),
      "photoUrl": photoUrl,

      "isAnonymousMode": isAnonymous,
      "anonymousName": anonymousName,
      "anonymousUsername": anonymousUsername,
      "anonymousAvatar": anonymousAvatar,

      "updatedAt": FieldValue.serverTimestamp(),
    });

    saving = false;
    notifyListeners();

    return true;
  } catch (e) {
    debugPrint("Profile Update Error: $e");

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