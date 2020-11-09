import 'package:intl/intl.dart';

class DateTimeUtils {
  String convertTimeStampToHour(int timestamp) {
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return DateFormat.jm().format(date);
  }
}
