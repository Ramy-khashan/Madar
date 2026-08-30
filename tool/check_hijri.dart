import '../lib/core/utils/functions/hijri_date.dart';

void check(DateTime g) {
  final h = HijriDate.fromGregorian(g);
  final back = HijriDate.toGregorian(h.year, h.month, h.day);
  final same = back.year == g.year && back.month == g.month && back.day == g.day;
  print(
    '${g.toIso8601String().split('T').first} -> '
    '${h.year}-${h.month.toString().padLeft(2, '0')}-${h.day.toString().padLeft(2, '0')} -> '
    '${back.toIso8601String().split('T').first} ${same ? 'OK' : 'MISMATCH'} '
    'days=${HijriDate.daysInMonth(h.year, h.month)}',
  );
}

void main() {
  check(DateTime(2026, 8, 30));
  check(DateTime(2024, 1, 1));
  check(DateTime(1990, 6, 15));
  check(DateTime(2010, 12, 31));
  check(DateTime(1950, 1, 1));
  final today = HijriDate.today();
  print('today hijri ${today.year}-${today.month}-${today.day}');
  for (var m = 1; m <= 12; m++) {
    print('1447-$m days=${HijriDate.daysInMonth(1447, m)}');
  }
}
