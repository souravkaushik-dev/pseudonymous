import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'edit_profile.dart';

class EditProfileController extends ChangeNotifier {
  final nameController = TextEditingController();
  final usernameController = TextEditingController();
  final bioController = TextEditingController();

  bool loading = true;
  bool saving = false;

  bool usernameAvailable = true;

  String photoUrl = "";

  Future<void> load() async {
    loading = true;
    notifyListeners();

    final data = await EditProfileRepository.profile();

    nameController.text = data["name"] ?? "";
    usernameController.text = data["username"] ?? "";
    bioController.text = data["bio"] ?? "";
    photoUrl = data["photoUrl"] ?? "";

    usernameController.addListener(_onUsernameChanged);

    loading = false;
    notifyListeners();
  }

  Future<void> _onUsernameChanged() async {
    final username =
    usernameController.text.trim().toLowerCase();

    if (username.isEmpty) {
      usernameAvailable = false;
      notifyListeners();
      return;
    }

    usernameAvailable =
    await EditProfileRepository.usernameAvailable(
      username,
    );

    notifyListeners();
  }

  bool get canSave {
    return !saving &&
        nameController.text.trim().isNotEmpty &&
        usernameController.text.trim().length >= 3 &&
        bioController.text.length <= 160 &&
        usernameAvailable;
  }

  Future<void> save() async {
    if (!canSave) return;

    saving = true;
    notifyListeners();

    await EditProfileRepository.save(
      name: nameController.text.trim(),
      username:
      usernameController.text.trim().toLowerCase(),
      bio: bioController.text.trim(),
      photoUrl: photoUrl,
    );

    saving = false;
    notifyListeners();
  }

  Future<void> updatePhoto(String url) async {
    photoUrl = url;
    notifyListeners();
  }

  Future<void> pickPhoto() async {
    final picker = ImagePicker();

    final file = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (file == null) return;

    loading = true;
    notifyListeners();

    final url =
    await EditProfileRepository.uploadPhoto(
      File(file.path),
    );

    photoUrl = url;

    loading = false;
    notifyListeners();
  }

  @override
  void dispose() {
    usernameController.removeListener(
      _onUsernameChanged,
    );

    nameController.dispose();
    usernameController.dispose();
    bioController.dispose();

    super.dispose();
  }
}