import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../app/routes/app_routes.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../shared/widgets/button/hi_button.dart';
import '../../../../shared/widgets/inputs/hi_text_field.dart';
import '../../data/auth_repository.dart';
import '../../firestore/firestore_service.dart';
import '../login/widgets/auth_footer.dart';
import '../login/widgets/divider_text.dart';
import '../login/widgets/hi_dialog.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  bool loading = false;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> register() async {
    if (!formKey.currentState!.validate()) return;

    if (passwordController.text !=
        confirmPasswordController.text) {
      HiDialog.show(
        context: context,
        title: "Passwords don't match",
        message:
        "Please make sure both passwords are the same.",
      );
      return;
    }

    setState(() {
      loading = true;
    });

    try {
      final credential =
      await AuthRepository.register(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      await FirestoreService.createUser(
        uid: credential.user!.uid,
        name: nameController.text.trim(),
        email: emailController.text.trim(),
      );

      if (!mounted) return;

      context.go(AppRoutes.username);
    } on FirebaseAuthException catch (e) {
      HiDialog.show(
        context: context,
        title: "Registration Failed",
        message:
        e.message ?? "Something went wrong.",
      );
    } catch (_) {
      HiDialog.show(
        context: context,
        title: "Error",
        message: "Unexpected error occurred.",
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
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: const Color(
          0xffF8F8FA,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            physics:
            const BouncingScrollPhysics(),
            padding:
            const EdgeInsets.fromLTRB(
              28,
              38,
              28,
              30,
            ),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [

                  _hero(),

                  const SizedBox(
                    height: 42,
                  ),

                  _registerCard(),

                  const SizedBox(
                    height: 30,
                  ),

                  Center(
                    child: AuthFooter(
                      title:
                      "Already have an account?",
                      actionText:
                      "Sign In",
                      onTap: () {
                        context.pop();
                      },
                    ),
                  )
                      .animate(
                    delay: 900.ms,
                  )
                      .fade(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Widget _hero() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Create account.",
          style: TextStyle(
            fontSize: 46,
            fontWeight: FontWeight.w800,
            letterSpacing: -2.3,
            height: 1,
          ),
        )
            .animate()
            .fade(duration: 500.ms)
            .moveY(begin: 24),

        const SizedBox(height: 16),

        Text(
          "Join Pseudonymous and start sharing thoughts while protecting your identity.",
          style: TextStyle(
            fontSize: 18,
            height: 1.55,
            color: Colors.grey.shade600,
          ),
        )
            .animate(delay: 150.ms)
            .fade()
            .moveY(begin: 18),
      ],
    );
  }
  Widget _registerCard() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(36),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 18,
          sigmaY: 18,
        ),
        child: Container(
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(.85),
            borderRadius: BorderRadius.circular(36),
            border: Border.all(
              color: Colors.white.withOpacity(.8),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.05),
                blurRadius: 50,
                spreadRadius: -16,
                offset: const Offset(
                  0,
                  24,
                ),
              ),
            ],
          ),
          child: Column(
            children: [

              _nameField(),

              const SizedBox(height: 22),

              _emailField(),

              const SizedBox(height: 22),

              _passwordField(),

              const SizedBox(height: 22),

              _confirmPasswordField(),

              const SizedBox(height: 28),

              AnimatedSwitcher(
                duration: const Duration(
                  milliseconds: 250,
                ),
                child: SizedBox(
                  key: ValueKey(loading),
                  width: double.infinity,
                  height: 58,
                  child: loading
                      ? const Center(
                    child:
                    CircularProgressIndicator(),
                  )
                      : HiButton(
                    text: "Create Account",
                    onPressed: register,
                  ),
                ),
              ),

              const SizedBox(height: 30),

              const DividerText(),

              const SizedBox(height: 18),

              Text(
                "Your identity stays private until you decide otherwise.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    )
        .animate(delay: 300.ms)
        .fade()
        .moveY(begin: 30)
        .scale(begin: const Offset(.96, .96));
  }
  Widget _nameField() {
    return HiTextField(
      controller: nameController,
      labelText: "Name",
      hintText: "Enter your name",
      prefixIcon: HugeIcon(
        icon: HugeIcons.strokeRoundedUser,
        size: 18,
        color: Colors.grey.shade600,
      ),
    )
        .animate(delay: 420.ms)
        .fade()
        .moveX(begin: 20);
  }
  Widget _emailField() {
    return HiTextField(
      controller: emailController,
      labelText: "Email",
      hintText: "Enter your email",
      keyboardType: TextInputType.emailAddress,
      prefixIcon: HugeIcon(
        icon: HugeIcons.strokeRoundedMail01,
        size: 18,
        color: Colors.grey.shade600,
      ),
    )
        .animate(delay: 500.ms)
        .fade()
        .moveX(begin: 20);
  }
  Widget _passwordField() {
    return HiTextField(
      controller: passwordController,
      labelText: "Password",
      hintText: "Create a password",
      obscureText: true,
      prefixIcon: HugeIcon(
        icon: HugeIcons.strokeRoundedLockPassword,
        size: 18,
        color: Colors.grey.shade600,
      ),
    )
        .animate(delay: 580.ms)
        .fade()
        .moveX(begin: 20);
  }
  Widget _confirmPasswordField() {
    return HiTextField(
      controller: confirmPasswordController,
      labelText: "Confirm Password",
      hintText: "Confirm your password",
      obscureText: true,
      prefixIcon: HugeIcon(
        icon: HugeIcons.strokeRoundedLockPassword,
        size: 18,
        color: Colors.grey.shade600,
      ),
    )
        .animate(delay: 660.ms)
        .fade()
        .moveX(begin: 20);
  }
}