import 'package:flutter/material.dart';

import '../../../../../../../config/theme/app_theme_colors.dart';
 
class ChipGroupWidget extends StatelessWidget {
  const ChipGroupWidget({
    super.key,
    required this.label,
    required this.options,
    required this.selectedOptions,
    required this.onToggle,
  });

  final String label;
  final List<String> options;
  final List<String> selectedOptions;
  final Function(String) onToggle;

  @override
  Widget build(BuildContext context) {
    final tc = AppThemeColors.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label.isNotEmpty) ...[
          Text(
            label,
            style: TextStyle(
              fontSize: 14.fontSize,
              fontWeight: FontWeight.w600,
              color: tc.textFieldTitle,
            ),
          ),
          8.height.toSizedBox,
        ],
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: options.map((option) {
            final isSelected = selectedOptions.contains(option);
            return GestureDetector(
              onTap: () => onToggle(option),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.symmetric(
                  horizontal: 16.width,
                  vertical: 10.height,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? tc.primaryBrand : const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected ? tc.primaryBrand : const Color(0xFFE2E8F0),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      option,
                      style: TextStyle(
                        color: isSelected ? Colors.white : tc.textPrimary,
                        fontWeight: FontWeight.w600,
                        fontSize: 14.fontSize,
                      ),
                    ),
                    if (isSelected) ...[
                      SizedBox(width: 6.width),
                      const Icon(Icons.check, size: 16, color: Colors.white),
                    ],
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

extension on num {
  SizedBox get toSizedBox => SizedBox(height: toDouble(), width: toDouble());

  double get fontSize => toDouble();

  double get width => toDouble();

  double get height => toDouble();
}
