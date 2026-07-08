import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../auth/services/auth_navigation.dart';
import '../widgets/animated-widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  Future<void> _navigate() async {
    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;

    final route = await AuthNavigationService.getNextRoute();

    if (!mounted) return;

    context.go(route);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 42),

          child: Column(
            children: [

              Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [

                      Text(
                        "Pseudonymous",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.sora(
                          fontSize: 46,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -2.5,
                          color: theme.colorScheme.onSurface,
                        ),
                      )
                          .animate()
                          .fade(
                        duration: 700.ms,
                      )
                          .scale(
                        begin: const Offset(.92, .92),
                        curve: Curves.easeOutCubic,
                      ),

                      const SizedBox(height: 22),

                      Text(
                        "Connect freely.\nStay anonymous.",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.sora(
                          fontSize: 17,
                          height: 1.65,
                          fontWeight: FontWeight.w400,
                          color: theme.colorScheme.onSurface.withOpacity(.62),
                        ),
                      )
                          .animate(delay: 250.ms)
                          .fade()
                          .moveY(begin: 16),
                    ],
                  ),
                ),
              ),

              Column(
                children: [

                  Container(
                    width: 170,
                    height: 4,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.onSurface.withOpacity(.08),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    alignment: Alignment.centerLeft,
                    child: TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0, end: 1),
                      duration: const Duration(milliseconds: 1800),
                      curve: Curves.easeInOut,
                      builder: (context, value, child) {
                        return FractionallySizedBox(
                          widthFactor: value,
                          child: Container(
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary,
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                      .animate(delay: 450.ms)
                      .fade(),

                  const SizedBox(height: 18),

                  Text(
                    "Privacy begins here.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.sora(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      letterSpacing: .35,
                      color: theme.colorScheme.onSurface.withOpacity(.45),
                    ),
                  )
                      .animate(
                    delay: 700.ms,
                    onPlay: (controller) => controller.repeat(reverse: true),
                  )
                      .fade(
                    begin: .35,
                    end: 1,
                    duration: 1200.ms,
                  ),

                  const SizedBox(height: 18),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
