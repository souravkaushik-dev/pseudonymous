import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/widgets/button/hi_button.dart';
import '../../../../shared/widgets/inputs/hi_text_field.dart';
import '../login/widgets/hi_dialog.dart';
import '../../data/auth_repository.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final controller = TextEditingController();

  final formKey = GlobalKey<FormState>();

  bool loading = false;

  Future<void> resetPassword() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      loading = true;
    });

    try {
      await AuthRepository.resetPassword(email: controller.text);

      if (!mounted) return;

      showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: const Text("Email Sent"),
            content: Text(
              "A password reset link has been sent to\n\n${controller.text}",
            ),
            actions: [
              FilledButton(
                onPressed: () {
                  Navigator.pop(context);

                  context.pop();
                },
                child: const Text("Done"),
              ),
            ],
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      HiDialog.show(
        context: context,
        title: "Reset Failed",
        message: e.message ?? "Unable to send reset email.",
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
      appBar: AppBar(),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Forgot Password",
                  style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 12),

                const Text(
                  "Enter your email and we'll send you a password reset link.",
                ),

                const SizedBox(height: 40),

                HiTextField(
                  controller: controller,
                  labelText: "Email",
                  hintText: "Enter email",

                  keyboardType: TextInputType.emailAddress,

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter your email";
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 30),

                SizedBox(
                  width: double.infinity,
                  child: HiButton(
                    text: loading ? "Sending..." : "Send Reset Link",
                    onPressed: loading ? null : resetPassword,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
