import 'package:flutter/material.dart';

import 'edit_profile.dart';

class EditProfileController extends ChangeNotifier {
  final nameController = TextEditingController();
  final usernameController = TextEditingController();
  final bioController = TextEditingController();

  bool loading = true;
  bool saving = false;

  bool usernameAvailable = true;

  /// Selected avatar
  String selectedAvatar = "avatar_1";

  Future<void> load() async {
    loading = true;
    notifyListeners();

    final data = await EditProfileRepository.profile();

    nameController.text = data["name"] ?? "";
    usernameController.text = data["username"] ?? "";
    bioController.text = data["bio"] ?? "";

    selectedAvatar = data["avatar"] ?? "avatar_1";

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

  void selectAvatar(String avatar) {
    selectedAvatar = avatar;
    notifyListeners();
  }

  Future<void> save() async {
    if (!canSave) return;

    saving = true;
    notifyListeners();

    await EditProfileRepository.save(
      name: nameController.text.trim(),
      username: usernameController.text
          .trim()
          .toLowerCase(),
      bio: bioController.text.trim(),
      avatar: selectedAvatar,
    );

    saving = false;
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