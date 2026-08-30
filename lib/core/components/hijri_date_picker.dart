import 'package:flutter/material.dart';

import '../utils/constants/app_strings.dart';
import '../utils/functions/hijri_date.dart';
import '../utils/functions/responsive.dart';
import '../../config/theme/app_theme_colors.dart';

Future<DateTime?> showHijriDatePicker({
  required BuildContext context,
  DateTime? initialDate,
  DateTime? firstDate,
  DateTime? lastDate,
}) {
  final now = DateTime.now();
  return showDialog<DateTime>(
    context: context,
    builder: (context) => _HijriDatePickerDialog(
      initial: HijriDate.fromGregorian(initialDate ?? now),
      first: HijriDate.fromGregorian(firstDate ?? DateTime(1950)),
      last: HijriDate.fromGregorian(lastDate ?? now),
    ),
  );
}

class _HijriDatePickerDialog extends StatefulWidget {
  const _HijriDatePickerDialog({
    required this.initial,
    required this.first,
    required this.last,
  });

  final ({int year, int month, int day}) initial;
  final ({int year, int month, int day}) first;
  final ({int year, int month, int day}) last;

  @override
  State<_HijriDatePickerDialog> createState() => _HijriDatePickerDialogState();
}

class _HijriDatePickerDialogState extends State<_HijriDatePickerDialog> {
  late int _year;
  late int _month;
  late int _day;

  @override
  void initState() {
    super.initState();
    final clamped = _clamp(widget.initial);
    _year = clamped.year;
    _month = clamped.month;
    _day = clamped.day;
  }

  ({int year, int month, int day}) get _selected =>
      (year: _year, month: _month, day: _day);

  ({int year, int month, int day}) _clamp(
    ({int year, int month, int day}) value,
  ) {
    if (HijriDate.compare(value, widget.first) < 0) return widget.first;
    if (HijriDate.compare(value, widget.last) > 0) return widget.last;
    final maxDay = HijriDate.daysInMonth(value.year, value.month);
    if (value.day > maxDay) {
      return (year: value.year, month: value.month, day: maxDay);
    }
    return value;
  }

  void _shiftMonth(int delta) {
    var year = _year;
    var month = _month + delta;
    if (month < 1) {
      month = 12;
      year -= 1;
    } else if (month > 12) {
      month = 1;
      year += 1;
    }
    final maxDay = HijriDate.daysInMonth(year, month);
    setState(() {
      _year = year;
      _month = month;
      _day = _day > maxDay ? maxDay : _day;
    });
  }

  bool _isDisabled(({int year, int month, int day}) date) {
    return HijriDate.compare(date, widget.first) < 0 ||
        HijriDate.compare(date, widget.last) > 0;
  }

  bool get _canGoPrev {
    final prev = _month == 1
        ? (year: _year - 1, month: 12, day: 1)
        : (year: _year, month: _month - 1, day: 1);
    return !_isDisabled(prev) ||
        HijriDate.compare(prev, widget.first) >= 0 ||
        (prev.year == widget.first.year && prev.month == widget.first.month);
  }

  bool get _canGoNext {
    final next = _month == 12
        ? (year: _year + 1, month: 1, day: 1)
        : (year: _year, month: _month + 1, day: 1);
    return HijriDate.compare(
          (year: next.year, month: next.month, day: 1),
          widget.last,
        ) <=
        0;
  }

  @override
  Widget build(BuildContext context) {
    final tc = AppThemeColors.of(context);
    final days = HijriDate.daysInMonth(_year, _month);
    final firstWeekday = HijriDate.toGregorian(_year, _month, 1).weekday;
    // Week starts Saturday to match Gulf calendars: Sat=0 … Fri=6.
    final leading = (firstWeekday + 1) % 7;
    final weekdays = [
      AppStrings.hijriWeekdaySat,
      AppStrings.hijriWeekdaySun,
      AppStrings.hijriWeekdayMon,
      AppStrings.hijriWeekdayTue,
      AppStrings.hijriWeekdayWed,
      AppStrings.hijriWeekdayThu,
      AppStrings.hijriWeekdayFri,
    ];

    return Dialog(
      backgroundColor: tc.cardBackground,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: EdgeInsets.fromLTRB(16.width, 16.height, 16.width, 8.height),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppStrings.enterHijriDateHint,
              style: TextStyle(
                fontSize: context.responsiveFontScale(14),
                fontWeight: FontWeight.w700,
                color: tc.primaryBrand,
              ),
            ),
            4.height.toSizedBox,
            Text(
              HijriDate.formatParts(_year, _month, _day),
              style: TextStyle(
                fontSize: context.responsiveFontScale(16),
                fontWeight: FontWeight.w600,
                color: tc.textPrimary,
              ),
            ),
            12.height.toSizedBox,
            Row(
              children: [
                IconButton(
                  onPressed: _canGoPrev ? () => _shiftMonth(-1) : null,
                  icon: const Icon(Icons.chevron_left_rounded),
                  color: tc.primaryBrand,
                ),
                Expanded(
                  child: Text(
                    '${AppStrings.hijriMonth(_month)} $_year',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: context.responsiveFontScale(14),
                      fontWeight: FontWeight.w700,
                      color: tc.textPrimary,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: _canGoNext ? () => _shiftMonth(1) : null,
                  icon: const Icon(Icons.chevron_right_rounded),
                  color: tc.primaryBrand,
                ),
              ],
            ),
            8.height.toSizedBox,
            Row(
              children: weekdays
                  .map(
                    (label) => Expanded(
                      child: Text(
                        label,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: context.responsiveFontScale(11),
                          fontWeight: FontWeight.w600,
                          color: tc.textSecondary,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
            8.height.toSizedBox,
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: leading + days,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
              ),
              itemBuilder: (context, index) {
                if (index < leading) return const SizedBox.shrink();
                final day = index - leading + 1;
                final date = (year: _year, month: _month, day: day);
                final disabled = _isDisabled(date);
                final selected = _day == day;
                return InkWell(
                  onTap: disabled
                      ? null
                      : () => setState(() => _day = day),
                  borderRadius: BorderRadius.circular(20),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: selected ? tc.primaryBrand : Colors.transparent,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '$day',
                        style: TextStyle(
                          fontSize: context.responsiveFontScale(12),
                          fontWeight: FontWeight.w600,
                          color: disabled
                              ? tc.textSecondary.withValues(alpha: 0.4)
                              : selected
                              ? tc.onPrimary
                              : tc.textPrimary,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            8.height.toSizedBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(AppStrings.cancel),
                ),
                TextButton(
                  onPressed: _isDisabled(_selected)
                      ? null
                      : () => Navigator.of(context).pop(
                          HijriDate.toGregorian(_year, _month, _day),
                        ),
                  child: Text(AppStrings.confirm),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
