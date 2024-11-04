extension DateHelpers on DateTime {
  bool get isToday {
    final now = DateTime.now();
    return now.day == day && now.month == month && now.year == year;
  }

  bool get isSameYear {
    final now = DateTime.now();
    return now.year == year;
  }

  bool isSameHour(DateTime other) {
    return other.hour == hour && other.day == day && other.month == month && other.year == year;
  }

  bool isNowHour() {
    final now = DateTime.now().toUtc();
    return now.hour == hour && now.day == day && now.month == month && now.year == year;
  }

  bool isYesterday() {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return yesterday.day == day && yesterday.month == month && yesterday.year == year;
  }

  bool isBeforeOrSameAs(DateTime other) => isBefore(other) || isAtSameMomentAs(other);

  bool isAfterOrSameAs(DateTime other) => isAfter(other) || isAtSameMomentAs(other);

  bool isBetweenInclusive(DateTime start, DateTime end) => isBeforeOrSameAs(end) && isAfterOrSameAs(start);

  /// return DateTime at 00:00
  DateTime startOfDay() => DateTime(year, month, day, 0);

  DateTime get startOfDayUtc => DateTime.utc(year, month, day, 0);

  /// return DateTime at 23:59:59:999:999
  DateTime get endOfDay => DateTime(year, month, day, 23, 59, 59, 999, 999);

  DateTime get endOfDayUtc => DateTime.utc(year, month, day, 23, 59, 59, 999, 999);

  DateTime get startOfHour => DateTime(year, month, day, hour, 0, 00, 000, 000);

  DateTime get endOfHour => DateTime(year, month, day, hour, 59, 59, 999, 999);

  DateTime get startOfHourUtc => DateTime.utc(year, month, day, hour, 0, 00, 000, 000);

  DateTime get endOfHourUtc => DateTime.utc(year, month, day, hour, 59, 59, 999, 999);

  int getYearsSince() {
    final now = DateTime.now();
    return now.difference(this).inDays ~/ 365;
  }

  bool isSameDay(DateTime other) => year == other.year && month == other.month && day == other.day;

  bool isSameMonth(DateTime other) => year == other.year && month == other.month;

  DateTime get mostRecentSunday => DateTime(year, month, day - weekday % 7);

  DateTime get mostRecentMonday => DateTime(year, month, day - (weekday - 1));

  DateTime get nextClosestSunday => DateTime(year, month, day + (7 - weekday));

  int get daysInMonth => DateTime(year, month + 1, 0).day;

  Duration get untilMidnight => difference(endOfDay);

  Duration get afterMidnight => startOfDay().difference(this);

  Duration get untilHour => difference(endOfHour);

  Duration get afterHour => startOfHour.difference(this);

  DateTime get startOfMonth => DateTime(year, month, 1, 0, 0, 0, 0, 0);

  DateTime get endOfMonth => DateTime(year, month + 1, 0, 23, 59, 59, 999, 999);

  /// Converts to local as if "this" is UTC
  /// Example:
  /// DateTime is 30.08.1996 03:00 (Local time UTC+3) => DateTime will be 29.08.1996 00:00
  DateTime get toLocalAsUtc => timeZoneOffset.isNegative ? add(timeZoneOffset) : subtract(timeZoneOffset);

  DateTime get toUtcAsLocal => timeZoneOffset.isNegative ? subtract(timeZoneOffset) : add(timeZoneOffset);
}
