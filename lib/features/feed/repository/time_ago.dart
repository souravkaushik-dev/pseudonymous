class TimeAgo {

  static String format(
      DateTime date,
      ) {

    final diff =
    DateTime.now().difference(date);

    if (diff.inSeconds < 60) {
      return "Just now";
    }

    if (diff.inMinutes < 60) {
      return "${diff.inMinutes}m";
    }

    if (diff.inHours < 24) {
      return "${diff.inHours}h";
    }

    if (diff.inDays == 1) {
      return "Yesterday";
    }

    if (diff.inDays < 7) {
      return "${diff.inDays}d";
    }

    if (diff.inDays < 30) {
      return "${(diff.inDays / 7).floor()}w";
    }

    if (diff.inDays < 365) {
      return "${(diff.inDays / 30).floor()}mo";
    }

    return "${(diff.inDays / 365).floor()}y";
  }
}