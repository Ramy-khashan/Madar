import 'package:flutter/cupertino.dart';
import '../../../../../../core/utils/constants/app_colors.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';

class CountdownRow extends StatelessWidget {
  const CountdownRow({super.key, required this.endTime});
  final DateTime endTime;

  String _formatDuration(Duration d) {
    if (d.isNegative) return '00:00:00';
    final h = d.inHours.toString().padLeft(2, '0');
    final m = (d.inMinutes % 60).toString().padLeft(2, '0');
    return '$h ${AppStrings.hoursLabel} $m ${AppStrings.minutesLabel}';
  }

  @override
  Widget build(BuildContext context) {
    final remaining = endTime.difference(DateTime.now());
    return Row(
      children: [
        Icon(
          CupertinoIcons.clock,
          size: 16.width,
          color: AppColors.secondBrand,
          weight: .9,
        ),
        SizedBox(width: 4.width),
        Text(
          _formatDuration(remaining),
          style: TextStyle(
            fontSize: context.responsiveFontScale(14),
            fontFamily: AppConstant.appFont,
            color: AppColors.secondBrand,
          ),
        ),
      ],
    );
  }
}
