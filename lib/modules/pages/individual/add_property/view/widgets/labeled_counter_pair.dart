import 'package:flutter/material.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import 'detail_counter.dart';

class LabeledCounterPair extends StatelessWidget {
  const LabeledCounterPair({
    super.key,
    required this.firstLabel,
    required this.firstKey,
    required this.secondLabel,
    required this.secondKey,
  });

  final String firstLabel;
  final String firstKey;
  final String secondLabel;
  final String secondKey;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: DetailCounter(label: firstLabel, detailKey: firstKey),
        ),
        SizedBox(width: 12.width),
        Expanded(
          child: DetailCounter(label: secondLabel, detailKey: secondKey),
        ),
      ],
    );
  }
}
