import 'package:share_plus/share_plus.dart';

class ShareRepository {
  ShareRepository._();

  static Future<void> sharePost({
    required String postId,
    required String username,
    required String text,
  }) async {

    final link =
        "https://hi.app/post/$postId";

    await Share.share(
      "$text\n\nPosted by @$username\n\n$link",
    );
  }

  static Future<void> shareProfile(
      String username,
      ) async {

    final link =
        "https://hi.app/@$username";

    await Share.share(
      "Send me anonymous messages 👀\n\n$link",
    );
  }
}