import 'package:intl/intl.dart';

class DateFormatter {
  static String formatDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  static String formatTime(DateTime date) {
    return DateFormat.Hm().format(date); // HH:mm
  }

  static String formatFull(DateTime date) {
    return DateFormat('dd/MM/yyyy HH:mm').format(date);
  }

  static DateTime fromTimestamp(int timestamp) {
    return DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  }

  static String formatDateFromTimestamp(int timestamp) {
    return formatDate(fromTimestamp(timestamp));
  }

  static String formatTimeFromTimestamp(int timestamp) {
    return formatTime(fromTimestamp(timestamp));
  }
}
