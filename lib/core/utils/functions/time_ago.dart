import 'package:intl/intl.dart';

class DateTimeHandler {
  DateTimeHandler._();
  static String convertDateTime(
    DateTime dateTime, {
    String format = 'dd/MM/yyyy - hh:mm a',
  }) => DateFormat(format).format(dateTime);
  static String convertTime(DateTime dateTime, {String format = 'hh:mm a'}) =>
      DateFormat(format).format(dateTime);
  static String convertDate(
    DateTime dateTime, {
    String format = 'dd/MM/yyyy',
  }) => DateFormat(format).format(dateTime);
  static String timeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inSeconds < 10) {
      return 'Just now';
    } else if (difference.inMinutes < 1) {
      return '${difference.inSeconds}s ago';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inDays < 1) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return DateFormat('yyyy/MM/dd').format(dateTime);
    }
  }

  static String formatSeconds(int seconds) {
    final m = (seconds ~/ 60).toString().padLeft(2, '0');
    final s = (seconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  static String formatTime(String? time) {
    if (time == null || time.isEmpty) return '';
    try {
      final parsed = DateFormat('HH:mm:ss').parse(time);
      return DateFormat('hh:mm a').format(parsed);
    } catch (e) {
      try {
        final parsed = DateFormat('HH:mm').parse(time);
        return DateFormat('hh:mm a').format(parsed);
      } catch (e) {
        return time;
      }
    }
  }

  static String formatDate(String? date) {
    if (date == null || date.isEmpty) return '';
    try {
      final parsed = DateTime.parse(date);
      return DateFormat('EEEE, MMM dd').format(parsed);
    } catch (e) {
      return date;
    }
  }
}
