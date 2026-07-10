import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hi_pseudonymous/features/username/presentation/widgets/username_status.dart';
import 'package:hi_pseudonymous/features/username/presentation/widgets/username_widgets.dart';

import '../../../app/routes/app_routes.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../shared/widgets/button/hi_button.dart';
import '../../../shared/widgets/inputs/hi_text_field.dart';
import '../../auth/data/auth_repository.dart';
import '../../auth/services/auth_navigation.dart';
import '../controller/username_controller.dart';
import '../model/username_models.dart';
import '../repository/username_repository.dart';


class UsernameScreen extends StatefulWidget {
  const UsernameScreen({super.key});

  @override
  State<UsernameScreen> createState() => _UsernameScreenState();
}

class _UsernameScreenState extends State<UsernameScreen> {
  final controller = UsernameController();

  final usernameController = TextEditingController();

  UsernameStatus status = UsernameStatus.initial;

  bool loading = false;

  @override
  void dispose() {
    usernameController.dispose();
    controller.dispose();
    super.dispose();
  }

  Future<void> checkUsername(String value) async {
    final username = value.trim().toLowerCase();

    setState(() {
      status = UsernameStatus.checking;
    });

    final result = await controller.checkUsername(username);

    if (!mounted) return;

    setState(() {
      status = result;
    });
  }

  Future<void> continuePressed() async {
    if (status != UsernameStatus.available) return;

    setState(() {
      loading = true;
    });

    try {
      await UsernameRepository.saveUsername(
        username: usernameController.text.trim(),
      );

      if (!mounted) return;

      context.push(
        AppRoutes.selectAvatar,
        extra: "avatar_01",
      );

    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [

              const SizedBox(height: 50),

              Text(
                "Choose your\nusername",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displaySmall,
              ),

              const SizedBox(height: 12),

              Text(
                "People will use this to send you anonymous messages.",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),

              const SizedBox(height: 40),

              HiTextField(
                controller: usernameController,
                hintText: "@username",
                onChanged: checkUsername,
              ),

              const SizedBox(height: 16),

              UsernameStatusWidget(
                status: status,
              ),

              const SizedBox(height: 28),

              UsernamePreview(
                username: usernameController.text,
              ),

              const SizedBox(height: 40),

              HiButton(
                text: "Continue",
                isLoading: loading,
                onPressed: continuePressed,
              ),
            ],
          ),
        ),
      ),
    );
  }
}