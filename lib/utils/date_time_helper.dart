import 'package:intl/intl.dart';

class DateTimeHelper {
  static DateTime format() {

    final now = DateTime.now();
    final dateFormat = DateFormat('y/M/d');
    const timeSpecific = "11:00:00";
    final completeFormat = DateFormat('y/M/d H:m:s');

    final todayDate = dateFormat.format(now);
    final todayDateAndTime = "$todayDate $timeSpecific";
    var resultToday = completeFormat.parseStrict(todayDateAndTime);

    var resultTomorrow = resultToday.add(const Duration(days: 1));

    return now.isAfter(resultToday) ? resultTomorrow : resultToday;
  }
}