import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../../../../shared/widgets/button/hi_button.dart';
import '../../../../auth/data/auth_repository.dart';
import '../../../../auth/presentation/login/widgets/hi_dialog.dart';


class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() =>
      _ChangePasswordScreenState();
}

class _ChangePasswordScreenState
    extends State<ChangePasswordScreen> {

bool loading = false;

final email =
FirebaseAuth.instance.currentUser?.email ?? "";

Future<void> sendResetEmail() async {
setState(() {
loading = true;
});

try {
await AuthRepository.resetPassword(
email: email,
);

if (!mounted) return;

_showSuccessSheet();

} on FirebaseAuthException catch (e) {
HiDialog.show(
context: context,
title: "Unable to Send Email",
message:
e.message ??
"Something went wrong.",
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

final theme = Theme.of(context);

return GestureDetector(
onTap: () {
FocusScope.of(context).unfocus();
},

child: Scaffold(
backgroundColor:
const Color(0xffF8F8FA),

body: SafeArea(
child: SingleChildScrollView(
physics:
const BouncingScrollPhysics(),

padding:
const EdgeInsets.fromLTRB(
28,
34,
28,
28,
),

child: Column(
crossAxisAlignment:
CrossAxisAlignment.start,

children: [

IconButton(
onPressed: () {
context.pop();
},
icon: const Icon(
Icons.arrow_back_ios_new,
),
)
.animate()
.fade()
.moveX(begin: -20),

const SizedBox(height: 12),

Text(
"Change Password",
style: theme
.textTheme
.displaySmall
?.copyWith(
fontWeight:
FontWeight.w800,
letterSpacing: -1.4,
),
)
.animate()
.fade(
delay: 80.ms,
)
.moveY(begin: 18),

const SizedBox(height: 12),

Text(
"We'll send a secure password reset link to your registered email address.",
style: theme
.textTheme
.bodyLarge
?.copyWith(
color: Colors.grey.shade600,
height: 1.55,
),
)
.animate(
delay: 160.ms,
)
.fade()
.moveY(begin: 18),

const SizedBox(height: 42),

ClipRRect(
borderRadius:
BorderRadius.circular(34),

child: BackdropFilter(
filter: ImageFilter.blur(
sigmaX: 20,
sigmaY: 20,
),

child: Container(
width: double.infinity,

padding:
const EdgeInsets.all(28),

decoration: BoxDecoration(
color: Colors.white
.withOpacity(.82),

borderRadius:
BorderRadius.circular(
34,
),

border: Border.all(
color: Colors.white
.withOpacity(.7),
),

boxShadow: [
BoxShadow(
color: Colors.black
.withOpacity(.05),
blurRadius: 45,
spreadRadius: -18,
offset:
const Offset(
0,
18,
),
),
],
),

child: Column(
children: [

Container(
width: 74,
height: 74,

decoration:
BoxDecoration(
color: theme
.colorScheme
.primary
.withOpacity(.08),

shape:
BoxShape.circle,
),

child: Icon(
Icons.lock_reset,
size: 36,
color: theme
.colorScheme
.primary,
),
)
.animate()
.scale(
delay: 250.ms,
),

const SizedBox(
height: 24,
),

Text(
"Registered Email",
style: theme
.textTheme
.labelLarge
?.copyWith(
color: Colors
.grey
.shade600,
),
)
.animate(
delay: 320.ms,
)
.fade(),

const SizedBox(
height: 10,
),

SelectableText(
email,
textAlign:
TextAlign.center,
style: theme
.textTheme
.titleMedium
?.copyWith(
fontWeight:
FontWeight.w700,
),
)
.animate(
delay: 420.ms,
)
.fade()
.moveY(begin: 10),

const SizedBox(
height: 32,
),

AnimatedSwitcher(
duration:
const Duration(
milliseconds: 250,
),

child: SizedBox(
key: ValueKey(
loading,
),

width:
double.infinity,

height: 58,

child: loading
? FilledButton(
onPressed:
null,

child:
const SizedBox(
width: 22,
height: 22,
child:
CircularProgressIndicator(
strokeWidth:
2.3,
color: Colors
.white,
),
),
)
: HiButton(
text:
"Send Reset Link",

onPressed:
sendResetEmail,
),
),
)
.animate(
delay: 520.ms,
)
.fade()
.scale(
begin:
const Offset(
.96,
.96,
),
),
],
),
),
),
)
.animate(
delay: 180.ms,
)
.fade()
.moveY(begin: 28)
.scale(
begin:
const Offset(
.97,
.97,
),
),
],
),
),
),
),
);
}
void _showSuccessSheet() {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) {
      final theme = Theme.of(context);

      return Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.fromLTRB(
          28,
          24,
          28,
          34,
        ),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(36),
        ),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              Container(
                width: 46,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius:
                  BorderRadius.circular(100),
                ),
              )
                  .animate()
                  .fade(),

              const SizedBox(height: 30),

              Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle_rounded,
                  color: Colors.green,
                  size: 58,
                ),
              )
                  .animate()
                  .scale(
                curve: Curves.elasticOut,
                duration: 700.ms,
              ),

              const SizedBox(height: 28),

              Text(
                "Reset Email Sent",
                style: theme.textTheme.headlineSmall
                    ?.copyWith(
                  fontWeight: FontWeight.w800,
                  letterSpacing: -.8,
                ),
              )
                  .animate(delay: 180.ms)
                  .fade()
                  .moveY(begin: 10),

              const SizedBox(height: 14),

              Text(
                "We've sent a secure password reset link to",
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge
                    ?.copyWith(
                  color: Colors.grey.shade600,
                  height: 1.55,
                ),
              )
                  .animate(delay: 260.ms)
                  .fade(),

              const SizedBox(height: 18),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary
                      .withOpacity(.08),
                  borderRadius:
                  BorderRadius.circular(18),
                ),
                child: SelectableText(
                  email,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleMedium
                      ?.copyWith(
                    fontWeight: FontWeight.w700,
                    color:
                    theme.colorScheme.primary,
                  ),
                ),
              )
                  .animate(delay: 320.ms)
                  .fade()
                  .scale(),

              const SizedBox(height: 22),

              Text(
                "Open your inbox and follow the instructions to choose a new password.\n\nIf you don't see the email within a few minutes, please check your Spam or Junk folder.",
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium
                    ?.copyWith(
                  color: Colors.grey.shade600,
                  height: 1.6,
                ),
              )
                  .animate(delay: 420.ms)
                  .fade(),

              const SizedBox(height: 34),

              SizedBox(
                width: double.infinity,
                height: 56,
                child: FilledButton(
                  onPressed: () {
                    Navigator.pop(context);
                    context.pop();
                  },
                  style: FilledButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(18),
                    ),
                  ),
                  child: const Text(
                    "Done",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              )
                  .animate(delay: 520.ms)
                  .fade()
                  .moveY(begin: 20),
            ],
          ),
        ),
      ).animate().moveY(
        begin: 80,
        duration: 450.ms,
        curve: Curves.easeOutCubic,
      );
    },
  );
}}