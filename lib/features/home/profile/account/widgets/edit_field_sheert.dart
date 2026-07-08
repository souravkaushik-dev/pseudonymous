import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../repository/personal-repository.dart';

class EditFieldSheet extends StatefulWidget {
  const EditFieldSheet({
    super.key,
    required this.title,
    required this.initialValue,
    required this.field,
    this.maxLines = 1,
  });

  final String title;
  final String initialValue;
  final String field;
  final int maxLines;

  static Future<void> show(
      BuildContext context, {
        required String title,
        required String initialValue,
        required String field,
        int maxLines = 1,
      }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return EditFieldSheet(
          title: title,
          initialValue: initialValue,
          field: field,
          maxLines: maxLines,
        );
      },
    );
  }

  @override
  State<EditFieldSheet> createState() =>
      _EditFieldSheetState();
}

class _EditFieldSheetState
    extends State<EditFieldSheet> {
late final TextEditingController controller;

bool saving = false;

@override
void initState() {
super.initState();

controller = TextEditingController(
text: widget.initialValue,
);
}

@override
void dispose() {
controller.dispose();
super.dispose();
}

Future<void> save() async {
  final value = controller.text.trim();

  if (value.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Field cannot be empty."),
      ),
    );
    return;
  }

  setState(() {
    saving = true;
  });

  try {
    /// NAME
    if (widget.field == "name") {
      if (value.length < 3) {
        throw Exception(
          "Name must be at least 3 characters.",
        );
      }
    }

    /// USERNAME
    if (widget.field == "username") {
      final username =
      value.toLowerCase().replaceAll(" ", "");

      final query = await FirebaseFirestore.instance
          .collection("users")
          .where(
        "username",
        isEqualTo: username,
      )
          .get();

      final myUid =
          PersonalInformationRepository.uid;

      final exists = query.docs.any(
            (e) => e.id != myUid,
      );

      if (exists) {
        throw Exception(
          "Username already exists.",
        );
      }
    }

    /// WEBSITE
    if (widget.field == "website") {
      if (value.isNotEmpty) {
        final uri = Uri.tryParse(value);

        if (uri == null ||
            !(uri.isScheme("http") ||
                uri.isScheme("https"))) {
          throw Exception(
            "Enter a valid website URL.",
          );
        }
      }
    }

    /// BIO
    if (widget.field == "bio") {
      if (value.length > 150) {
        throw Exception(
          "Bio can't exceed 150 characters.",
        );
      }
    }

    await PersonalInformationRepository.update({
      widget.field: value,
    });

    if (!mounted) return;

    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(
          "Profile updated successfully.",
        ),
      ),
    );
  } catch (e) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(
          e.toString().replaceFirst(
            "Exception: ",
            "",
          ),
        ),
      ),
    );
  } finally {
    if (mounted) {
      setState(() {
        saving = false;
      });
    }
  }
}

@override
Widget build(BuildContext context) {
final theme = Theme.of(context);

return AnimatedPadding(
duration: const Duration(milliseconds: 250),
padding: EdgeInsets.only(
bottom: MediaQuery.of(context)
.viewInsets
.bottom,
),
child: Container(
padding: EdgeInsets.all(24.w),

decoration: BoxDecoration(
color: theme.colorScheme.surface,
borderRadius: BorderRadius.vertical(
top: Radius.circular(36.r),
),
),

child: Column(
mainAxisSize: MainAxisSize.min,
children: [

Container(
width: 48.w,
height: 5.h,
decoration: BoxDecoration(
color: Colors.grey.shade300,
borderRadius:
BorderRadius.circular(100.r),
),
),

SizedBox(height: 26.h),

Text(
widget.title,
style: theme.textTheme.titleLarge,
),

SizedBox(height: 28.h),

  TextField(
    controller: controller,
    autofocus: true,
    maxLines: widget.maxLines,
    maxLength: widget.field == "bio"
        ? 150
        : widget.field == "name"
        ? 40
        : widget.field == "username"
        ? 20
        : widget.field == "website"
        ? 80
        : widget.field == "location"
        ? 40
        : null,
    textCapitalization: widget.field == "name"
        ? TextCapitalization.words
        : TextCapitalization.none,
    keyboardType: widget.field == "website"
        ? TextInputType.url
        : widget.field == "email"
        ? TextInputType.emailAddress
        : TextInputType.text,
    decoration: InputDecoration(
      hintText: "Enter ${widget.title}",
      filled: true,
      fillColor: Theme.of(context)
          .colorScheme
          .surfaceContainerHighest
          .withOpacity(.35),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18.r),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18.r),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18.r),
        borderSide: BorderSide(
          color: Theme.of(context).colorScheme.primary,
          width: 1.4,
        ),
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: 18.w,
        vertical: 16.h,
      ),
    ),
  ),

SizedBox(height: 28.h),
  Row(
    children: [
      Expanded(
        child: OutlinedButton(
          onPressed: saving
              ? null
              : () {
            Navigator.pop(context);
          },
          style: OutlinedButton.styleFrom(
            minimumSize: Size(
              double.infinity,
              54.h,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.r),
            ),
          ),
          child: const Text("Cancel"),
        ),
      ),

      SizedBox(width: 14.w),

      Expanded(
        child: FilledButton(
          onPressed: saving ? null : save,
          style: FilledButton.styleFrom(
            minimumSize: Size(
              double.infinity,
              54.h,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.r),
            ),
          ),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            transitionBuilder: (child, animation) {
              return FadeTransition(
                opacity: animation,
                child: ScaleTransition(
                  scale: animation,
                  child: child,
                ),
              );
            },
            child: saving
                ? SizedBox(
              key: const ValueKey("loading"),
              width: 22.w,
              height: 22.w,
              child: const CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white,
              ),
            )
                : const Text(
              "Save Changes",
              key: ValueKey("save"),
            ),
          ),
        ),
      ),
    ],
  ),

  SizedBox(height: 12.h),
],
),
),
);
}
}