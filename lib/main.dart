import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'app/app.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    ScreenUtilPlusInit(
      designSize: const Size(393, 852), // Figma design size
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return const HiApp();
      },
    ),
  );
}