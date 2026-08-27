import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../controller/add_property_bloc.dart';

class PeriodOption extends StatelessWidget {
  const PeriodOption({
    super.key,
    required this.period,
    required this.label,
    required this.subtitle,
    required this.icon,
  });
  final String period;
  final String label;
  final String subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final tc = AppThemeColors.of(context);
    return BlocBuilder<AddPropertyBloc, AddPropertyState>(
      buildWhen: (prev, curr) =>
          prev.model.rentalPeriod != curr.model.rentalPeriod,
      builder: (context, state) {
        final isSelected = state.model.rentalPeriod == period;
        return GestureDetector(
          onTap: () =>
              AddPropertyBloc.get(context).add(SelectRentalPeriodEvent(period)),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: EdgeInsets.symmetric(
              horizontal: 16.width,
              vertical: 8.height,
            ),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(14)),
            child: Row(
              children: [
                Container(
                  width: 25.width,
                  height: 25.width,
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    border: Border.all(color: tc.primaryBrand),
                    shape: BoxShape.circle,
                  ),
                  child: CircleAvatar(
                    backgroundColor: isSelected
                        ? tc.primaryBrand
                        : tc.onPrimary,
                  ),
                ),
                12.width.toSizedBox,
                Expanded(
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize: context.responsiveFontScale(15),
                      fontWeight: FontWeight.w700,
                      color: isSelected ? tc.primaryBrand : tc.textPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
