/// Gregorian ↔ Hijri conversion using the Kuwaiti algorithm.
class HijriDate {
  HijriDate._();

  static String format(DateTime date, {required bool hijri}) {
    if (!hijri) {
      return _pad(date.year, date.month, date.day);
    }
    final converted = fromGregorian(date);
    return _pad(converted.year, converted.month, converted.day);
  }

  static ({int year, int month, int day}) fromGregorian(DateTime date) {
    final jd = _julianDay(date.year, date.month, date.day);
    return _julianToHijri(jd);
  }

  static String _pad(int year, int month, int day) {
    final y = year.toString().padLeft(4, '0');
    final m = month.toString().padLeft(2, '0');
    final d = day.toString().padLeft(2, '0');
    return '$y-$m-$d';
  }

  static int _julianDay(int year, int month, int day) {
    if (year > 1582 ||
        (year == 1582 && month > 10) ||
        (year == 1582 && month == 10 && day > 14)) {
      return (1461 * (year + 4800 + (month - 14) ~/ 12)) ~/ 4 +
          (367 * (month - 2 - 12 * ((month - 14) ~/ 12))) ~/ 12 -
          (3 * ((year + 4900 + (month - 14) ~/ 12) ~/ 100)) ~/ 4 +
          day -
          32075;
    }
    return 367 * year -
        (7 * (year + 5001 + (month - 9) ~/ 7)) ~/ 4 +
        (275 * month) ~/ 9 +
        day +
        1729777;
  }

  static ({int year, int month, int day}) _julianToHijri(int jd) {
    var l = jd - 1948440 + 10632;
    final n = (l - 1) ~/ 10631;
    l = l - 10631 * n + 354;
    final j =
        ((10985 - l) ~/ 5316) * ((50 * l) ~/ 17719) +
        (l ~/ 5670) * ((43 * l) ~/ 15238);
    l =
        l -
        ((30 - j) ~/ 15) * ((17719 * j) ~/ 50) -
        (j ~/ 16) * ((15238 * j) ~/ 43) +
        29;
    final month = (24 * l) ~/ 709;
    final day = l - (709 * month) ~/ 24;
    final year = 30 * n + j - 30;
    return (year: year, month: month, day: day);
  }
}
