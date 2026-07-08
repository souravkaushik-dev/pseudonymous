import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../app/routes/app_routes.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../shared/widgets/button/hi_button.dart';
import '../../../../shared/widgets/inputs/hi_text_field.dart';
import '../../controller/auth_controller.dart';
import '../../data/auth_repository.dart';
import '../../services/auth_navigation.dart';
import '../login/widgets/auth_footer.dart';
import '../login/widgets/divider_text.dart';
import '../login/widgets/hi_dialog.dart';
import '../login/widgets/social_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final controller = AuthController();
  final formKey = GlobalKey<FormState>();
  bool loading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> login() async {
    if (!formKey.currentState!.validate()) return;

    setState(() {
      loading = true;
    });

    try {
      await AuthRepository.login(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      final route =
      await AuthNavigationService.getNextRoute();

      if (!mounted) return;

      if (route == AppRoutes.home) {
        context.go(AppRoutes.shell);
      } else {
        context.go(route);
      }
    } on FirebaseAuthException catch (e) {
      HiDialog.show(
        context: context,
        title: "Login Failed",
        message: e.message ?? "Invalid credentials.",
      );
    } finally {
      if (mounted) {
        setState(() {
          loading = false;
        });
      }
    }
  }
  Future<void> signInWithGoogle() async {
    try {
      final credential = await AuthRepository.signInWithGoogle();

      final user = credential.user!;

      await AuthRepository.createUserIfNeeded(user);

      final route = await AuthNavigationService.getNextRoute();

      if (!mounted) return;

      if (route == AppRoutes.home) {
        context.go(AppRoutes.shell);
      } else {
        context.go(route);
      }
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;

      HiDialog.show(
        context: context,
        title: "Google Sign-In Failed",
        message: e.message ?? "Unable to sign in.",
      );
    } catch (e) {
      if (!mounted) return;

      HiDialog.show(
        context: context,
        title: "Error",
        message: e.toString(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: const Color(0xffF8F8FA),
        body: SafeArea(
          child: SingleChildScrollView(
            physics:
            const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(
              horizontal: 28,
              vertical: 36,
            ),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [

                  _hero(),

                  const SizedBox(height: 42),

                  _loginCard(),

                  const SizedBox(height: 28),

                  Center(
                    child: AuthFooter(
                      title:
                      "Don't have an account?",
                      actionText:
                      "Create Account",
                      onTap: () {
                        context.push(
                          AppRoutes.register,
                        );
                      },
                    ),
                  )
                      .animate(delay: 900.ms)
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
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [

        const Text(
          "Welcome back.",
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
          "Continue your anonymous conversations privately.",
          style: TextStyle(
            fontSize: 18,
            color: Colors.grey.shade600,
            height: 1.55,
          ),
        )
            .animate(delay: 120.ms)
            .fade()
            .moveY(begin: 18),
      ],
    );
  }
  Widget _loginCard() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(36),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 20,
          sigmaY: 20,
        ),
        child: Container(
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(.82),
            borderRadius:
            BorderRadius.circular(36),
            border: Border.all(
              color: Colors.white.withOpacity(.7),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.05),
                blurRadius: 45,
                spreadRadius: -14,
                offset: const Offset(
                  0,
                  18,
                ),
              ),
            ],
          ),
          child: Column(
            children: [

              _emailField(),

              const SizedBox(height: 22),

              _passwordField(),

              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    context.push(
                      AppRoutes.forgotPassword,
                    );
                  },
                  child: const Text(
                    "Forgot Password?",
                  ),
                ),
              ),

              const SizedBox(height: 12),

              AnimatedSwitcher(
                duration:
                const Duration(milliseconds: 250),
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
                    text: "Continue",
                    onPressed: login,
                  ),
                ),
              ),

              const SizedBox(height: 28),

              const DividerText(),

              const SizedBox(height: 24),

              SocialButton(
                title:
                "Continue with Google",
                icon: const HugeIcon(
                  icon:
                  HugeIcons.strokeRoundedGoogle,
                  size: 20,
                  color: AppColors.textPrimary,
                ),
                onPressed:
                signInWithGoogle,
              ),
            ],
          ),
        ),
      ),
    )
        .animate(delay: 300.ms)
        .fade()
        .scale(
      begin: const Offset(.96, .96),
    )
        .moveY(begin: 24);
  }
  Widget _emailField() {
    return HiTextField(
      controller: emailController,
      labelText: "Email",
      hintText: "Enter your email",
      keyboardType:
      TextInputType.emailAddress,
      prefixIcon: HugeIcon(
        icon: HugeIcons.strokeRoundedMail01,
        size: 18,
        color: Colors.grey.shade600,
      ),
      validator: (v) {
        if (v == null || v.isEmpty) {
          return "Enter email";
        }
        return null;
      },
    )
        .animate(delay: 450.ms)
        .fade()
        .moveX(begin: 20);
  }
  Widget _passwordField() {
    return HiTextField(
      controller: passwordController,
      labelText: "Password",
      hintText: "Enter your password",
      obscureText: true,
      prefixIcon: HugeIcon(
        icon:
        HugeIcons.strokeRoundedLockPassword,
        size: 18,
        color: Colors.grey.shade600,
      ),
      validator: (v) {
        if (v == null || v.length < 6) {
          return "Minimum 6 characters";
        }
        return null;
      },
    )
        .animate(delay: 520.ms)
        .fade()
        .moveX(begin: 20);
  }
}