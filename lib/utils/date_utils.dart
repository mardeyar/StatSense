import 'package:intl/intl.dart';

class DateUtils {
  static String formatWeekStartDate(DateTime date) {
    final DateTime weekStart = date.subtract(Duration(days: date.weekday - 1));
    return DateFormat('yyyy-MM-dd').format(weekStart);
  }
}