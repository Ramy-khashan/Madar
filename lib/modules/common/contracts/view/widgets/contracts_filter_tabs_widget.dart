import 'package:flutter/material.dart';

import '../../../../../config/theme/app_theme_colors.dart';
import '../../../../../core/utils/functions/responsive.dart';
import '../../controller/contracts_bloc.dart';

class ContractsFilterTabsWidget extends StatelessWidget {
  const ContractsFilterTabsWidget({
    super.key,
    required this.selectedFilter,
    required this.totalCount,
    required this.counts,
    required this.onFilterChanged,
  });

  final String selectedFilter;
  final int totalCount;
  final Map<String, int> counts;
  final void Function(String) onFilterChanged;

  int _countFor(String id) {
    if (id == 'ALL') return counts['all'] ?? totalCount;
    return counts[id] ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(
        horizontal: context.responsiveHorizontalPadding,
        vertical: 12.height,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: ContractsBloc.tabs.map((entry) {
          final isSelected = selectedFilter == entry.id;
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsetsDirectional.only(start: 8.width),
            child: GestureDetector(
              onTap: () => onFilterChanged(entry.id),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                padding: EdgeInsets.symmetric(
                  horizontal: 14.width,
                  vertical: 8.height,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? colors.primaryBrand
                      : colors.cardBackground,
                  borderRadius: BorderRadius.circular(32.radius),
                  border: Border.all(
                    color: isSelected
                        ? colors.primaryBrand
                        : colors.borderColor,
                  ),
                ),
                child: Text(
                  '${entry.title} (${_countFor(entry.id)})',
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(13),
                    fontWeight: FontWeight.w600,
                    color: isSelected ? colors.onPrimary : colors.textSecondary,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
