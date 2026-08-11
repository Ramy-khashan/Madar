import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../controller/add_property_bloc.dart';

class ChipRowItem<T> extends StatelessWidget {
  const ChipRowItem({super.key, 
    required this.options,
    required this.getLabel,
    required this.isSelected,
    required this.onTap,
  });
  final List<T> options;
  final String Function(T) getLabel;
  final bool Function(T, AddPropertyState) isSelected;
  final void Function(T, BuildContext) onTap;

  @override
  Widget build(BuildContext context) {
    final tc = AppThemeColors.of(context);
    return BlocBuilder<AddPropertyBloc, AddPropertyState>(
      builder: (context, state) {
        return Wrap(
          spacing: 8,
          runSpacing: 8,
          children: options.map((option) {
            final selected = isSelected(option, state);
            return GestureDetector(
              onTap: () => onTap(option, context),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.symmetric(
                  horizontal: 14.width,
                  vertical: 8.height,
                ),
                decoration: BoxDecoration(
                  color: selected ? tc.primaryBrand : const Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(24),
                   
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (selected) ...[
                      Icon(Icons.check_rounded, size: 14, color: tc.onPrimary),
                     SizedBox(width: 2.width),
                    ],
                    Text(
                      getLabel(option),
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
    );
  }
}
