import 'package:flutter/material.dart';
import 'package:hive_repository/hive_repository.dart';

export 'category_card_widget.dart';
export 'shimmer_widget.dart';
export 'task_card_widget.dart';

extension TimeOfDayExtension on TimeOfDay {
  String getTime() {
    String time;
    var hours = (hour >= 12 ? (hour - 12) : hour).toString();
    hours = hours.length == 1 ? ('0$hours') : hours;
    final minutes =
        minute.toString().length == 1 ? ('0$minute') : minute.toString();
    time = '$hours:$minutes ${period.name}';
    return time;
  }
}

Map<int, String> monthNames = {
  1: 'Jan',
  2: 'Feb',
  3: 'Mar',
  4: 'Apr',
  5: 'May',
  6: 'Jun',
  7: 'Jul',
  8: 'Aug',
  9: 'Sep',
  10: 'Oct',
  11: 'Nov',
  12: 'Dec'
};

Map<int, String> weekdaysNames = {
  1: 'Mo',
  2: 'Tu',
  3: 'We',
  4: 'Th',
  5: 'Fr',
  6: 'Sa',
  7: 'Su'
};

extension DatesExtension on DateTime {
  bool isEqual(DateTime other) {
    if (year == other.year && month == other.month && day == other.day) {
      return true;
    }
    return false;
  }

  String getMonthName() {
    return monthNames[month] ?? '';
  }

  String getWeekdayName() {
    return weekdaysNames[weekday] ?? '';
  }

  int numberOfDaysInMonth() {
    switch (month) {
      case 0:
      case 3:
      case 5:
      case 7:
      case 11:
        return 31;
      case 2:
        return year % 4 == 0 ? 29 : 28;
      default:
        return 30;
    }
  }
}

int daysOnTaskRemaining(Task task) => task.durationMinutes() ~/ 60 ~/ 24;
int hoursOnTasRemaining(Task task) =>
    (task.durationMinutes() - daysOnTaskRemaining(task) * 24 * 60) ~/ 60;
int minutesOnTaskRemaining(Task task) =>
    task.durationMinutes() -
    daysOnTaskRemaining(task) * 24 * 60 -
    hoursOnTasRemaining(task) * 60;
String minutesRemainingTitle(int days, int hours, int minutes) {
  var minutesTitle = '$minutes minutes';
  if (minutes == 0) {
    if (days == 0 && hours == 0) {
      minutesTitle = 'No time';
    } else {
      minutesTitle = '';
    }
  }
  return minutesTitle;
}
