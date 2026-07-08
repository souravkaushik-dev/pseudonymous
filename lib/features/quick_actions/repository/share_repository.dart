import 'package:share_plus/share_plus.dart';

class ShareRepository {
  ShareRepository._();

  static Future<void> shareProfile({
    required String name,
    required String username,
  }) async {
    final link = "https://hi.app/u/$username";

    await Share.share(
      '''
👋 Connect with $name on Hi!

$username

$link
''',
      subject: "$name on Hi",
    );
  }
}