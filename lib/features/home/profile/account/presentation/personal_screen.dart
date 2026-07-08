import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:image_picker/image_picker.dart';
import '../../features/models/app_user.dart';
import '../repository/personal-repository.dart';
import '../widgets/avatar_section.dart';
import '../widgets/info_section.dart';
import '../widgets/save_button.dart';

class PersonalInformationScreen extends StatefulWidget {
  const PersonalInformationScreen({
    super.key,
  });

  @override
  State<PersonalInformationScreen> createState() =>
      _PersonalInformationScreenState();
}

class _PersonalInformationScreenState
    extends State<PersonalInformationScreen> {

bool uploadingPhoto = false;

final ImagePicker _picker = ImagePicker();

Future<void> _pickProfilePhoto() async {
try {
final image = await _picker.pickImage(
source: ImageSource.gallery,
imageQuality: 85,
);

if (image == null) return;

setState(() {
uploadingPhoto = true;
});

final file = File(image.path);

final ref = FirebaseStorage.instance
.ref()
.child("profile_photos")
.child(
"${PersonalInformationRepository.uid}.jpg",
);

await ref.putFile(file);

final url = await ref.getDownloadURL();

await PersonalInformationRepository.update({
"photoUrl": url,
});

if (!mounted) return;

ScaffoldMessenger.of(context).showSnackBar(
const SnackBar(
behavior: SnackBarBehavior.floating,
content: Text(
"Profile photo updated successfully.",
),
),
);
} catch (e) {
if (!mounted) return;

ScaffoldMessenger.of(context).showSnackBar(
SnackBar(
behavior: SnackBarBehavior.floating,
content: Text(
e.toString(),
),
),
);
} finally {
if (mounted) {
setState(() {
uploadingPhoto = false;
});
}
}
}

@override
Widget build(BuildContext context) {
final theme = Theme.of(context);

return Scaffold(
backgroundColor: theme.scaffoldBackgroundColor,
appBar: AppBar(
centerTitle: true,
elevation: 0,
title: const Text(
"Personal Information",
),
),
body: StreamBuilder<AppUser>(
stream: PersonalInformationRepository.userStream(),
builder: (context, snapshot) {
if (snapshot.connectionState ==
ConnectionState.waiting) {
return const Center(
child: CircularProgressIndicator(),
);
}

if (snapshot.hasError) {
return Center(
child: Padding(
padding: EdgeInsets.all(24.w),
child: Text(
"Something went wrong.\nPlease try again.",
textAlign: TextAlign.center,
style: theme.textTheme.bodyLarge,
),
),
);
}

if (!snapshot.hasData) {
return Center(
child: Padding(
padding: EdgeInsets.all(24.w),
child: Text(
"Unable to load your profile.",
style: theme.textTheme.bodyLarge,
),
),
);
}

final user = snapshot.data!;

return SafeArea(
child: RefreshIndicator(
onRefresh: () async {
await Future.delayed(
const Duration(milliseconds: 500),
);
},
child: ListView(
physics:
const BouncingScrollPhysics(),
padding: EdgeInsets.fromLTRB(
20.w,
20.h,
20.w,
32.h,
),
children: [

AvatarSection(
photoUrl: user.photoUrl,
loading: uploadingPhoto,
onTap: _pickProfilePhoto,
),

SizedBox(height: 32.h),

InfoSection(
user: user,
),

SizedBox(height: 40.h),
],
),
),
);
},
),
);
}
}