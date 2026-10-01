import 'package:flutter/material.dart';
import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../../../../../core/utils/functions/translation.dart';
import '../../controller/add_property_bloc.dart';
import 'detail_builder.dart';

class DetailMultiChips extends StatelessWidget {
  const DetailMultiChips({
    super.key,
    required this.label,
    required this.detailKey,
    required this.options,
  });

  final String label;
  final String detailKey;
  final List<String> options;

  @override
  Widget build(BuildContext context) {
    final tc = AppThemeColors.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16.height),
        Text(
          label,
          style: TextStyle(
            fontSize: context.responsiveFontScale(15),
            fontWeight: FontWeight.w700,
            color: tc.textPrimary,
          ),
        ),
        SizedBox(height: 12.height),
        DetailBuilder(
          detailKey: detailKey,
          builder: (context, bloc, value) {
            final selectedValues =
                (value as List<dynamic>?)?.cast<String>() ?? const <String>[];
            return Wrap(
              spacing: 8,
              runSpacing: 8,
              children: options.map((option) {
                final selected = selectedValues.contains(option);
                return GestureDetector(
                  onTap: () =>
                      bloc.add(ToggleDetailListItemEvent(detailKey, option)),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: EdgeInsets.symmetric(
                      horizontal: 14.width,
                      vertical: 8.height,
                    ),
                    decoration: BoxDecoration(
                      color: selected
                          ? tc.primaryBrand
                          : const Color(0xFFF3F4F6),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (selected) ...[
                          Icon(
                            Icons.check_rounded,
                            size: 14,
                            color: tc.onPrimary,
                          ),
                          SizedBox(width: 2.width),
                        ],
                        Text(
                          option.trans,
                          style: TextStyle(
                            fontSize: context.responsiveFontScale(12),
                            fontWeight: selected
                                ? FontWeight.w700
                                : FontWeight.w500,
                            color: selected ? tc.onPrimary : tc.primaryBrand,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }
}
