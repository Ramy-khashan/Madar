import 'package:flutter/material.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/model/property_filter_model.dart';
import '../../../../../../core/utils/constants/app_colors.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/common_fun.dart';
import '../../../../../../core/utils/functions/responsive.dart';

class FilterPriceRange extends StatelessWidget {
  const FilterPriceRange({
    super.key,
    required this.minPrice,
    required this.maxPrice,
    required this.onChanged,
  });

  final double minPrice;
  final double maxPrice;
  final ValueChanged<RangeValues> onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${formatPrice(minPrice)} ${AppStrings.currency}',
              style: TextStyle(
                fontSize: context.responsiveFontScale(13),
                color: colors.textSecondary,
              ),
            ),
            Text(
              '${formatPrice(maxPrice)} ${AppStrings.currency}',
              style: TextStyle(
                fontSize: context.responsiveFontScale(13),
                color: colors.textSecondary,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.height),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: AppColors.secondBrand,
            thumbColor: AppColors.secondBrand,
            inactiveTrackColor: AppColors.secondBrand.withValues(alpha: 0.2),
            trackHeight: 4,
            rangeThumbShape: const RoundRangeSliderThumbShape(
              enabledThumbRadius: 10,
            ),
            overlayShape: const RoundSliderOverlayShape(overlayRadius: 18),
          ),
          child: RangeSlider(
            values: RangeValues(minPrice, maxPrice),
            min: PropertyFilterModel.kMinPrice,
            max: PropertyFilterModel.kMaxPrice,
            divisions: 80,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
