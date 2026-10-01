import 'package:flutter/material.dart';

import '../../../../../../core/utils/functions/responsive.dart';
import 'feedback_button.dart';

class FeedbackRow extends StatelessWidget {
  const FeedbackRow({
    super.key,
    required this.isFeedbackGiven,
    required this.isFeedbackPositive,
    required this.onFeedback,
  });

  final bool isFeedbackGiven;
  final bool isFeedbackPositive;
  final void Function(bool) onFeedback;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 4.height, bottom: 8.height),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FeedbackButton(
            icon: Icons.thumb_down_alt_outlined,
            isActive: isFeedbackGiven && !isFeedbackPositive,
            size: 38.width,
            iconSize: 20.fontSize,
            onTap: () => onFeedback(false),
          ),
          SizedBox(width: 10.width),
          FeedbackButton(
            icon: Icons.thumb_up_alt_outlined,
            isActive: isFeedbackGiven && isFeedbackPositive,
            size: 42.width,
            iconSize: 22.fontSize,
            onTap: () => onFeedback(true),
          ),
        ],
      ),
    );
  }
}
