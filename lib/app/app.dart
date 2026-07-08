import 'package:flutter/material.dart';
import 'package:hi_pseudonymous/app/theme/app_theme.dart';
import 'routes/app_router.dart';

class HiApp extends StatelessWidget {
  const HiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Hi',
      routerConfig: appRouter,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
    );
  }
}