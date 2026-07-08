import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import '../moodels/feature.dart';

class FeatureRequestScreen extends StatefulWidget {
  const FeatureRequestScreen({super.key});

  @override
  State<FeatureRequestScreen> createState() =>
      _FeatureRequestScreenState();
}

class _FeatureRequestScreenState
    extends State<FeatureRequestScreen> {

  final controller = TextEditingController();

  bool loading = false;

  Future<void> submit() async {
    final text = controller.text.trim();

    if (text.isEmpty) return;

    setState(() {
      loading = true;
    });

    try {
      await FeatureRequestRepository.submit(
        text,
      );

      controller.clear();

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Thank you for your feedback ❤️",
          ),
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
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Feature Requests",
        ),
      ),

      body: ListView(
        padding: EdgeInsets.all(20.w),
        children: [

          Container(
            padding: EdgeInsets.all(24.w),

            decoration: BoxDecoration(
              color: theme.colorScheme.surface,

              borderRadius:
              BorderRadius.circular(34.r),

              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.015),
                  blurRadius: 42.r,
                  spreadRadius: -22.r,
                  offset: Offset(
                    0,
                    18.h,
                  ),
                ),
              ],
            ),

            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [

                Text(
                  "Have an idea?",
                  style: theme.textTheme.headlineSmall
                      ?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),

                SizedBox(height: 10.h),

                Text(
                  "We're always looking for ways to improve Hi. Tell us what you'd like to see in future updates.",
                  style: theme.textTheme.bodyMedium
                      ?.copyWith(
                    height: 1.6,
                  ),
                ),

                SizedBox(height: 24.h),

                TextField(
                  controller: controller,
                  minLines: 6,
                  maxLines: 10,
                  textCapitalization:
                  TextCapitalization.sentences,
                  decoration: InputDecoration(
                    hintText:
                    "Describe your idea...",
                    border: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.circular(
                        22.r,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 24.h),

                SizedBox(
                  width: double.infinity,
                  height: 54.h,
                  child: FilledButton(
                    onPressed:
                    loading ? null : submit,
                    child: loading
                        ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                        : const Text(
                      "Submit Request",
                    ),
                  ),
                ),
              ],
            ),
          )
              .animate()
              .fade()
              .slideY(begin: .08),
        ],
      ),
    );
  }
}