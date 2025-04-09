import 'package:intl/intl.dart';

class TimeRule {
  static String timeAgo(String dateString) {
    final dateTime = DateTime.parse(dateString).toLocal();
    final now = DateTime.now();

    if (dateTime.isAfter(now)) return 'just now';

    final difference = now.difference(dateTime);

    if (difference.inSeconds < 60) {
      return 'just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} min ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hr ago';
    } else if (difference.inDays < 30) {
      return '${difference.inDays} day${difference.inDays == 1 ? '' : 's'} ago';
    } else if (difference.inDays < 365) {
      final months = (difference.inDays / 30).floor();
      return '$months month${months == 1 ? '' : 's'} ago';
    } else {
      final years = (difference.inDays / 365).floor();
      return '$years year${years == 1 ? '' : 's'} ago';
    }
  }

  static String formatDate(String dateString) {
    final dateTime = DateTime.parse(dateString).toLocal();
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }

}
